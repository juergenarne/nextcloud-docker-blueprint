# 📦 Nextcloud Docker Setup

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

Bei der Neuinstallation der Cloud empfiehlt es sich, die gemounteten Verzeichnisse vor dem erten start der App anzulegen 
```bash
mkdir -p nextcloud/config
mkdir -p nextcloud/custom_apps
mkdir -p nextcloud/data
mkdir -p nextcloud/themes
```

(Siehe mounts in der app section der docker-compose.yaml Datei)
Wenn die Verzeichnisse existieren, können die Container hochgefahren werden.

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
| `APP_NAME`                             | Name des Projekts (z. B. `cloud`) |
| `MARIADB_VERSION`                      | MariaDB-Image-Version             |
| `MYSQL_*`                              | Datenbank-Zugangsdaten            |
| `NEXT_SRC`, `NEXT_CONFIG`,              |                                  |
| `NEXT_CUSTOM_APPS`, `NEXT_DATA`         |                                  |
| `NEXT_THEMES`                           | Speicherpfade für Nextcloud      |

---

## 🐳 Verwendete Images

* [`mariadb:${MARIADB_VERSION}`](https://hub.docker.com/_/mariadb)
* [`nextcloud:latest`](https://hub.docker.com/_/nextcloud)

---

## 📁 Projektstruktur

```bash
.
├── README.md
├── docker-compose.yml
├── docker-up.sh
├── nextcloud-log-clear.sh
├── update-nextcloud.sh
├── .env
├── .env.example
├── .dockerignore
├── mariadb/
│   └── data/
├── nextcloud/
│   ├── data/
│   └── htdocs/
├── ws-relay/
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
