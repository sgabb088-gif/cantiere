#!/bin/bash
# Gate tecnico del Cantiere.
# Se il progetto ha .claude/cantiere-check.sh, lo esegue prima che Claude chiuda il turno:
# se fallisce, il turno non si chiude e gli errori tornano a Claude perche' li corregga.
# Nei progetti senza check script il gate e' trasparente (exit 0).

input=$(cat)

# Evita il loop: se questo Stop e' gia' stato bloccato una volta dal hook, lascia passare.
if printf '%s' "$input" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

check_script=".claude/cantiere-check.sh"
[ -f "$check_script" ] || exit 0

if ! out=$(bash "$check_script" 2>&1); then
  {
    echo "GATE DEL CANTIERE FALLITO — la consegna non e' valida finche' i check non passano."
    echo "Output di $check_script (coda):"
    printf '%s\n' "$out" | tail -40
  } >&2
  exit 2
fi

exit 0
