-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sql/sqlconnection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("lsqlite3")
local FriendSql = require("logic.sql.friendsql")
local DungeonEquipRedDotSql = require("logic.sql.dungeonequipreddotsql")
local LocalProtocolManager = require("localprotocols.localprotocolmanager")
local SqlConnection = {}
local _db = nil
local _clientId = -1
local bind_sql = function(stmt, userid)
  -- function num : 0_0
  return stmt:gsub("#", "d_" .. userid)
end

SqlConnection.Init = function(userId, clientId)
  -- function num : 0_1 , upvalues : _db, _clientId, _ENV, SqlConnection
  if _db and _clientId and _clientId == clientId then
    LogError(" SqlConnection ", " Init  db already exist")
    return 
  end
  if _db then
    (SqlConnection.UnInit)()
  end
  local name = "h_" .. userId .. ".sqlite3"
  local databasefile = (((CS.PixelNeko).LuaManager).GetExternalPath)() .. "/" .. name
  _db = (lsqlite3.open)(databasefile)
  _clientId = clientId
end

SqlConnection.UnInit = function()
  -- function num : 0_2 , upvalues : _db, _ENV, _clientId
  if not _db then
    LogError(" SqlConnection ", " UnInit  error db is not exist")
    return 
  end
  assert(_db:close() == lsqlite3.OK)
  _db = nil
  _clientId = -1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SqlConnection.CteateTable = function(userId)
  -- function num : 0_3 , upvalues : bind_sql, FriendSql, _db
  local sql = bind_sql(FriendSql.CreateTable, userId)
  _db:exec(sql)
end

SqlConnection.StoreMsg = function(userId, msginfo)
  -- function num : 0_4 , upvalues : SqlConnection, bind_sql, FriendSql, _db, _ENV
  (SqlConnection.CteateTable)(userId)
  local sql = bind_sql(FriendSql.StoreMsg, userId)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare StoreMsg state return nil sql %s ", sql)
    return 
  end
  local args = {}
  args.sender = msginfo.sender
  args.chatmsg = msginfo.msg
  args.time = tostring(msginfo.time)
  args.mark = msginfo.mark
  args.hyperlinks = msginfo.hyperlinks
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " StoreMsg bind_names error")
  end
  stmt:step()
  stmt:finalize()
end

SqlConnection.StoreMsgList = function(userId, msgList)
  -- function num : 0_5 , upvalues : SqlConnection, _db, bind_sql, FriendSql, _ENV
  (SqlConnection.CteateTable)(userId)
  _db:exec("begin")
  local sql = bind_sql(FriendSql.StoreMsg, userId)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare StoreMsg state return nil sql %s ", sql)
    return 
  end
  for _,msginfo in pairs(msgList) do
    local args = {}
    args.sender = msginfo.sender
    args.chatmsg = msginfo.msg
    args.time = tostring(msginfo.time)
    args.mark = msginfo.mark
    args.hyperlinks = msginfo.hyperlinks
    if stmt:bind_names(args) ~= lsqlite3.OK then
      LogError(" SqlConnection ", " StoreMsg bind_names error")
    end
    stmt:step()
    stmt:reset()
  end
  _db:exec("commit")
  stmt:finalize()
end

SqlConnection.GetMsg = function(userId, beginId, endId)
  -- function num : 0_6 , upvalues : SqlConnection, LocalProtocolManager, _clientId, bind_sql, FriendSql, _db, _ENV
  (SqlConnection.CteateTable)(userId)
  local protocol = (LocalProtocolManager.CreateProtocol)("friendchat.sgetfriendchat")
  protocol.userId = userId
  protocol.clientId = _clientId
  local sql = bind_sql(FriendSql.GetMsg, userId)
  local stmt = _db:prepare(sql)
  local args = {}
  args.beginId = beginId
  args.endId = endId
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " GetMsg bind_names error")
    return 
  end
  local i = 0
  for row in stmt:rows() do
    i = i + 1
    local info = (LocalProtocolManager.CreateBean)("data.friendchatinfo")
    info.chatid = row[1]
    info.sender = row[2]
    info.msg = row[3]
    info.time = row[4]
    info.mark = row[5]
    info.hyperlinks = row[6]
    ;
    (table.insert)(protocol.msgs, info)
  end
  stmt:finalize()
  SqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

