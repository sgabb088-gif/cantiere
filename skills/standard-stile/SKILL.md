---
name: standard-stile
description: Best practices del reparto stile - token di design, temi, responsive, contrasto. Da caricare prima di qualunque lavoro su CSS o design system.
---

# Standard stile del Cantiere

La costituzione del progetto (CLAUDE.md) vince su questo standard in caso di conflitto.

## Token
- Un solo file sorgente per i token (colori, font, spaziature, raggi): tutto il resto lo consuma. Zero valori magici fuori dai token; se un valore serve due volte, è un token.
- Cambiare palette o brand deve costare un file.

## Temi
- Ogni colore nasce in coppia chiaro/scuro; il tema si cambia via token, mai con override sparsi.
- Contrasto minimo AA per il testo (4.5:1, 3:1 per testo grande): verificato, non stimato.

## Layout e responsive
- Mobile-first: regola base per schermo piccolo, media query per allargare.
- Unità relative per la tipografia; spaziature dalla scala dei token, non ad occhio.
- Il contenuto largo (tabelle, code block) scorre nel suo contenitore: la pagina non scorre mai in orizzontale.

## Stati e movimento
- Ogni elemento interattivo ha stati hover/focus/active/disabled progettati; il focus visibile si ristilizza, mai si rimuove.
- Animazioni: brevi, con `prefers-reduced-motion` rispettato.

## Coerenza
- Prima di scrivere CSS nuovo cerca la classe/il token che già fa quella cosa; la coerenza vale più della novità.
- Il CSS morto si elimina nella stessa consegna che lo rende morto.

Questo file è tuo: quando una revisione rivela una regola nuova, aggiungila qui.
