<?php

function detectOS(string $userAgent): string
{
    if (stripos($userAgent, 'Android') !== false) {
        return 'Android';
    }

    if (
        stripos($userAgent, 'iPhone') !== false ||
        stripos($userAgent, 'iPad') !== false
    ) {
        return 'iOS';
    }

    if (stripos($userAgent, 'Windows') !== false) {
        return 'Windows';
    }

    if (stripos($userAgent, 'Macintosh') !== false) {
        return 'macOS';
    }

    if (stripos($userAgent, 'Linux') !== false) {
        return 'Linux';
    }

    return 'Unknown OS';
}


function detectBrowser(string $userAgent): string
{
    if (
        stripos($userAgent, 'Edg/') !== false ||
        stripos($userAgent, 'EdgiOS/') !== false ||
        stripos($userAgent, 'EdgA/') !== false
    ) {
        return 'Edge';
    }

    if (
        stripos($userAgent, 'OPR/') !== false ||
        stripos($userAgent, 'Opera') !== false
    ) {
        return 'Opera';
    }

    if (stripos($userAgent, 'SamsungBrowser/') !== false) {
        return 'Samsung Internet';
    }

    if (
        stripos($userAgent, 'Firefox/') !== false ||
        stripos($userAgent, 'FxiOS/') !== false
    ) {
        return 'Firefox';
    }

    if (
        stripos($userAgent, 'Chrome/') !== false ||
        stripos($userAgent, 'CriOS/') !== false ||
        stripos($userAgent, 'Chromium/') !== false
    ) {
        return 'Chrome';
    }

    if (stripos($userAgent, 'Safari/') !== false) {
        return 'Safari';
    }

    return 'Unknown Browser';
}


$date = date('Y-m-d H:i:s');
$ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
$method = $_SERVER['REQUEST_METHOD'] ?? 'unknown';
$uri = $_SERVER['REQUEST_URI'] ?? 'unknown';
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';

$os = detectOS($userAgent);
$browser = detectBrowser($userAgent);

error_log("[$date] $ip | $os | $browser | $method $uri");

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);
$path = is_string($path) ? rawurldecode($path) : '/';

// Reject simple path traversal attempts before mapping a URL to a file.
if (preg_match('#(^|/)\.\.(/|$)#', $path)) {
    http_response_code(400);
    exit('Bad Request');
}

if ($path === '/') {
    readfile(__DIR__ . '/index.html');
    exit;
}

$file = __DIR__ . $path;

/*
 * Existing PHP files must be executed by PHP,
 * not returned as plain files.
 */
if (
    is_file($file) &&
    strtolower(pathinfo($file, PATHINFO_EXTENSION)) === 'php'
) {
    return false;
}

/*
 * Let the built-in PHP server handle existing
 * static files such as HTML, CSS, JS and favicon.
 */
if (is_file($file)) {
    return false;
}

http_response_code(404);
echo '404 Not Found';
