/**
 * Service Worker for Warehouse Inventory System
 * Provides offline support and caching for production
 */

const CACHE_NAME = 'warehouse-v1.1.4';
// Only pre-cache static assets. Do not pre-cache pages/HTML.
const urlsToCache = [
    '/wp-content/themes/warehouse-inventory/assets/css/production.css',
    '/wp-content/themes/warehouse-inventory/assets/js/production.js',
    '/wp-content/themes/warehouse-inventory/assets/css/animations.css',
    '/wp-content/themes/warehouse-inventory/assets/js/theme-toggle.js',
    '/wp-content/themes/warehouse-inventory/assets/js/loading-manager.js',
    '/wp-content/plugins/warehouse-inventory-manager/assets/css/admin.css',
    '/wp-content/plugins/warehouse-inventory-manager/assets/js/admin.js',
    '/wp-content/plugins/warehouse-inventory-manager/assets/css/frontend.css',
    '/wp-content/plugins/warehouse-inventory-manager/assets/js/frontend.js',
    '/wp-includes/css/dist/block-library/style.min.css',
    '/wp-includes/js/jquery/jquery.min.js'
];

// Install event - cache resources
self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('Warehouse SW: Caching resources');
                return cache.addAll(urlsToCache);
            })
    );
    self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Warehouse SW: Deleting old cache', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

// Fetch event
self.addEventListener('fetch', (event) => {
    // Skip non-GET requests
    if (event.request.method !== 'GET') {
        return;
    }

    // Skip cross-origin requests
    if (!event.request.url.startsWith(self.location.origin)) {
        return;
    }

    const url = new URL(event.request.url);

    // Never intercept admin, login, or AJAX/REST calls
    if (event.request.url.includes('/wp-admin') || 
        event.request.url.includes('/wp-login') ||
        url.pathname.includes('/admin-ajax.php') ||
        url.pathname.startsWith('/wp-json/')) {
        return;
    }

    // Determine if this is a navigation/HTML request → use network-first
    const accept = event.request.headers.get('accept') || '';
    const isHTML = event.request.mode === 'navigate' || accept.includes('text/html');

    if (isHTML) {
        // Do NOT cache HTML to prevent stale pages after updates
        event.respondWith(fetch(event.request).catch(() => caches.match(event.request)));
        return;
    }

    // Static assets (CSS/JS/images): stale-while-revalidate
    event.respondWith(
        caches.match(event.request).then((cached) => {
            const fetchPromise = fetch(event.request).then((networkResponse) => {
                if (networkResponse && networkResponse.status === 200) {
                    const copy = networkResponse.clone();
                    caches.open(CACHE_NAME).then((cache) => cache.put(event.request, copy));
                }
                return networkResponse;
            }).catch(() => cached);
            return cached || fetchPromise;
        })
    );
});

// Background sync for offline actions
self.addEventListener('sync', (event) => {
    if (event.tag === 'warehouse-sync') {
        event.waitUntil(syncWarehouseData());
    }
});

// Sync warehouse data when back online
async function syncWarehouseData() {
    try {
        const cache = await caches.open(CACHE_NAME);
        const requests = await cache.keys();
        
        return Promise.all(
            requests.map(async (request) => {
                try {
                    const response = await fetch(request);
                    if (response.ok) {
                        await cache.put(request, response);
                    }
                } catch (error) {
                    console.error('Sync failed for:', request.url);
                }
            })
        );
    } catch (error) {
        console.error('Sync error:', error);
    }
}

// Push notifications
self.addEventListener('push', (event) => {
    if (!event.data) return;

    const data = event.data.json();
    const options = {
        body: data.body,
        icon: '/wp-content/themes/warehouse-inventory/assets/images/icon-192.png',
        badge: '/wp-content/themes/warehouse-inventory/assets/images/badge-72.png',
        vibrate: [200, 100, 200],
        tag: 'warehouse-notification',
        actions: [
            {
                action: 'view',
                title: 'View Details'
            },
            {
                action: 'dismiss',
                title: 'Dismiss'
            }
        ]
    };

    event.waitUntil(
        self.registration.showNotification(data.title, options)
    );
});

// Notification click handler
self.addEventListener('notificationclick', (event) => {
    event.notification.close();

    if (event.action === 'view') {
        event.waitUntil(
            clients.openWindow('/warehouse-dashboard/')
        );
    }
});

// Message handler for updates
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }
    if (event.data && event.data.type === 'PURGE_URL' && event.data.url) {
        event.waitUntil((async () => {
            const keys = await caches.keys();
            await Promise.all(keys.map(async (key) => {
                const cache = await caches.open(key);
                const requests = await cache.keys();
                await Promise.all(requests.map((req) => {
                    if (req.url === event.data.url) {
                        return cache.delete(req);
                    }
                }));
            }));
        })());
    }
});
