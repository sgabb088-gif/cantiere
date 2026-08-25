---
name: standard-dati
description: Best practices del reparto dati - schema, migrazioni, query, policy di accesso. Da caricare prima di qualunque lavoro su database.
---

# Standard dati del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto.

## Schema
- Nomi in inglese, snake_case, singolare per le colonne, plurale per le tabelle. Se il dominio è italiano, mappa dominio→colonna in testa alla migration.
- Ogni tabella: chiave primaria, `created_at`; `updated_at` se i record cambiano.
- Vincoli nel DB, non solo nell'app: NOT NULL, UNIQUE, FK, CHECK. Il DB è l'ultima linea di difesa.
- Ogni foreign key ha un indice; ogni FK dichiara il comportamento ON DELETE (mai lasciare il default per pigrizia).

## Migrazioni
- Una modifica = una nuova migration; le migration applicate sono immutabili.
- Ogni migration deve essere eseguita davvero prima della consegna (DB locale o script di verifica).
- Seed riproducibili e separati dallo schema; mai dati reali nei seed.

## Accesso e sicurezza
- Default-deny: si parte da nessun permesso e si concede l'esplicito per ruolo (con RLS dove disponibile).
- Query sempre parametrizzate; concatenare input in SQL è vietato senza eccezioni.
- Dati sensibili: minimi, hashati/salati dove possibile, mai in log. Le chiavi con privilegi (service role) mai raggiungibili dal client.

## Query
- Niente `SELECT *` nel codice applicativo: colonne esplicite.
- Le query nei percorsi caldi vanno spiegate (EXPLAIN) se toccano tabelle grandi.
- La paginazione si progetta subito, non quando la tabella esplode.

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
