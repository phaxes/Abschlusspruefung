#!/bin/bash

# Definition des Speicherortes
DB_DIR=".notes/db"

# Stelle sicher, dass das Verzeichnis existiert
mkdir -p "$DB_DIR"

COMMAND="$1"

case "$COMMAND" in
    add)
        # ==========================================
        # FÜR COMMIT 3: "Implement note add"
        # ==========================================
        shift
        CONTENT="$*"
        if [ -z "$CONTENT" ]; then
            echo "Fehler: Die Notiz darf nicht leer sein."
            exit 1
        fi
        
        # Erzeugt den SHA-256 Hash des Inhalts (ohne Zeilenumbruch am Ende)
        HASH=$(echo -n "$CONTENT" | sha256sum | awk '{print $1}')
        
        # Speichert den Inhalt in der Datei, deren Name der Hash ist
        echo -n "$CONTENT" > "$DB_DIR/$HASH"
        echo "Notiz gespeichert! Hash: $HASH"
        ;;
    *)      

     list)
        # ==========================================
        # FÜR COMMIT 4: "Implement note list"
        # ==========================================
        # Prüft, ob das Verzeichnis existiert und nicht leer ist (Ignoriert .keep)
        if [ ! -d "$DB_DIR" ] || [ -z "$(find "$DB_DIR" -type f ! -name ".keep" 2>/dev/null)" ]; then
            echo "Keine Notizen gefunden."
            exit 0
        fi
        
        # Geht durch alle Dateien im DB-Ordner
        for FILE in "$DB_DIR"/*; do
            if [ -f "$FILE" ] && [ "$(basename "$FILE")" != ".keep" ]; then
                HASH=$(basename "$FILE")
                CONTENT=$(cat "$FILE")
                echo "$HASH  -  $CONTENT"
            fi
        done
        ;; 

# ==========================================
        # BASIS-STRUKTUR (Kann von Anfang an rein)
        # ==========================================
        echo "note-cli - Ein einfaches Notiz-Tool"
        echo "Nutzung: ./note.sh <command> [<args>]"
        echo ""
        echo "Befehle:"
        echo "  add <text>      - Speichert eine Notiz"
        echo "  list            - Listet alle gespeicherten Notizen mit Hash auf"
        echo "  delete <hash>   - Löscht die Notiz mit dem entsprechenden Hash"
        ;;
        
esac