# 📦 Pnoom Docker Setup

Dieses Repository enthält eine vorkonfigurierte Docker-Umgebung für ein Setup mit **Nextcloud** und **MariaDB**, basierend auf einem flexiblen `.env`-System.

---

## 🚀 Schnellstart

1. **Repository klonen:**

   ```bash
   git clone git@github.com:juergenarne/nextcloud-docker-blueprint.git
   cd pnoom-docker
   ```

2. **Umgebungsdatei erstellen:**

   Kopiere die Beispielkonfiguration:

   ```bash
   cp .env.example .env
   ```

   Passe Werte wie Passwörter und Ports in der `.env`-Datei an.

3. **Container starten:**

Bei der Neuinstallation der Cloud empfiehlt es sich, den Bereich ``volumes:``im Service ``app:`` vollständig auszukommentieren. Dann legt Nextcloud eine komplett neue, leere Cloud an. Nachdem das abgeschlossen ist, empfiehlt es sich, das Verzeichnis ``/var/www/html`` nach ``nextcloud`` zu kopieren. 

```bash
docker cp pnoom-nextcloud:/var/www/html ./nextcloud/htdocs
docker cp pnoom-nextcloud:/var/www/html/data ./nextcloud/data
```

Anschlissend die volumes wieder einkommentieren und 

   ```bash
   docker-compose up -d
   ```

4. **Zugreifen:**

   * Nextcloud läuft auf: [http://localhost:8080](http://localhost:8080)
   * MariaDB ist unter Port `3306` erreichbar (siehe `.env`)

## ⚙️ Konfiguration

Alle Einstellungen werden über die `.env`-Datei vorgenommen:

| Variable                               | Beschreibung                      |
| -------------------------------------- | --------------------------------- |
| `APP_NAME`                             | Name des Projekts (z. B. `pnoom`) |
| `MARIADB_VERSION`                      | MariaDB-Image-Version             |
| `MYSQL_*`                              | Datenbank-Zugangsdaten            |
| `NEXT_SRC`, `NEXT_HTDOCS`, `NEXT_DATA` | Speicherpfade für Nextcloud       |

---

## 🐳 Verwendete Images

* [`mariadb:${MARIADB_VERSION}`](https://hub.docker.com/_/mariadb)
* [`nextcloud:latest`](https://hub.docker.com/_/nextcloud)

---

## 📁 Projektstruktur

```bash
.
├── docker-compose.yml
├── .env
├── .env.example
├── .dockerignore
├── mariadb/
│   └── data/
├── nextcloud/
│   ├── data/
│   └── htdocs/
```

---

## 🧹 Container stoppen & löschen

```bash
docker-compose down
```

Optional mit Volumes löschen:

```bash
docker-compose down -v
```

---

## ✅ Hinweise

* Stelle sicher, dass deine Ports (`3306`, `8080`) nicht bereits verwendet werden.
* Achte auf ausreichende Berechtigungen im `nextcloud/data`-Verzeichnis (z. B. `www-data`).

Nach der INstallation:

```bash
docker exec -u www-data -it pnoom-nextcloud php occ maintenance:repair
docker exec -u www-data -it pnoom-nextcloud php occ upgrade
docker exec -u www-data -it pnoom-nextcloud php occ maintenance:mode --off
```
