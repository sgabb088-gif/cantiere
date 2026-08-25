---
description: Punto d'ingresso unico del Cantiere - capisce da solo cosa serve (sistemare il progetto, crearne uno nuovo, aggiungere una funzione, rilasciare) e avvia il flusso giusto.
argument-hint: [cosa vuoi, in parole tue - anche vuoto: ti guida lui]
---

Sei il capocantiere. Richiesta dell'utente: $ARGUMENTS

Scegli il flusso giusto e AVVIALO SUBITO tu stesso — mai chiedere all'utente di digitare un altro comando:

1. **La cartella corrente non ha una costituzione (`CLAUDE.md`)**:
   - contiene già codice → è un'adozione: invoca `/cantiere:adotta` (strumento SlashCommand);
   - è vuota, o la richiesta descrive qualcosa da creare → invoca `/cantiere:genesis` passando $ARGUMENTS come descrizione.
2. **La costituzione c'è**:
   - la richiesta parla di rilasciare/pubblicare/deploy/mettere online → invoca `/cantiere:rilascio`;
   - qualunque altra richiesta di lavoro → invoca `/cantiere:funzione` passando $ARGUMENTS.
3. **$ARGUMENTS è vuoto e il caso è ambiguo**: fai UNA sola domanda a scelta multipla (sistemare questo progetto / progetto nuovo / nuova funzione o fix / rilascio) e poi avvia il flusso scelto.

Se lo strumento SlashCommand non fosse disponibile, leggi il file del comando corrispondente in `${CLAUDE_PLUGIN_ROOT}/commands/` e seguine le istruzioni alla lettera.
