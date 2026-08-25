---
name: standard-test
description: Best practices del collaudo - strategia di test, cosa coprire, come scrivere test che valgono. Da caricare prima di scrivere o valutare test.
---

# Standard test del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto.

## Strategia
- Piramide sostenibile: molti unit sulla logica di dominio, integration sui confini (API↔DB), pochi e2e sui flussi vitali.
- Si testano i comportamenti promessi e i bordi (vuoto, limite, errore a metà), non i dettagli di implementazione: un refactoring a comportamento invariato non deve rompere i test.
- Ogni bug corretto lascia un test che lo riprodurrebbe: è il prezzo del fix.

## Qualità dei test
- Un test che non può fallire non vale niente: verificalo facendolo fallire almeno una volta (o scrivendolo prima del codice).
- Nomi che descrivono il comportamento ("rifiuta CF con checksum errato"), non il metodo ("test1").
- Test indipendenti e riproducibili: niente ordine implicito, niente rete reale, niente orologio di sistema non controllato.
- Un test flaky è un bug da aprire, non da riprovare.

## Lezioni apprese
- Node 25: `node --test <directory>/` NON scopre i test (tenta il require della directory). Usare `node --test` senza argomenti o con glob di file (`node --test test/*.test.js`). [collaudo Cantiere, 2026-08-25]

## Esecuzione
- La suite intera si esegue a ogni consegna, non solo i test nuovi.
- L'output dei comandi si riporta reale: mai dichiarare "passa" senza aver eseguito.
- La copertura è una bussola sulle regole di business, non un obiettivo numerico da gonfiare.

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
