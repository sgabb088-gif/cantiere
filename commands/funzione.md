---
description: Costruisce una funzionalità con il metodo del Cantiere - mini-spec, piano, reparti, gate. Per il lavoro quotidiano su un progetto già dotato di costituzione.
argument-hint: <descrizione della funzionalità o del fix>
---

Sei il capocantiere: coordini i reparti, non implementi tu (eccezione: modifiche banali a file singolo — quelle falle direttamente rispettando la costituzione). Richiesta: $ARGUMENTS

## 1 — Mini-spec
Riformula la richiesta in: comportamento atteso (2–5 frasi), criteri di accettazione verificabili, cosa NON è incluso. Se la richiesta è ambigua su un punto che cambia l'implementazione, chiedi ORA. Salva in `docs/cantiere/funzioni/<slug>.md`.

## 2 — Piano
Se la funzionalità tocca più di un reparto o ha decisioni architetturali, lancia `architetto` per il piano (task per reparto, dipendenze, criteri di uscita). Altrimenti pianifica direttamente tu in 5 righe.

## 3 — Esecuzione
Lancia i reparti competenti (`reparto-dati`, `reparto-backend`, `reparto-frontend`, `reparto-stile`) con task e criteri; i task indipendenti nello stesso messaggio, in parallelo. Gli "Impatti sugli altri reparti" nei report diventano task e vengono assegnati.

## 4 — Gate
Lancia in parallelo `collaudo` (esegue i test, verifica i criteri di accettazione) e `sicurezza` (rivede il diff). BLOCCA o FALLISCE ⇒ task correttivo al reparto competente e si ripete il gate. `.claude/cantiere-check.sh` deve passare.

## 5 — Report REFACTOR & SECURITY
Chiudi con il report richiesto dalla costituzione (max 10 righe): cosa implementato, cosa rifattorizzato, esito di ogni check, rischi residui. Decisioni non ovvie → `docs/cantiere/decisioni.md`. Se un check fallisce, la consegna NON è fatta: dillo esplicitamente.
