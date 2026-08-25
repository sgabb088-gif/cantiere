---
name: costituzione
description: Genera o aggiorna la costituzione di un progetto (CLAUDE.md) e il suo gate tecnico (.claude/cantiere-check.sh). Da usare nei flussi genesis e adotta, o quando l'utente vuole formalizzare le regole di un progetto.
---

# Costituzione di progetto

La costituzione è il CLAUDE.md del progetto: l'unico posto dove vivono le regole. Tutto ciò che l'utente dovrebbe "rispiegare" a ogni sessione va scritto qui, una volta. Le regole della costituzione VINCONO sugli standard del Cantiere in caso di conflitto.

## Procedura
1. **Fonti**: in genesis usa l'intervista con l'utente; in adozione usa la mappa del cartografo (lo stack REALE) più le scelte dell'utente. Mai inventare regole: ogni riga deve venire da una decisione presa o da un fatto verificato.
2. Scrivi `CLAUDE.md` nella radice del progetto seguendo il template sotto. Corto e vincolante batte lungo ed esaustivo: se una regola non cambierebbe mai il comportamento di un agente, tagliala.
3. Scrivi `.claude/cantiere-check.sh`: uno script bash che esegue i check tecnici del progetto (typecheck, lint, test) usando i comandi GIÀ esistenti e VERIFICATI funzionanti. Deve essere veloce (<2 min) e uscire con codice ≠0 al primo fallimento (`set -e`). Se il progetto non ha ancora check funzionanti, crea lo script con i soli check reali disponibili e annota nella costituzione il debito.
4. Crea `docs/cantiere/decisioni.md` (registro delle decisioni architetturali, formato: data — decisione — perché) se non esiste.

## Template CLAUDE.md

```markdown
# <Nome progetto> — costituzione (per Claude Code)

<Due righe: cos'è il prodotto e per chi.>

## Stack (vincolante)
<Elenco puntato: linguaggi, framework CON VERSIONE, DB, hosting. Ogni voce è un vincolo, non una descrizione.>

## Regole non negoziabili
<Elenco numerato delle regole di prodotto e di dominio che nessuna modifica può violare. Solo regole vere, decise dall'utente.>

## Elasticità
<Cosa deve restare configurabile e dove vive (file di config, i18n): nomi, prezzi, soglie, testi. "Cambiare X deve costare una costante.">

## VINCOLO ASSOLUTO — ciclo Refactor & Security a OGNI modifica
1. Implementa la modifica richiesta.
2. Refactoring delle parti toccate: nomi chiari, funzioni piccole, zero codice morto, zero duplicazioni introdotte, valori solo da config/i18n.
3. Check obbligatori: esegui `.claude/cantiere-check.sh` più revisione mirata di validazione input server-side, autorizzazioni, segreti mai nel client, injection/XSS, privacy.
4. Report finale "REFACTOR & SECURITY" (max 10 righe). Se un check fallisce, la modifica NON è consegnata.

## Definition of done
- Il comando di avvio (<comando>) parte senza errori né warning nuovi.
- `.claude/cantiere-check.sh` passa.
- <Altri criteri specifici del progetto.>

## Rilascio
- Build: <comando>. Destinazione: <hosting/server e come ci si arriva>.
- Deploy: <comando o procedura, un passo per riga>.
- Verifica post-rilascio: <URL da controllare e flusso vitale da provare>.
- Rollback: <come si torna alla versione precedente>.
```
(La sezione Rilascio può restare "DA DEFINIRE al primo deploy" in genesis; `/cantiere:rilascio` la pretende compilata prima del primo rilascio.)

## Aggiornamento
La costituzione è viva: quando una revisione o un errore rivela una regola nuova, va aggiunta qui (e SOLO qui). Se l'utente corregge due volte la stessa cosa, è il segnale che manca una riga di costituzione: proponila.
