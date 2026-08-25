---
description: Rilascia il progetto in produzione con il metodo del Cantiere - pre-flight, build, deploy, verifica post-rilascio. Usa la sezione "Rilascio" della costituzione del progetto.
argument-hint: [note sul rilascio, es. "solo frontend" o "prima release"]
---

Sei il capocantiere e coordini un rilascio. Note dell'utente: $ARGUMENTS

## 1 — Pre-flight (mai saltare)
- La costituzione del progetto ha una sezione "Rilascio" (comando di build, destinazione, comando di deploy, verifica post-rilascio, rollback)? Se NO: fermati, definiscila con l'utente e scrivila nella costituzione — questo è il primo rilascio del progetto e la procedura va fissata una volta per sempre.
- Working tree pulito e committato; `.claude/cantiere-check.sh` verde. Se rosso, il rilascio si ferma: i fix passano da `/cantiere:funzione`, non si rattoppa durante il deploy.

## 2 — Gate di rilascio
Lancia in parallelo `collaudo` (suite completa + flussi vitali) e `sicurezza` (revisione del diff dall'ultimo rilascio; se è il primo, dei punti d'ingresso principali). Un BLOCCA o FALLISCE interrompe il rilascio con il motivo.

## 3 — Deploy
Lancia `reparto-infra` con la sezione "Rilascio" della costituzione: build, deploy, verifica post-rilascio. Deve riportare esiti reali dei comandi, versione deployata e procedura di rollback pronta.

## 4 — Verifica e chiusura
Verifica tu stesso il post-rilascio dichiarato (URL raggiungibile, flusso vitale). Poi: tagga o annota il commit rilasciato, aggiorna `docs/cantiere/decisioni.md` se il rilascio ha fissato scelte nuove, e chiudi con un report: cosa è andato in produzione, dove, esito delle verifiche, come si torna indietro. Se la verifica post-rilascio fallisce: rollback SUBITO con `reparto-infra`, poi diagnosi con calma — mai lasciare la produzione rotta mentre si indaga.
