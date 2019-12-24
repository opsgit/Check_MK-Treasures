echo "<<<postgres_replication>>>"
echo "WITH slots AS (SELECT slot_name, slot_type, coalesce(restart_lsn, '0/0'::pg_lsn) AS slot_lsn, coalesce(pg_xlog_location_diff(coalesce(pg_last_xlog_receive_location(), pg_current_xlog_location()), restart_lsn),0) AS delta, active FROM pg_replication_slots) SELECT *, pg_size_pretty(delta) AS delta_pretty FROM slots; " | su - postgres -c "psql -d postgres -A -t -F' '"