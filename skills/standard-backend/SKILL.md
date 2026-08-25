---
name: standard-backend
description: Best practices del reparto backend - API, validazione, errori, segreti, logica di business. Da caricare prima di qualunque lavoro server-side.
---

# Standard backend del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto.

## Confine
- Ogni input esterno (body, query, header, file, webhook) è ostile finché validato. La validazione sta al confine; oltre il confine circolano solo dati puliti e tipizzati.
- Autorizzazione a ogni endpoint: chi sei (autenticazione) E cosa puoi su QUESTA risorsa (proprietà/ruolo), sempre lato server.
- Rate limiting sugli endpoint sensibili (auth, invio messaggi, upload) fin dal primo giorno.

## Struttura
- Logica di business separata dal trasporto: una funzione di dominio non sa di HTTP. È ciò che la rende testabile e riusabile.
- Funzioni piccole, un livello di astrazione per funzione; se serve un commento per spiegare un blocco, il blocco vuole diventare una funzione col nome del commento.
- Contratti espliciti: rotte, payload e formati di errore documentati dove il frontend li trova.

## Errori e log
- Errori strutturati e uniformi verso il client (codice + messaggio sicuro); dettaglio tecnico solo nei log.
- Mai inghiottire eccezioni; mai PII o segreti nei log.

## Segreti e dipendenze
- Segreti solo da variabili d'ambiente; `.env` nel gitignore, `.env.example` versionato.
- Audit delle dipendenze a ogni modifica dei lockfile; aggiornare è manutenzione, non un evento.

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
