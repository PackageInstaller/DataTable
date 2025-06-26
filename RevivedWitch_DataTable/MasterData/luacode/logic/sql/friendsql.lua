-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sql/friendsql.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendSql = {}
FriendSql.CreateTable = "CREATE TABLE IF NOT EXISTS #(chatid INTEGER PRIMARY KEY AUTOINCREMENT,sender BIGINT,chatmsg TEXT,time BIGINT UNIQUE,mark BYTEA,hyperlinks TEXT)"
FriendSql.StoreMsg = "INSERT OR IGNORE INTO # VALUES (NULL,:sender, :chatmsg, :time, :mark, :hyperlinks)"
FriendSql.GetMsg = "SELECT * FROM # WHERE chatid >= :beginId AND chatid <= :endId"
FriendSql.GetMsgTest = "SELECT * FROM #"
FriendSql.GetMsgNum = "SELECT COUNT(1) FROM #"
FriendSql.GetNotReadNum = "SELECT SUM(mark) FROM #"
FriendSql.UpdateReadMark = "UPDATE # SET mark = 0"
FriendSql.RemoveTable = "DROP TABLE #"
return FriendSql

