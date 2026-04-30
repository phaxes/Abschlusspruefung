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

    delete)
        # ==========================================
        # FÜR FEATURE-BRANCH: "Implement note delete"
        # ==========================================
        HASH_TO_DELETE="$2"
        if [ -z "$HASH_TO_DELETE" ]; then
            echo "Fehler: Bitte gib den Hash der Notiz an, die gelöscht werden soll."
            exit 1
        fi
        
        if [ -f "$DB_DIR/$HASH_TO_DELETE" ]; then
            rm "$DB_DIR/$HASH_TO_DELETE"
            echo "Notiz mit Hash $HASH_TO_DELETE wurde gelöscht."
        else
            echo "Fehler: Keine Notiz mit dem Hash $HASH_TO_DELETE gefunden."
        fi
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