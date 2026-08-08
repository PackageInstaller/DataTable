--这个是用来在没有连接服务器的情况下，用于模拟服务器逻辑的代码
--对应的是ServerGameGlobal，这个代码在服务器上运行

local ClientGameGlobal = {}

local json = require "cjson"
local Player = require("PlayerAll").loadAllModules()
local SrvDB
-- LuaLogger.ds("user", GlobalInfo.account)
ClientGameGlobal.Random = require "Random":new(123)

local client_max_item_id = 0
local client_max_battle_id = 0
local max_uid = 0

function ClientGameGlobal.GetNewId()
	client_max_item_id = client_max_item_id + 1
	return client_max_item_id
end

function ClientGameGlobal.GetNewBattleId()
	client_max_battle_id = client_max_battle_id + 1
	return client_max_battle_id
end

function ClientGameGlobal.GetWorldStartTime()
	return os.time{year=2017, month=5, day=5, hour=10, min=0, sec=0}
end

local function _getUserSaveKeyByUid(uid)
	return "SrvUser" .. uid
end

-- Non Serialized Version
-- local user_info
-- function ClientGameGlobal.InsertDB(dbname, data)
-- 	for k,v in pairs(data) do
-- 		if type(v) == "table" then
-- 			data[k] = json.encode(v)
-- 		end
-- 	end

-- 	if dbname == "user" then
-- 		user_info = data
-- 	end
	
-- 	return 0
-- end

-- function ClientGameGlobal.GetUserInfoByAid(aid)
-- 	return { user_info }
-- end
local function confirmSrvDB(account)
	if SrvDB then
		return
	end

	account = account or GlobalInfo.account
	SrvDB = require "DPlayerPrefs":new(account)
	LuaLogger.ds("GlobalInfo.account", account)
end

function ClientGameGlobal.GetSimUserSnapshotData()
	confirmSrvDB()

	local serData = Player.getDataInSerialise(GV.SimUser)
	serData.client_max_item_id = client_max_item_id or SrvDB:GetInt("client_max_item_id")
	serData.client_max_battle_id = client_max_battle_id or SrvDB:GetInt("client_max_battle_id")
	
	return serData
end

function ClientGameGlobal.GetSimUserSnapshotStr()
	local data = ClientGameGlobal.GetSimUserSnapshotData()
	return tablex.dump(data)
end

local function saveData(data)
	local serData = Player.getJson(data)

	LuaLogger.ws("saveData", GlobalInfo.account, data.uid, serData)
	confirmSrvDB()
	SrvDB:SetString(_getUserSaveKeyByUid(data.uid), serData)
	SrvDB:SetInt("client_max_item_id", client_max_item_id)
	SrvDB:SetInt("client_max_battle_id", client_max_battle_id)
	SrvDB:SetInt("max_uid", max_uid)
end

-- 创建一个新的用户
---@param data table
---@return Player
function ClientGameGlobal.CreateUser(data)
	-- 这里没做有哪些对象的检查，目的为了方便看到到底有没有不正确的存储
	data.gmLevel = 10
	max_uid = max_uid + 1
	data.uid = max_uid
	saveData(data)

	local infoDb = Player.convertUserInfoToProto(data)
    local user = Player.loadFromUserInfoDB({}, infoDb, true)
	-- LuaLogger.ds("CreateUser",data.uid,infoDb.uid)
	return user
end

-- function ClientGameGlobal.InsertDB(dbname, data)
-- 	if dbname == "user" then
-- 		data.gmLevel = 10
-- 		saveData(data)
-- 	end
	
-- 	return 0
-- end

local userList = {}
function ClientGameGlobal.GetUserListByAid(aid)
	confirmSrvDB()
	
	max_uid = SrvDB:GetInt("max_uid", max_uid)
	if max_uid > 0 then
		for i = 1, max_uid do
			local value = SrvDB:GetString(_getUserSaveKeyByUid(i))
			if value ~= "" then
				LuaLogger.ds("value1", value)
				value = json.decode(value)
				LuaLogger.ds("value2", tablex.dump(value))
				userList[i] = Player.loadFromUserInfoDB({}, value, true)
				--LuaLogger.ds("value3 convert from db", tablex.dump(userList[i]}))
			end
		end
	end

	client_max_item_id = SrvDB:GetInt("client_max_item_id")
	client_max_battle_id = SrvDB:GetInt("client_max_battle_id")

	return userList
