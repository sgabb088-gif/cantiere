---
name: standard-sicurezza
description: Checklist di sicurezza del Cantiere - validazione, autorizzazioni, injection, segreti, privacy, dipendenze. Da caricare prima di ogni revisione di sicurezza.
---

# Standard sicurezza del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto. La revisione cerca casi di fallimento CONCRETI (input reale → danno reale), non teoria.

## Checklist
1. **Validazione al confine**: ogni input esterno (body, query, header, file, webhook) validato lato server per tipo, formato, lunghezza, range. Il client non conta.
2. **Autorizzazioni**: ogni endpoint/query verifica autenticazione E proprietà/ruolo sulla risorsa specifica (mai fidarsi di un id passato dal client). Default-deny nel DB (RLS dove disponibile).
3. **Injection**: SQL parametrizzato sempre; output HTML con escape o sanitizzazione (XSS); mai input utente in comandi shell o percorsi file (path traversal) senza whitelist.
4. **Segreti**: solo variabili d'ambiente; mai in client, repo, log, URL. Le chiavi privilegiate mai raggiungibili dal browser.
5. **Sessioni e auth**: token con scadenza, cookie `HttpOnly`+`Secure`+`SameSite`, logout che invalida davvero, rate limiting su login/registrazione/recupero.
6. **Privacy**: dati minimi raccolti e conservati; niente PII in log e URL; cancellazione effettiva dove promessa; file utente in storage privato con accesso firmato.
7. **Upload**: tipo e dimensione verificati server-side, nomi file rigenerati, mai serviti dalla stessa origine con esecuzione possibile.
8. **Dipendenze**: audit del package manager quando i lockfile cambiano; niente pacchetti abbandonati nei percorsi critici.
9. **Headers**: CSP, `X-Content-Type-Options: nosniff`, HSTS in produzione dove applicabile.

## Gravità
CRITICO = sfruttabile da remoto senza credenziali o con perdita dati. ALTO = sfruttabile da utente autenticato oltre i suoi permessi. MEDIO = richiede condizioni particolari. BASSO = difesa in profondità. CRITICO o ALTO ⇒ la consegna è bloccata.

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
