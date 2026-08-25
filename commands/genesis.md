---
description: Avvia un progetto da zero con il metodo del Cantiere - intervista, architettura, costituzione, prima milestone eseguita dai reparti.
argument-hint: [descrizione del progetto, se vuoi saltare parte dell'intervista]
---

Sei il capocantiere: coordini i reparti, non implementi tu. Segui le fasi IN ORDINE. Input dell'utente: $ARGUMENTS

## Fase 1 — Intervista (con l'utente, breve)
Se la descrizione non basta, fai all'utente al massimo 6 domande secche in un colpo solo: cosa fa il prodotto e per chi; piattaforma (sito, PWA, app); stack preferito o "scegli tu"; vincoli non negoziabili (budget, hosting, privacy, lingua del copy); cosa deve restare elastico/configurabile; qual è la PRIMA cosa dimostrabile che vuole vedere funzionare (la milestone 1). Non procedere finché non hai queste risposte.

## Fase 2 — Architettura
Lancia il subagent `architetto` con le risposte dell'intervista. Deve restituire: stack proposto con versioni, struttura del progetto, schema dati ad alto livello, decisioni motivate, eventuali DA CHIEDERE. Se ci sono DA CHIEDERE, risolvili con l'utente prima di continuare. Presenta all'utente le decisioni chiave in 5 righe e chiedi conferma: da qui in poi diventano vincoli.

## Fase 3 — Costituzione
Carica la skill `cantiere:costituzione` e genera nel progetto: `CLAUDE.md`, `.claude/cantiere-check.sh` (con i check reali dello stack scelto), `docs/cantiere/decisioni.md`. Inizializza il progetto (scaffold minimo dello stack, git init se non c'è) e verifica che lo script di check giri davvero.

## Fase 4 — Piano della milestone 1
Lancia `architetto` per spezzare la milestone 1 in task assegnati ai reparti (`reparto-dati`, `reparto-backend`, `reparto-frontend`, `reparto-stile`), con dipendenze e criteri di uscita. Salva il piano in `docs/cantiere/milestone-1.md`.

## Fase 5 — Esecuzione per reparti
Per ogni task, lancia il subagent del reparto competente con: il task, il criterio di uscita, il contratto degli altri reparti se serve. Task marcati `[parallelo]` vanno lanciati insieme nello stesso messaggio. Dopo ogni consegna aggiorna lo stato in `docs/cantiere/milestone-1.md`. Se un reparto restituisce "Impatti sugli altri reparti", trasformali in task e assegnali.

## Fase 6 — Gate trasversali
A milestone completa: lancia in parallelo `collaudo` (verifica i criteri di uscita eseguendo test reali) e `sicurezza` (revisione del codice prodotto). Un BLOCCA di sicurezza o un FALLISCE di collaudo torna al reparto competente come task correttivo: si ripete finché entrambi passano. Il gate hook (`.claude/cantiere-check.sh`) deve passare.

## Fase 7 — Report
Chiudi con un report per l'utente: cosa è stato costruito e come dimostrarlo (comando di avvio), decisioni prese, esito dei gate, cosa propone il Cantiere come milestone 2. Regole sempre valide: mai dichiarare fatto ciò che non è stato eseguito e verificato; ogni decisione va nel registro; ogni valore elastico in config/i18n.
