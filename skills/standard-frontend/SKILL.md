---
name: standard-frontend
description: Best practices del reparto frontend - componenti, stato, i18n, accessibilità, integrazione API. Da caricare prima di qualunque lavoro client-side.
---

# Standard frontend del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto.

## Componenti e stato
- Componenti piccoli con una responsabilità; se un componente supera ~150 righe o gestisce tre preoccupazioni, va spezzato.
- Stato minimo: deriva ciò che puoi, memorizza solo ciò che devi; ogni dato duplicato in due stati è un bug futuro.
- Le regole di business vivono nel backend: il client le riflette, non le duplica (la validazione client è UX, quella server è legge).

## Testi e valori
- Nessuna stringa visibile hardcodata nei componenti: copy in i18n/config secondo la convenzione del progetto.
- Nessun valore di brand (nomi, prezzi, soglie) nel codice: solo da config.

## Accessibilità
- HTML semantico prima di ARIA: `button` per azioni, `a` per navigazione, `label` per ogni input, heading in ordine.
- Tutto raggiungibile e usabile da tastiera; focus visibile sempre.
- Immagini con `alt` sensato (o vuoto se decorative).

## Robustezza
- Ogni chiamata API gestisce i tre stati: caricamento, successo, errore. L'errore mostra qualcosa di utile, mai una UI congelata.
- TypeScript strict dove c'è TS: zero `any` non giustificati.
- Mai inserire HTML da input utente senza sanitizzazione (XSS).

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
