# Cantiere

Impalcatura personale per lo sviluppo AI-first con Claude Code: **reparti di agenti verticali** (dati, backend, frontend, stile) coordinati da **agenti trasversali** (architetto, cartografo, sicurezza, collaudo, restauro), con best practices **versionate qui** — mai rispiegate in chat.

Il principio: **le istruzioni vivono in file sotto git, non nei prompt**. Se ti accorgi di rispiegare qualcosa a Claude, quella cosa va scritta in uno standard, in un agente o nella costituzione del progetto — una volta sola.

## Installazione — una riga, su qualsiasi computer con Claude Code

```bash
claude plugin marketplace add sgabb088-gif/cantiere && claude plugin install cantiere@cantiere
```

Vale per tutti i progetti di quel computer, per sempre. Per aggiornare dopo un push: `claude plugin update cantiere`.

## Uso — un comando solo

Apri `claude` nella cartella del progetto (nuovo o esistente) e scrivi:

```
/cantiere cosa vuoi, in parole tue
```

Capisce da solo la situazione: progetto senza regole → lo adotta (ricognizione in sola lettura, piano approvato da te prima di toccare codice); cartella nuova → lo crea da zero; progetto già adottato → esegue la richiesta come funzione/fix; parli di "pubblicare/deploy" → rilascia. Anche `/cantiere` da solo funziona: ti fa una domanda e parte.

I flussi restano invocabili anche direttamente, per chi vuole la precisione:

| Comando | Quando |
|---|---|
| `/cantiere:genesis` | Progetto da zero: intervista → architettura → costituzione → milestone 1 costruita dai reparti con gate finali. |
| `/cantiere:adotta` | Progetto esistente: ricognizione parallela di tutti i reparti → mappa → costituzione ricavata dal codice reale → piano di restauro a fasi, **approvato da te prima di toccare codice**. |
| `/cantiere:funzione <cosa>` | Lavoro quotidiano su un progetto già dotato di costituzione: mini-spec → reparti → gate → report. |
| `/cantiere:rilascio` | Deploy in produzione: pre-flight → gate di collaudo e sicurezza → build e deploy (`reparto-infra`) → verifica post-rilascio, con rollback pronto. |

## Architettura

- **Capocantiere** = la sessione principale di Claude Code, guidata dai comandi qui sopra: decide, smista, non implementa.
- **Reparti verticali** (`agents/reparto-*.md`: dati, backend, frontend, stile, infra) = eseguono nel loro dominio, caricano il proprio standard, dichiarano gli impatti sugli altri reparti.
- **Trasversali** (`agents/`) = architetto (progetta e arbitra), cartografo (mappa l'esistente), sicurezza e collaudo (gate su ogni consegna), restauro (refactoring a comportamento invariato).
- **Standard** (`skills/standard-*/SKILL.md`) = le best practices per dominio. Sono file TUOI: quando una review rivela una regola nuova, si aggiunge lì.
- **Costituzione** (`skills/costituzione/`) = genera il `CLAUDE.md` di ogni progetto: regole specifiche che VINCONO sugli standard.
- **Gate tecnico** (`hooks/gate.sh`) = a fine turno esegue `.claude/cantiere-check.sh` del progetto (typecheck, lint, test); se fallisce, Claude non può dichiarare chiuso il lavoro. Deterministico: non dipende dalla memoria dell'AI.

## Gerarchia delle regole

1. Costituzione del progetto (`CLAUDE.md` nel progetto) — vince sempre.
2. Standard del Cantiere (`skills/standard-*`).
3. Giudizio dell'agente.

## Estendere

- Nuovo reparto (es. un futuro `reparto-mobile`): aggiungi `agents/reparto-<nome>.md` + `skills/standard-<nome>/SKILL.md` sul modello degli esistenti.
- Regola nuova: nel file di standard giusto, una riga. Vale da subito in tutti i progetti.
- Rinominare il framework: cartella + campo `name` in `.claude-plugin/plugin.json` e `marketplace.json` + prefisso dei comandi citato nei file.

## Nota sui costi

Ogni subagent è una sessione con contesto proprio: i flussi `genesis`/`adotta` lanciano 5–8 agenti. Per modifiche banali usa la sessione normale (la costituzione del progetto vale comunque); `/cantiere:funzione` è per il lavoro che merita reparti e gate.
