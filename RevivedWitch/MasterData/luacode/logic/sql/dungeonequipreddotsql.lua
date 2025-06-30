-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sql/dungeonequipreddotsql.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonEquipRedDotSql = {}
DungeonEquipRedDotSql.CreateTable = "CREATE TABLE IF NOT EXISTS #(id INTEGER PRIMARY KEY AUTOINCREMENT,rolekey BIGINT,weaponkey BIGINT,armorkey BIGINT,jewelrykey BIGINT)"
DungeonEquipRedDotSql.StoreKey = "INSERT INTO # VALUES (NULL, :rolekey, :weaponkey, :armorkey, :jewelrykey)"
DungeonEquipRedDotSql.GetKey = "SELECT * FROM #"
DungeonEquipRedDotSql.DeleteTheRole = "DELETE FROM # WHERE rolekey = :roleKey AND (weaponkey = :equipKey OR armorkey = :equipKey OR jewelrykey = :equipKey)"
DungeonEquipRedDotSql.RemoveTable = "DROP TABLE #"
return DungeonEquipRedDotSql

