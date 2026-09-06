local DungeonEquipRedDotSql = {}
DungeonEquipRedDotSql.CreateTable = "CREATE TABLE IF NOT EXISTS #(id INTEGER PRIMARY KEY AUTOINCREMENT,rolekey BIGINT,weaponkey BIGINT,armorkey BIGINT,jewelrykey BIGINT)"
DungeonEquipRedDotSql.StoreKey = "INSERT INTO # VALUES (NULL, :rolekey, :weaponkey, :armorkey, :jewelrykey)"
DungeonEquipRedDotSql.GetKey = "SELECT * FROM #"
DungeonEquipRedDotSql.DeleteTheRole = "DELETE FROM # WHERE rolekey = :roleKey AND (weaponkey = :equipKey OR armorkey = :equipKey OR jewelrykey = :equipKey)"
DungeonEquipRedDotSql.RemoveTable = "DROP TABLE #"
return DungeonEquipRedDotSql
