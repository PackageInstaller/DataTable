require("lsqlite3")
local FriendSql = require("logic.sql.friendsql")
local DungeonEquipRedDotSql = require("logic.sql.dungeonequipreddotsql")
local LocalProtocolManager = require("localprotocols.localprotocolmanager")
local SqlConnection = {}
local _db
local _clientId = -1

local function bind_sql(stmt, userid)
  return stmt:gsub("#", "d_" .. userid)
end

function SqlConnection.ensureBubbleIdColumnExists(userId)
  local hasBubbleId = false
  local tableName = "d_" .. userId
  local sql = string.format("PRAGMA table_info(%s);", tableName)
  for row in _db:nrows(sql) do
    if row.name == "bubbleid" then
      hasBubbleId = true
      break
    end
  end
  if not hasBubbleId then
    local alterSql = string.format("ALTER TABLE %s ADD COLUMN bubbleid INTEGER DEFAULT 0;", tableName)
    local result = _db:exec(alterSql)
    LogInfo(" SqlConnection ", " alter table result=" .. result)
  else
    LogInfo(" SqlConnection ", " 找到 bubbleid tableName=" .. tableName)
  end
end

function SqlConnection.Init(userId, clientId)
  if _db and _clientId and _clientId == clientId then
    LogError(" SqlConnection ", " Init  db already exist")
    return
  end
  if _db then
    SqlConnection.UnInit()
  end
  local name = "h_" .. userId .. ".sqlite3"
  local databasefile = CS.PixelNeko.LuaManager.GetExternalPath() .. "/" .. name
  _db = lsqlite3.open(databasefile)
  _clientId = clientId
  SqlConnection.ensureBubbleIdColumnExists(userId)
end

function SqlConnection.UnInit()
  if not _db then
    LogError(" SqlConnection ", " UnInit  error db is not exist")
    return
  end
  assert(_db:close() == lsqlite3.OK)
  _db = nil
  _clientId = -1
end

function SqlConnection.CteateTable(userId)
  local sql = bind_sql(FriendSql.CreateTable, userId)
  _db:exec(sql)
end

function SqlConnection.StoreMsg(userId, msginfo)
  SqlConnection.CteateTable(userId)
  SqlConnection.ensureBubbleIdColumnExists(userId)
  local sql = bind_sql(FriendSql.StoreMsg, userId)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare StoreMsg state return nil sql= " .. sql)
    return
  end
  local args = {}
  args.sender = msginfo.sender
  args.chatmsg = msginfo.msg
  args.time = tostring(msginfo.time)
  args.mark = msginfo.mark
  args.hyperlinks = msginfo.hyperlinks
  args.bubbleid = msginfo.bubbleID
  if stmt:bind_names(args) ~= lsqlite3.OK then
    LogError(" SqlConnection ", " StoreMsg bind_names error")
  end
  stmt:step()
  stmt:finalize()
end

function SqlConnection.StoreMsgList(userId, msgList)
  SqlConnection.CteateTable(userId)
  _db:exec("begin")
  SqlConnection.ensureBubbleIdColumnExists(userId)
  local sql = bind_sql(FriendSql.StoreMsg, userId)
  local stmt = _db:prepare(sql)
  if not stmt then
    LogError(" SqlConnection ", " prepare StoreMsg state return nil sql =" .. sql)
    return
  end
  for _, msginfo in pairs(msgList) do
    local args = {}
    args.sender = msginfo.sender
    args.chatmsg = msginfo.msg
    args.time = tostring(msginfo.time)
    args.mark = msginfo.mark
    args.hyperlinks = msginfo.hyperlinks
    args.bubbleid = msginfo.bubbleID
    if stmt:bind_names(args) ~= lsqlite3.OK then
      LogError(" SqlConnection ", " StoreMsg bind_names error")
    end
    stmt:step()
    stmt:reset()
  end
  _db:exec("commit")
  stmt:finalize()
end

function SqlConnection.GetMsg(userId, beginId, endId)
  SqlConnection.CteateTable(userId)
  local protocol = LocalProtocolManager.CreateProtocol("friendchat.sgetfriendchat")
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
    local info = LocalProtocolManager.CreateBean("data.friendchatinfo")
    info.chatid = row[1]
    info.sender = row[2]
    info.msg = row[3]
    info.time = row[4]
    info.mark = row[5]
    info.hyperlinks = row[6]
    if row[7] then
      info.bubbleID = row[7]
    else
      info.bubbleID = 0
    end
    table.insert(protocol.msgs, info)
  end
  stmt:finalize()
  SqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function SqlConnection.GetLocalChatInfo(userId)
  SqlConnection.CteateTable(userId)
  local protocol = LocalProtocolManager.CreateProtocol("friendchat.sgetlocalchatinfo")
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
  SqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function SqlConnection.ResetNotReadNum(userId)
  local sql = bind_sql(FriendSql.UpdateReadMark, userId)
  local result = _db:exec(sql)
end

function SqlConnection.RemoveFriendChatTable(userId)
  local sql = bind_sql(FriendSql.RemoveTable, userId)
  local result = _db:exec(sql)
end

function SqlConnection.Test(userId)
  SqlConnection.GetMsg(userId, 1, 4)
end

local function bind_DungeonEquipRedDot_sql(stmt)
  return stmt:gsub("#", "dungeon_equip_reddot")
end

function SqlConnection.CteateDungeonEquipRedDotTable()
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.CreateTable)
  _db:exec(sql)
end

function SqlConnection.StoreDungeonEquipRedDotKey(clientId, reddotData)
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " StoreDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return
  end
  SqlConnection.CteateDungeonEquipRedDotTable()
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

function SqlConnection.GetDungeonEquipRedDotKey(clientId)
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " GetDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return
  end
  SqlConnection.CteateDungeonEquipRedDotTable()
  local protocol = LocalProtocolManager.CreateProtocol("dungeonreddot.sgetdungeonequipreddot")
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
    local info = LocalProtocolManager.CreateBean("data.equipreddotdata")
    info.roleKey = row[2]
    info.weaponKey = row[3]
    info.armorKey = row[4]
    info.jewelryKey = row[5]
    table.insert(protocol.redDotData, info)
  end
  stmt:finalize()
  SqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function SqlConnection.RemoveDungeonEquipRedDotKeyTable(clientId)
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " RemoveDungeonEquipRedDotKeyTable client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return
  end
  local sql = bind_DungeonEquipRedDot_sql(DungeonEquipRedDotSql.RemoveTable)
  local result = _db:exec(sql)
end

function SqlConnection.DeleteOneLineDungeonEquipRedDotKey(clientId, roleKey, equipKey)
  if clientId ~= _clientId then
    LogErrorFormat(" SqlConnection ", " DeleteOneLineDungeonEquipRedDotKey client id %s is different with sqlconnection _clientId %s", clientId, _clientId)
    return
  end
  SqlConnection.CteateDungeonEquipRedDotTable()
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
