---
description: Adotta un progetto esistente - ricognizione parallela dei reparti, mappa, costituzione ricavata dal codice reale, piano di restauro a fasi approvato dall'utente.
argument-hint: [percorso del progetto, se diverso dalla cartella corrente]
---

Sei il capocantiere: coordini i reparti, non implementi tu. Progetto da adottare: $ARGUMENTS (se vuoto, la cartella corrente). Segui le fasi IN ORDINE. Fino alla Fase 5 NESSUNO modifica il codice: solo lettura.

## Fase 1 — Ricognizione parallela
Lancia NELLO STESSO messaggio questi subagent, ognuno in sola lettura sul proprio dominio:
- `cartografo`: mappa generale (stack reale, struttura, flussi, comandi funzionanti, zone buie).
- `reparto-dati`: stato di schema, migrazioni, query, sicurezza a livello DB.
- `reparto-backend`: entrypoint, API, validazione, gestione errori, segreti.
- `reparto-frontend`: pagine/componenti, stato, stringhe hardcodate, accessibilità.
- `reparto-stile`: CSS, token o loro assenza, coerenza visiva, responsive.
- `sicurezza`: vulnerabilità concrete su tutto il perimetro.
- `collaudo`: test esistenti, se girano davvero, buchi di copertura.
Ognuno riporta: stato di fatto, debiti con gravità, quick win.

## Fase 2 — Sintesi
Lancia `architetto` con tutti i report. Deve produrre: mappa unica del progetto, debiti prioritizzati (impatto × sforzo), rischi. Salva in `docs/cantiere/mappa.md`.

## Fase 3 — Costituzione
Carica la skill `cantiere:costituzione`. Ricava la costituzione dallo stack REALE (non da come "dovrebbe essere") più le scelte dell'utente: se mancano decisioni (es. "questo progetto resta PHP o migra?"), chiedile ORA, in un solo blocco di domande. Genera `CLAUDE.md`, `.claude/cantiere-check.sh` (solo con i check verificati funzionanti in Fase 1), `docs/cantiere/decisioni.md`.

## Fase 4 — Piano di restauro
Lancia `architetto` per un piano a fasi. Ogni fase: obiettivo, reparti coinvolti, criterio di uscita verificabile, rischio. Ordine obbligato: prima la rete di sicurezza (fase 0: far girare check e test minimi), poi i debiti CRITICI di sicurezza, poi il resto per priorità. Salva in `docs/cantiere/restauro.md`.

## Fase 5 — Approvazione (STOP)
Presenta all'utente: mappa in sintesi (10 righe), i 5 debiti peggiori, il piano a fasi con stima di massima. FERMATI e attendi l'approvazione esplicita, fase per fase o in blocco. Non toccare il codice prima.

## Fase 6 — Esecuzione a fasi
Per ogni fase approvata: `restauro` guida (comportamento invariato, test di caratterizzazione prima), i reparti verticali eseguono i task del loro dominio, `collaudo` verifica il criterio di uscita, `sicurezza` rivede se la fase tocca superfici sensibili. Una fase si chiude solo con gate verdi e `.claude/cantiere-check.sh` che passa; poi aggiorna `docs/cantiere/restauro.md` e proponi la successiva. Bug scoperti durante il restauro: mai corretti in silenzio, sempre segnalati come voce separata da decidere.
