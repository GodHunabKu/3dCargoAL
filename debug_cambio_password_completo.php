<?php
// DEBUG CAMBIO PASSWORD - VERSIONE SENZA LOGIN
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<!DOCTYPE html><html><head><title>Debug Cambio Password</title>";
echo "<style>
body{font-family:monospace;background:#000;color:#0f0;padding:20px;line-height:1.8;}
.step{background:#1a1a1a;border-left:4px solid #0f0;padding:15px;margin:10px 0;}
.step h3{margin:0 0 10px 0;color:#0ff;}
.ok{color:#0f0;} .err{color:#f00;} .warn{color:#ff0;}
.code{background:#2a2a2a;padding:10px;margin:10px 0;border:1px solid #333;}
input{padding:10px;font-size:16px;width:300px;}
button{padding:10px 20px;font-size:16px;background:#0f0;color:#000;border:none;cursor:pointer;margin-left:10px;}
pre{margin:0;}
</style></head><body>";

echo "<h1>?? DEBUG CAMBIO PASSWORD</h1>";

if(!isset($_POST['test_account_id'])) {
    echo "<p>Inserisci l'ID del tuo account per testare:</p>";
    echo "<form method='POST'>";
    echo "<input type='number' name='test_account_id' placeholder='ID Account (es: 1)' required>";
    echo "<button type='submit'>TEST</button>";
    echo "</form>";
    echo "<br><hr><br>";
    echo "<p><strong>Come trovare il tuo ID account:</strong></p>";
    echo "<p>1. Login al sito<br>";
    echo "2. Vai in Pannello Amministrazione<br>";
    echo "3. Guarda URL: https://oneshyra.eu/user/newadministration<br>";
    echo "4. Oppure guarda nel database tabella 'account'</p>";
    die();
}

require_once 'config.php';
require_once 'include/functions/basic.php';
require_once 'include/classes/user.php';

$database = new USER($host, $user, $password);

$test_id = intval($_POST['test_account_id']);

echo "<p>Test con Account ID: <strong>$test_id</strong></p><hr>";

echo "<div class='step'>";
echo "<h3>STEP 1: Recupero dati account</h3>";
try {
    $account_name = getAccountName($test_id);
    $myEmail = getAccountEmail($test_id);
    echo "Account: <span class='ok'>$account_name</span><br>";
    echo "Email: <span class='ok'>$myEmail</span>";
} catch (Exception $e) {
    echo "<span class='err'>? ERRORE: Account ID non trovato!</span>";
    die();
}
echo "</div>";

$lang = [
    'password' => 'Password',
    'change-password' => 'Cambia Password',
    'sended-code' => 'Email inviata! Controlla la tua casella di posta.'
];

echo "<div class='step'>";
echo "<h3>STEP 2: Generazione codice recovery</h3>";
$code = generateSocialID(32);
echo "Codice generato: <span class='ok'>" . substr($code, 0, 15) . "...</span>";
echo "</div>";

echo "<div class='step'>";
echo "<h3>STEP 3: Aggiornamento database</h3>";
try {
    update_passlost_token_by_email($myEmail, $code);
    echo "<span class='ok'>? Token aggiornato nel database</span>";
} catch (Exception $e) {
    echo "<span class='err'>? ERRORE: " . $e->getMessage() . "</span>";
}
echo "</div>";

echo "<div class='step'>";
echo "<h3>STEP 4: Creazione link email</h3>";
$code_link = '<br><br><a href="'.$site_url.'user/password/'.$code.'">Cambia Password</a>';
echo "<span class='ok'>? Link creato</span>";
echo "</div>";

echo "<div class='step'>";
echo "<h3>STEP 5: Preparazione email</h3>";
$html_mail = sendCode($account_name, $code_link, 4);
$alt_message = $lang['password'];
$subject = $lang['password'];
$sendName = $account_name;
$sendEmail = $myEmail;
echo "Destinatario: <span class='ok'>$sendEmail</span><br>";
echo "Oggetto: <span class='ok'>$subject</span>";
echo "</div>";

echo "<div class='step'>";
echo "<h3>STEP 6: Invio email (CRITICO)</h3>";

if(!file_exists('include/functions/sendEmail.php')) {
    echo "<span class='err'>? ERRORE: sendEmail.php NON TROVATO!</span>";
} else {
    echo "<span class='ok'>? File sendEmail.php trovato</span><br>";
    
    ob_start();
    include 'include/functions/sendEmail.php';
    $email_output = ob_get_clean();
    
    echo "<br><strong>Controlla variabile \$email_sent_successfully:</strong><br>";
    
    if(isset($email_sent_successfully)) {
        echo "<span class='ok'>? Variabile IMPOSTATA</span><br>";
        echo "Valore: <strong>" . ($email_sent_successfully ? 'TRUE' : 'FALSE') . "</strong><br>";
        
        if($email_sent_successfully) {
            echo "<br><span class='ok'>??? EMAIL INVIATA CON SUCCESSO!</span>";
        } else {
            echo "<br><span class='err'>? Invio email FALLITO</span>";
        }
    } else {
        echo "<span class='err'>??? VARIABILE NON IMPOSTATA!</span><br>";
        echo "<span class='err'>QUESTO È IL PROBLEMA!</span><br><br>";
        echo "Il file sendEmail.php NON imposta \$email_sent_successfully.<br>";
        echo "<strong>DEVI SOSTITUIRE sendEmail.php con sendEmail_PER_NEWADMIN.php</strong>";
    }
    
    if(!empty($email_output)) {
        echo "<br><br><strong>Output da sendEmail.php:</strong>";
        echo "<div class='code'>" . htmlspecialchars($email_output) . "</div>";
    }
}
echo "</div>";

echo "<div class='step'>";
echo "<h3>STEP 7: Creazione notifica</h3>";

if(isset($email_sent_successfully)) {
    $notification = $email_sent_successfully ?
        ['type' => 'success', 'title' => 'Email Inviata!', 'message' => $lang['sended-code']] :
        ['type' => 'error', 'title' => 'Errore', 'message' => 'Impossibile inviare l\'email'];
    
    echo "<span class='ok'>? Notifica creata</span><br>";
    echo "<div class='code'><pre>" . print_r($notification, true) . "</pre></div>";
    
    echo "<br><strong>Preview notifica:</strong><br>";
    echo '<div style="background:' . ($notification['type']=='success'?'#d4edda':'#f8d7da') . ';';
    echo 'border:2px solid ' . ($notification['type']=='success'?'#28a745':'#dc3545') . ';';
    echo 'color:' . ($notification['type']=='success'?'#155724':'#721c24') . ';';
    echo 'padding:20px;margin:20px 0;border-radius:8px;">';
    echo '<strong style="font-size:18px;">' . $notification['title'] . '</strong><br>';
    echo '<p style="margin:10px 0 0 0;">' . $notification['message'] . '</p>';
    echo '</div>';
    
} else {
    echo "<span class='err'>? Notifica NON creata</span><br>";
    echo "<span class='err'>Causa: \$email_sent_successfully non impostata</span>";
}
echo "</div>";

echo "<hr>";
echo "<div class='step'>";
echo "<h3>?? CONCLUSIONE</h3>";

if(isset($email_sent_successfully)) {
    if($email_sent_successfully) {
        echo "<span class='ok' style='font-size:20px;'>??? TUTTO FUNZIONA!</span><br><br>";
        echo "Il sistema email funziona correttamente.<br><br>";
        echo "<strong>Se nel sito NON vedi la notifica:</strong><br>";
        echo "1. CSS nasconde .notification<br>";
        echo "2. JavaScript rimuove l'alert<br>";
        echo "3. Redirect cancella tutto<br><br>";
        echo "Controlla il file CSS per la classe .notification";
    } else {
        echo "<span class='err' style='font-size:20px;'>? EMAIL NON INVIATA</span><br><br>";
        echo "Sendmail ha fallito. Controlla log errori PHP.";
    }
} else {
    echo "<span class='err' style='font-size:20px;'>??? PROBLEMA CRITICO!</span><br><br>";
    echo "Il file <strong>sendEmail.php</strong> NON imposta \$email_sent_successfully<br><br>";
    echo "<strong>SOLUZIONE IMMEDIATA:</strong><br>";
    echo "1. Scarica: <a href='https://claude.ai/...' style='color:#0ff;'>sendEmail_PER_NEWADMIN.php</a><br>";
    echo "2. Rinomina in: sendEmail.php<br>";
    echo "3. Sostituisci: include/functions/sendEmail.php<br>";
    echo "4. Ricarica questa pagina e rifai il test";
}

echo "</div>";

echo "</body></html>";
?>