local FriendSql = {}
FriendSql.CreateTable = "CREATE TABLE IF NOT EXISTS #(chatid INTEGER PRIMARY KEY AUTOINCREMENT,sender BIGINT,chatmsg TEXT,time BIGINT UNIQUE,mark BYTEA,hyperlinks TEXT bubbleid SMALLINT)"
FriendSql.StoreMsg = "INSERT OR IGNORE INTO # VALUES (NULL,:sender, :chatmsg, :time, :mark, :hyperlinks, :bubbleid)"
FriendSql.GetMsg = "SELECT * FROM # WHERE chatid >= :beginId AND chatid <= :endId"
FriendSql.GetMsgTest = "SELECT * FROM #"
FriendSql.GetMsgNum = "SELECT COUNT(1) FROM #"
FriendSql.GetNotReadNum = "SELECT SUM(mark) FROM #"
FriendSql.UpdateReadMark = "UPDATE # SET mark = 0"
FriendSql.RemoveTable = "DROP TABLE #"
return FriendSql