end

function GF.GetDatalogNode()
	return
end

function ClientGameGlobal.GetUserInfo(uid)
	return userList[uid]
end

function ClientGameGlobal.DeleteUser(uid)
	userList[uid] = nil
	-- todo:文件里还没有实际删除
	return true
end

function ClientGameGlobal.GetUserInfoByKeys(uid, keys)
	return {}
end

function ClientGameGlobal.UpdateUserInfoByUid(uid, tb)
    -- 这里的tb必须是所有的Unit数据
	--tb.gmLevel = 10
	saveData(tb)
end

function ClientGameGlobal.GetMailList()
	return {}
end

function ClientGameGlobal.ClearCommonCache()
	
end

function ClientGameGlobal.EnterPlayer(data)
end

function ClientGameGlobal.ExitPlayer(uid)
end

function ClientGameGlobal.UpdatePlayer(agent, userinfo)
end

function ClientGameGlobal.GetAgent()
	return 1
end

-- Client专属，用于保存当前角色状态的快照到本地，这样用本地模式重新启动的时候，如果还是该帐号就可以用之前的数据。
--function ClientGameGlobal.SaveMe(account)
--	ClientGameGlobal.ReplaceSimData(account or GlobalInfo.account, Me)
--end

function ClientGameGlobal.GetRuntimeMeDb(account)
	return tablex.dump(Me:getDataInSerialise())
end

function ClientGameGlobal.ReplaceSimData(account, data)
	local pref = require "DPlayerPrefs":new(account)
	local serData = Player.getJson(data)
	local key = _getUserSaveKeyByUid(data.uid)
	pref:SetString(key, serData)

	local maxUid = pref:GetInt("max_uid", -1)
	if maxUid == -1 then -- 说明之前没有数据，但这个值如果没有，读取角色列表会读不出来
		pref:SetInt("max_uid", 1)
	end

	confirmSrvDB(account)
	if data.client_max_item_id and data.client_max_item_id > SrvDB:GetInt("client_max_item_id") then
		SrvDB:SetInt("client_max_item_id", data.client_max_item_id)
	end

	if data.client_max_battle_id and data.client_max_battle_id > SrvDB:GetInt("client_max_battle_id") then
		SrvDB:SetInt("client_max_battle_id", data.client_max_battle_id)
	end

	LuaLogger.d("Replaced account %s", key)
end

function ClientGameGlobal.GetSimPlayer(account, uid)
	uid = tonumber(uid)
	if not uid or uid > 3 or uid < 0 then
		uid = 1
	end

	if Standalone then
		local pref = require "DPlayerPrefs":new(account)
		local dbInfo = json.decode(pref:GetString(_getUserSaveKeyByUid(uid)))
		local player = {}
		Player.loadFromUserInfoDB(player, dbInfo, true)
		return player
	else
		return Me:getDataInSerialise()
	end
end

function ClientGameGlobal.GetDbDataCount()
	return 1
end

function ClientGameGlobal.GetOtherUserByPower(index)
	--local value = SrvDB:GetString("SrvUser1")
	--return value
end

function ClientGameGlobal.CanCreateChar(aid, name)
	return true
end

function ClientGameGlobal.TellCreateChar(aid)
	return true
end

function ClientGameGlobal.GetActivities()
	return {}
end

function ClientGameGlobal.GuildRequest(funcName, ...)
	--LuaLogger.ds("GuildRequest", funcName, ...)
end

function ClientGameGlobal.MailAction(uid, mailId, action)
	-- todo: 这里应该处理邮件的各种逻辑
	return {}
end

return ClientGameGlobal