SqlConnection.GetLocalChatInfo = function(userId)
  -- function num : 0_7 , upvalues : SqlConnection, LocalProtocolManager, _clientId, _db, bind_sql, FriendSql, _ENV
  (SqlConnection.CteateTable)(userId)
  local protocol = (LocalProtocolManager.CreateProtocol)("friendchat.sgetlocalchatinfo")
  protocol.userId = userId
  protocol.clientId = _clientId
  local stmt = _db:prepare(bind_sql(FriendSql.GetNotReadNum, userId))
  if stmt then
    stmt:step()
    local num = stmt:get_uvalues()
    if num then
      protocol.redNum = num
    end
    stmt:finalize()
  end
  do
    local totalnum = 0
    stmt = _db:prepare(bind_sql(FriendSql.GetMsgNum, userId))
    if stmt then
      stmt:step()
      local num = stmt:get_uvalues()
      if num then
        protocol.totalNum = num
      end
      stmt:finalize()
    end
    do
      SqlProtocalManager:SendProtocolToRemoteThread(protocol)
    end
  end
end

SqlConnection.ResetNotReadNum = function(userId)
  -- function num : 0_8 , upvalues : bind_sql, FriendSql, _db
  local sql = bind_sql(FriendSql.UpdateReadMark, userId)
  local result = _db:exec(sql)
end

SqlConnection.RemoveFriendChatTable = function(userId)
  -- function num : 0_9 , upvalues : bind_sql, FriendSql, _db
  local sql = bind_sql(FriendSql.RemoveTable, userId)
  local result = _db:exec(sql)
end

SqlConnection.Test = function(userId)
  -- function num : 0_10 , upvalues : SqlConnection
  (SqlConnection.GetMsg)(userId, 1, 4)
end

local bind_DungeonEquipRedDot_sql = function(stmt)
  -- function num : 0_11
  return stmt:gsub("#", "dungeon_equip_reddot")
end

SqlConnection.CteateDungeonEquipRedDotTable = function()
  -- function num : 0_12 , upvalues : bind_DungeonEquipRedDot_sql, DungeonEquipRedDotSql, _db
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.CreateTable)
  _db:exec(sql)
end

SqlConnection.StoreDungeonEquipRedDotKey = function(clientId, reddotData)
  -- function num : 0_13 , upvalues : _clientId, _ENV, SqlConnection, bind_DungeonEquipRedDot_sql, DungeonEquipRedDotSql, _db
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " StoreDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return 
  end
  ;
  (SqlConnection.CteateDungeonEquipRedDotTable)()
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.StoreKey)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare StoreDungeonEquipRedDotKey state return nil sql %s ", sql)
    return 
  end
  local args = {}
  args.rolekey = reddotData.roleKey
  args.weaponkey = reddotData.weaponKey
  args.armorkey = reddotData.armorKey
  args.jewelrykey = reddotData.jewelryKey
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " StoreDungeonEquipRedDotKey bind_names error")
  end
  stmt:step()
  stmt:finalize()
end

SqlConnection.GetDungeonEquipRedDotKey = function(clientId)
  -- function num : 0_14 , upvalues : _clientId, _ENV, SqlConnection, LocalProtocolManager, bind_DungeonEquipRedDot_sql, DungeonEquipRedDotSql, _db
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " GetDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return 
  end
  ;
  (SqlConnection.CteateDungeonEquipRedDotTable)()
  local protocol = (LocalProtocolManager.CreateProtocol)("dungeonreddot.sgetdungeonequipreddot")
  protocol.clientId = _clientId
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.GetKey)
  local stmt = _db:prepare(sql)
  local args = {}
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " GetDungeonEquipRedDotKey bind_names error")
    return 
  end
  local i = 0
  for row in stmt:rows() do
    i = i + 1
    local info = (LocalProtocolManager.CreateBean)("data.equipreddotdata")
    info.roleKey = row[2]
    info.weaponKey = row[3]
    info.armorKey = row[4]
    info.jewelryKey = row[5]
    ;
    (table.insert)(protocol.redDotData, info)
  end
  stmt:finalize()
  SqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

SqlConnection.RemoveDungeonEquipRedDotKeyTable = function(clientId)
  -- function num : 0_15 , upvalues : _clientId, _ENV, bind_DungeonEquipRedDot_sql, DungeonEquipRedDotSql, _db
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " RemoveDungeonEquipRedDotKeyTable client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return 
  end
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.RemoveTable)
  local result = _db:exec(sql)
end

SqlConnection.DeleteOneLineDungeonEquipRedDotKey = function(clientId, roleKey, equipKey)
  -- function num : 0_16 , upvalues : _clientId, _ENV, SqlConnection, bind_DungeonEquipRedDot_sql, DungeonEquipRedDotSql, _db
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " DeleteOneLineDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return 
  end
  ;
  (SqlConnection.CteateDungeonEquipRedDotTable)()
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.DeleteTheRole)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare DeleteOneLineDungeonEquipRedDotKey state return nil sql %s ", sql)
    return 
  end
  local args = {}
  args.roleKey = roleKey
  args.equipKey = equipKey
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " DeleteOneLineDungeonEquipRedDotKey bind_names error")
  end
  stmt:step()
  stmt:finalize()
end

return SqlConnection

