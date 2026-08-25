---
name: standard-infra
description: Best practices del reparto infrastruttura - build, ambienti, deploy, rollback, PWA, backup. Da caricare prima di qualunque lavoro su build o rilasci.
---

# Standard infrastruttura del Cantiere

La costituzione del progetto (CLAUDE.md, sezione "Rilascio") vince su questo standard in caso di conflitto.

## Build
- Un comando solo, riproducibile, senza passi manuali; le versioni dei tool bloccate (lockfile, `.nvmrc` o equivalenti).
- La build fallisce rumorosamente: warning nuovi trattati come errori nei progetti che partono puliti.

## Ambienti
- Almeno due: locale e produzione; config SOLO da variabili d'ambiente, `.env` mai versionato, `.env.example` sempre allineato.
- Nessun "funziona sul mio computer": ciò che va in produzione è l'output della build, non la cartella di lavoro.

## Deploy
- Prima del deploy: gate tecnico verde (`.claude/cantiere-check.sh`), working tree pulito, commit taggato o annotato.
- Rollback definito PRIMA del rilascio (deploy precedente conservato, o revert + redeploy documentato).
- Dopo il deploy: verifica post-rilascio reale — l'URL risponde, il flusso vitale del prodotto funziona; l'esito si riporta, non si presume.
- Deploy piccoli e frequenti battono deploy rari e giganti.

## PWA (dove applicabile)
- Manifest e icone generati dalle fonti di verità del progetto (config/tema), mai duplicati a mano.
- Il service worker si aggiorna in modo controllato: mai una cache che imprigiona gli utenti su una versione vecchia; verifica dell'installabilità a ogni rilascio.

## Dati e backup
- Migrazioni di schema deployate PRIMA del codice che le usa, e sempre compatibili all'indietro per un rilascio.
- Backup del DB di produzione automatico e RIPRISTINATO almeno una volta per provare che funziona.

Questo file è tuo: quando un rilascio va storto, la lezione diventa una riga qui.
