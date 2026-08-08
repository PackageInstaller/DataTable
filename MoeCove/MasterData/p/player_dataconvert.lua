-- Desc: 用于Player的数据转换
---@class Player
local Player = require "Player"
local crypt = require "crypt"
local json = require "cjson"
json.encode_sparse_array(true)

JsonNull = json.decode("null") -- userdata: 00000000
local Null = json.encode(JsonNull) -- "null"
local string_format = string.format
local table_insert = table.insert

local cosUrl = "https://cove-1317257923.cos.ap-shanghai.myqcloud.com/gameData/"


---@class ServerMailInfo
---@field id integer
---@field state integer
---@field stamp integer
---@field title string
---@field sender string
---@field content string
---@field reward integer[]

-- 邮件奖励结构转换
---@param mail ServerMailInfo
---@return MailInfo
function Player.convertMailToProto(mail)
	mail = clone(mail)

	if mail.extra then
		mail.sender	= mail.extra.sender
		mail.extra = nil
	end

	if not mail.sender then
		mail.sender = "系统"
	end

	return mail
end

function Player.filterMailForProto(mail)
    mail.useruid = nil
    mail.sysid = nil
    mail.touid = nil
    mail.type = nil
    mail.fromuid = nil
    mail.delmark = nil
	mail.exCondition = nil
end

-- 邮件奖励结构批量转换
---@param mails ServerMailInfo[]
---@return MailInfo[]
function Player.convertMailsToProto(mails)
	local mailsProto = {}
	for i,v in ipairs(mails) do
		table.insert(mailsProto, Player.convertMailToProto(v))
	end

	return mailsProto
end

-- { [5] = { uid = 32, id = 5 } } 把这种形式序列化，cjson有bug，索引在10以内，encode出来不存在的索引都是null
-- 比如[null,null,null,null,{"id":5,"uid":32}]，且decode出来前面null的地方是userdata: 00000000
-- 实际需求是序列化为{"5":{"uid":32, "id":5}}
---@param values table
---@param name string
---@return string|table
function Player.convertKeyToStringJson(values, name)
	local proto = {}
	for k,v in pairs(values) do
		proto[tostring(k)] = clone(v)
	end

	if GV.IsServer and Player.allowPartSave(name) then
		return proto
	end

	return json.encode(proto)
end

-- { "5": { "uid": 32, "id": 5 } } 把这种形式反序列化
---@param intKeyValues string
---@return table
function Player.converIntKeyFromJsonArray(intKeyValues)
	local data = {}

	intKeyValues = json.decode(intKeyValues)
	for k,v in pairs(intKeyValues) do
		data[tonumber(k)] = clone(v)
	end

	return data
end

--json保存部分数据
function Player.savePartJsonSetString(values, name)
	--JSON_SET(IFNULL(test, JSON_OBJECT()), '$."researchExp"', 8)
	--JSON_REMOVE(IFNULL(test, JSON_OBJECT()), '$."researchExp"')
	--JSON_REMOVE(JSON_SET(IFNULL(test, JSON_OBJECT()), '$.researchExp', 0), '$."key1"')

	-- local updateList = {}
	-- local delList = {}
	-- for k, v in pairs(values) do
	-- 	local key = string_format("\'$.\"%s\"\'", k)
	-- 	if v == "__null__" then
	-- 		table_insert(delList, key)
	-- 	elseif istable(v) then
	-- 		table_insert(updateList, key)
	-- 		table_insert(updateList, string_format("CAST(\'%s\' AS JSON)", json.encode(v)))
	-- 	elseif isstring(v) or isnumber(v) or isBoolean(v) then
	-- 		table_insert(updateList, key)
	-- 		table_insert(updateList, v)
	-- 	else
	-- 		LuaLogger.es("save type:", type(v), name)
	-- 	end
	-- end

	-- local jsonSql
	-- if next(delList) and next(updateList) then
	-- 	local jsonFormat = "JSON_REMOVE(JSON_SET(IFNULL(@key_%s, JSON_OBJECT()), %s), %s)"
	-- 	jsonSql = string_format(jsonFormat, name, table.concat(updateList, ","), table.concat(delList, ","))
	-- elseif next(delList) then
	-- 	local jsonFormat = "JSON_REMOVE(IFNULL(@key_%s, JSON_OBJECT()), %s)"
	-- 	jsonSql = string_format(jsonFormat, name, table.concat(delList, ","))
	-- elseif next(updateList) then
	-- 	local jsonFormat = "JSON_SET(IFNULL(@key_%s, JSON_OBJECT()), %s)"
	-- 	jsonSql = string_format(jsonFormat, name, table.concat(updateList, ","))
	-- end
	-- LuaLogger.ds("savePartJsonSetString ", jsonSql)
	-- return jsonSql
end

--武器用fromJsonFunc方法
---@param intKeyValues string
---@return table<integer, WeaponInfo>
function Player.weaponFromJsonArray(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end

	intKeyValues = json.decode(intKeyValues)
	for k,v in pairs(intKeyValues) do
		if not next(v.attributeList) then
			LuaLogger.es("not attributeList,2", k, tablex.dump(v))
		end
		data[tonumber(k)] = clone(v)
	end

	return data
end

--武器用toJsonFunc方法
---@param values table<integer, WeaponInfo>
---@return string|table
function Player.weaponToJsonFunc(values, name)
	local data = {}

	for k,v in pairs(values) do
		if v ~= "__null__" and (not v.attributeList or not next(v.attributeList)) then
			LuaLogger.es("not attributeList,1", k, tablex.dump(v))
		end
		data[tostring(k)] = clone(v)
	end

	if GV.IsServer and Player.allowPartSave(name) then
		return data
	end

	return json.encode(data)
end

--家园用fromJsonFunc方法
---@param intKeyValues string
---@return HomeLandinfo
function Player.homeLandFromJsonArray(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end

	intKeyValues = json.decode(intKeyValues)
	-- for k,v in pairs(intKeyValues) do
	-- 	if type(v) == "table" then
	-- 		data[k] = {}
	-- 		for k1, v1 in pairs(v) do
	-- 			local kk = tonumber(k1)
	-- 			if kk == nil then
	-- 				kk = k1
	-- 			end
	-- 			data[k][kk] = clone(v1)
	-- 		end
	-- 	else
	-- 		data[k] = v
	-- 	end
	-- end



	-- if data.prosperityInfo and data.prosperityInfo.globalConditionProgress then
	-- 	local fixed = {}
	-- 	for k, v in pairs(data.prosperityInfo.globalConditionProgress) do
	-- 		fixed[tonumber(k) or k] = v
	-- 	end
	-- 	data.prosperityInfo.globalConditionProgress = fixed
	-- end

	DLuaUtil.MergeParseNumbers(data, intKeyValues)
	return data
end

--家园用toJsonFunc方法
---@param values HomeLandinfo
---@return string
function Player.homeLandToJsonFunc(values)
	local data = {}
	for k,v in pairs(values) do
		if not data[tostring(k)] then
			data[tostring(k)] = {}
		end
		if type(v) == "table" then
			for k1, v1 in pairs(v) do
				data[tostring(k)][tostring(k1)] = clone(v1)
			end
		else
			data[tostring(k)] = v
		end
	end
	return json.encode(data)
end



--图鉴用fromJsonFunc方法
---@param intKeyValues string
---@return HandbookInfo
function Player.handbookFromJsonArray(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end

	intKeyValues = json.decode(intKeyValues)
	for k, v in pairs(intKeyValues) do
		if v.data then
			for k1, v1 in pairs(v.data) do
				if not data[tonumber(k)] then
					data[tonumber(k)] = {}
					data[tonumber(k)].data = {}
				end
				data[tonumber(k)].data[tonumber(k1)] = clone(v1)
			end
		end
	end

	return data
end

--派遣用fromJsonFunc方法
function Player.dispatchDataFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	data.finishRouteList = intKeyValues.finishRouteList
	data.rewardRecordList = intKeyValues.rewardRecordList
	data.dispatchTaskList = {}
	data.dispatchRandomTaskList = {}
	if intKeyValues.dispatchTaskList == nil then
		intKeyValues.dispatchTaskList = {}
	end
	if intKeyValues.dispatchRandomTaskList == nil then
		intKeyValues.dispatchRandomTaskList = {}
	end
	for key, value in pairs(intKeyValues.dispatchTaskList) do
		data.dispatchTaskList[tonumber(key)] = value
	end
	for key, value in pairs(intKeyValues.dispatchRandomTaskList) do
		data.dispatchRandomTaskList[tonumber(key)] = value
	end
	return data
end

--派遣用toJsonFunc方法
function Player.dispatchDataToJsonFunc(values)
	local data = {}
	data.finishRouteList = values.finishRouteList
	data.rewardRecordList = values.rewardRecordList
	data.dispatchTaskList = {}
	data.dispatchRandomTaskList = {}
	if values.dispatchRandomTaskList then
		for k, v in pairs(values.dispatchRandomTaskList) do
			data.dispatchRandomTaskList[tostring(k)] = clone(v)
		end
	end
	if values.dispatchTaskList then
		for k, v in pairs(values.dispatchTaskList) do
			data.dispatchTaskList[tostring(k)] = clone(v)
		end
	end
	return json.encode(data)
end

--周期活动用fromJsonFunc方法
function Player.regularActivityDataFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	
	-- 解析模拟演习数据
	data.simulatedActivity = {}
	if intKeyValues.simulatedActivity then
		local simData = intKeyValues.simulatedActivity
		data.simulatedActivity.maxFloor = tonumber(simData.maxFloor)
		data.simulatedActivity.nowPeriod = tonumber(simData.nowPeriod)
		data.simulatedActivity.closingTime = tonumber(simData.closingTime)
		data.simulatedActivity.simulatedLevelMap = {}
		for key, value in pairs(simData.simulatedLevelMap or {}) do
			data.simulatedActivity.simulatedLevelMap[tonumber(key)] = value
		end
	end
	
	-- 解析危境攻坚数据
	data.bossActivity = {}
	if intKeyValues.bossActivity then
		local bossData = intKeyValues.bossActivity
		data.bossActivity.nowPeriod = tonumber(bossData.nowPeriod)
		data.bossActivity.closingTime = tonumber(bossData.closingTime)
		data.bossActivity.scoreRewardList = bossData.scoreRewardList
		data.bossActivity.bossLevelMap = {}
		for key, value in pairs(bossData.bossLevelMap or {}) do
			data.bossActivity.bossLevelMap[tonumber(key)] = value
		end
	end
	
	return data
end

--周期活动用toJsonFunc方法
function Player.regularActivityDataToJsonFunc(values)
	local data = {}
	
	-- 序列化模拟演习数据
	data.simulatedActivity = {}
	if values.simulatedActivity then
		data.simulatedActivity.maxFloor = values.simulatedActivity.maxFloor
		data.simulatedActivity.nowPeriod = values.simulatedActivity.nowPeriod
		data.simulatedActivity.closingTime = values.simulatedActivity.closingTime
		data.simulatedActivity.simulatedLevelMap = {}
		for k, v in pairs(values.simulatedActivity.simulatedLevelMap or {}) do
			data.simulatedActivity.simulatedLevelMap[tostring(k)] = clone(v)
		end
	end
	
	-- 序列化危境攻坚数据
	data.bossActivity = {}
	if values.bossActivity then
		data.bossActivity.nowPeriod = values.bossActivity.nowPeriod
		data.bossActivity.closingTime = values.bossActivity.closingTime
		data.bossActivity.scoreRewardList = values.bossActivity.scoreRewardList
		data.bossActivity.bossLevelMap = {}
		for k, v in pairs(values.bossActivity.bossLevelMap or {}) do
			data.bossActivity.bossLevelMap[tostring(k)] = clone(v)
		end
	end
	
	return json.encode(data)
end

--科技树用fromJsonFunc方法
function Player.technologyTreeFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	data.researchLevelList = intKeyValues.researchLevelList
	data.researchExpList = intKeyValues.researchExpList
	data.treeNodeMap = {}
	for key, value in pairs(intKeyValues.treeNodeMap) do
		data.treeNodeMap[tonumber(key)] = value
	end
	return data
end

--科技树用toJsonFunc方法
function Player.technologyTreeToJsonFunc(values)
	local data = {}
	data.researchLevelList = values.researchLevelList
	data.researchExpList = values.researchExpList
	data.treeNodeMap = {}
	if values.treeNodeMap then
		for k, v in pairs(values.treeNodeMap) do
			data.treeNodeMap[tostring(k)] = clone(v)
		end
	end
	return json.encode(data)
end

--好感度用fromJsonFunc方法
function Player.affectionDataFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	data.limitCount = tonumber(intKeyValues.limitCount)
	data.delegateEventList = intKeyValues.delegateEventList
	data.affectionEventMap = {}

	for key, value in pairs(intKeyValues.affectionEventMap) do
		data.affectionEventMap[tonumber(key)] = value
	end

	return data
end

--好感度用toJsonFunc方法
function Player.affectionDataToJsonFunc(values)
	local data = {}
	data.limitCount = values.limitCount
	data.delegateEventList = values.delegateEventList
	data.affectionEventMap = {}

	for k, v in pairs(values.affectionEventMap) do
		data.affectionEventMap[tostring(k)] = clone(v)
	end
	return json.encode(data)
end

--图鉴用toJsonFunc方法
---@param values HandbookInfo
---@return string
function Player.handbookToJsonFunc(values)
	local data = {}

	for k, v in pairs(values) do
		if v.data then
			for k1, v1 in pairs(v.data) do
				if not data[tostring(k)] then
					data[tostring(k)] = {}
					data[tostring(k)].data = {}
				end
				data[tostring(k)].data[tostring(k1)] = clone(v1)
			end
		end
	end

	return json.encode(data)
end

--邮件收藏推送过滤
---@param data table<integer, MailCollectInfo>
function Player.mailCollectServerToProto(data)
	local rt = clone(data)
	local list = {}

	for k, v in pairs(rt) do
		if v.state then
			list[v.mailId] = cosUrl .. v.pathKey
		end
	end

	return list
end

--卡池相关数据推送过滤
---@param data table<integer, GachaRecordInfo>
function Player.gachaRecordServerToProto(data)
	local rt = clone(data)

	if rt.recordData then
		local tempUrlList = {}
		for k, v in pairs(rt.recordData.pathkeyList or {}) do
			if v.pathKey then
				tempUrlList[k] = cosUrl .. v.pathKey
			end
		end
		rt.recordData.tempUrlList = tempUrlList
	end

	return rt
end

-- 战斗开始信息
---@return BattleStartInfo?
function Player.battleStartInfoFromJsonFunc(intKeyValues)
	if not intKeyValues then
		return nil
	end

	local rt = json.decode(intKeyValues)
	local data = clone(rt)

	data.heroInfoMap = {}
	for k,v in pairs(rt.heroInfoMap) do
		local carryEquip = {}
		for k1, v1 in pairs(v.carryEquip) do
			carryEquip[tonumber(k1)] = clone(v1)
		end
		v.carryEquip = carryEquip
		local carryWeapon = {}
		for k1, v1 in pairs(v.carryWeapon) do
			carryWeapon[tonumber(k1)] = clone(v1)
		end
		v.carryWeapon = carryWeapon
		data.heroInfoMap[tonumber(k)] = clone(v)
	end

	data.weaponCidMap = {}
	for k,v in pairs(rt.weaponCidMap) do
		data.weaponCidMap[tonumber(k)] = v
	end

	return data
end

--普通商店数据用fromJsonFunc方法
function Player.generalShopDataFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	data.shopRefreshMap = {}
	for key, value in pairs(intKeyValues.shopRefreshMap) do
		data.shopRefreshMap[tonumber(key)] = clone(value)
	end
	data.generalGoodsMap = {}
	for key, value in pairs(intKeyValues.generalGoodsMap) do
		data.generalGoodsMap[tonumber(key)] = clone(value)
	end
	return data
end

--普通商店数据用toJsonFunc方法
function Player.generalShopDataToJsonFunc(values)
	local data = {}
	data.shopRefreshMap = {}
	for k, v in pairs(values.shopRefreshMap or {}) do
		data.shopRefreshMap[tostring(k)] = clone(v)
	end
	data.generalGoodsMap = {}
	for k, v in pairs(values.generalGoodsMap or {}) do
		data.generalGoodsMap[tostring(k)] = clone(v)
	end
	return json.encode(data)
end

--抽卡数据用fromJsonFunc方法
function Player.gachaDataFromJsonFunc(intKeyValues)
	local data = {}
	if not intKeyValues then
		return data
	end
	intKeyValues = json.decode(intKeyValues)
	data.countMap = {}
	for key, value in pairs(intKeyValues.countMap) do
		data.countMap[tonumber(key)] = clone(value)
	end
	data.recordData = intKeyValues.recordData or {}
	data.guarantMap = {}
	for key, value in pairs(intKeyValues.guarantMap) do
		local guarantInfo = {
			data = {}
		}
		if value.data then
			for countGroupId, num in pairs(value.data) do
				guarantInfo.data[tonumber(countGroupId)] = num
			end
		end
		data.guarantMap[tonumber(key)] = guarantInfo
	end
	return data
end

--抽卡数据用toJsonFunc方法
function Player.gachaDataToJsonFunc(values)
	local data = {}
	data.countMap = {}
	for k, v in pairs(values.countMap or {}) do
		data.countMap[tostring(k)] = clone(v)
	end
	data.recordData = values.recordData or {}
	data.guarantMap = {}
	for k, v in pairs(values.guarantMap or {}) do
		local guarantInfo = {
			data = {}
		}
		if v.data then
			for countGroupId, num in pairs(v.data) do
				guarantInfo.data[tostring(countGroupId)] = num
			end
		end
		data.guarantMap[tostring(k)] = guarantInfo
	end
	return json.encode(data)
end

--自定义数据fromJsonFunc方法
function Player.definedDataFromJsonFunc(values)
	local data = {}
	if not values then
		return data
	end
	values = json.decode(values)
	if values.definedBase64 then
		data = json.decode(crypt.base64decode(values.definedBase64))
	else
		--兼容老的格式加载
		data = values
	end
	return data
end

--自定义数据toJsonFunc方法
function Player.definedDataToJsonFunc(values)
	local data = {}
	if values then
		data.definedBase64 = crypt.base64encode(json.encode(values))
	end
	return json.encode(data)
end

local function directRet(v)
	return clone(v)
end

local function jsonDecode(v)
	return json.decode(v)
end

local function jsonEncode(v)
	return json.encode(v)
end

-- fromProtoFunc: 客户端收到服务端 协议数据->lua数据
-- toProtoFunc: 服务端数据发给客户端时候 lua数据->协议数据
-- fromJsonFunc: 服务端从数据库获得的数据 json->lua数据
-- toJsonFunc: 服务端存数据库数据 lua数据->json数据
-- sync是指是否需要同步到 MapService
-- needCalc需要重新计算各项属性的改变,skills本来是true，可是只有等级变化才需要，单独判断等级变化了再calc
-- indb需要序列化到数据库的
-- partSave 允许保存部分数据，toJsonFunc需要返回table
-- inUserInfo表示会通过UserInfoUpdate通知或者初始发给客户端的属性
-- firstLoad加载所有角色时需要用到的属性
-- roleList加载所有角色列表需要用到的属性
local serialiseValues = {
	--user
	["aid"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", roleList = true, firstLoad = true, sync = false, default = 0 },
	["uid"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", roleList = true, firstLoad = true, sync = true, default = 0 },
	["zoneId"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = false, firstLoad = true, sync = false, default = nil },
	["icon"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = true, default = 1 },
	["name"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", roleList = true, firstLoad = true, sync = true, default = "没名字" },
	["sex"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, needCalc = false, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = false, sync = false, default = SexType.Eunuch},
	["state"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, needCalc = false, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = false, indb = "user", firstLoad = true, sync = false, default = 0},
	["head"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, needCalc = false, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", roleList = true, firstLoad = true, sync = false, default = 0},
	["exp"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user", roleList = false, firstLoad = true, sync = true, default = 0},
	["level"] = {  fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user", roleList = false, firstLoad = true, sync = true, default = 1},
	["borntime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = false, default = 0 },
	["lastlogintime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = false, default = 0 },
	["lastonlinetime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = false, default = 0 },
	["lastofflinetime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = false, indb = "user", firstLoad = true, sync = false, default = 0 },
	["nextResetTime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = false, default = 0 },
	["lastResetTime"] = { fromProtoFunc = directRet, fromGM = tonumber, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = "user", firstLoad = true, sync = false, default = 0 },
	["servertime"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = false, firstLoad = false, sync = false, default = nil },
	["serverChannel"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = directRet, toJsonFunc = directRet, inUserInfo = true, indb = false, firstLoad = false, sync = false, default = nil },

	--user_ex01
	["heroList"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", partSave = true, roleList = false, firstLoad = false, sync = true, default = {} },
	["formationMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {} },
	["itemMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["ticket"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.TicketDefaultData },
	["equipMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", partSave = true, roleList = false, firstLoad = false, sync = true, default = {}},
	["onlyServerData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = false, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.OnlyServerData },
	["pveLevelMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["homeland"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.homeLandFromJsonArray, toJsonFunc = Player.homeLandToJsonFunc, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.homeland },
	["weaponMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.weaponFromJsonArray, toJsonFunc = Player.weaponToJsonFunc, inUserInfo = true, indb = "user_ex01", partSave = true, roleList = false, firstLoad = false, sync = true, default = {}},
	["missionList"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["userData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = true, sync = true, default = Config.UserData },
	["handbookData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.handbookFromJsonArray, toJsonFunc = Player.handbookToJsonFunc, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["skinList"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {} },
	["posterData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.GetConfigInfo("defaultSecretary") },
	["gachaData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = Player.gachaRecordServerToProto, fromJsonFunc = Player.gachaDataFromJsonFunc, toJsonFunc = Player.gachaDataToJsonFunc, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.GachaData},
	["headList"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}  },
	["chapterAwardMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["mailCollect"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = Player.mailCollectServerToProto, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = {}},
	["affectionData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.affectionDataFromJsonFunc, toJsonFunc = Player.affectionDataToJsonFunc, inUserInfo = true, indb = "user_ex01", roleList = false, firstLoad = false, sync = true, default = Config.affectionDefaultData },

	--user_ex02
	["technologyTree"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.technologyTreeFromJsonFunc, toJsonFunc = Player.technologyTreeToJsonFunc, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.technologyTreeData},
	["guideInfoMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["generalShopData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.generalShopDataFromJsonFunc, toJsonFunc = Player.generalShopDataToJsonFunc, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.generalShopData},
	["premiumShopMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["recordWaitOrderInfo"] = { fromProtoFunc = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = false, indb = "user_ex02", firstLoad = false, sync = false, default = {} },
	["payDiamond"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["triggerEventMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["dispatchData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.dispatchDataFromJsonFunc, toJsonFunc = Player.dispatchDataToJsonFunc, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.dispatchData},
	["regularActivityData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.regularActivityDataFromJsonFunc, toJsonFunc = Player.regularActivityDataToJsonFunc, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.regularActivityDefaultData},
	["extraRewardsMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.extraRewardsDefaultData},
	["funtionOpenMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["userDefined"] = { fromProtoFunc = luautil.unserialize, fromGM = directRet, toProtoFunc = luautil.serialize, fromJsonFunc = Player.definedDataFromJsonFunc, toJsonFunc = Player.definedDataToJsonFunc, inUserInfo = true, indb = "user_ex02", roleList = true, firstLoad = false, sync = true, default = {}},
	["qnaireMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {}},
	["genRoleFragData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.genRoleFragData },
	["weatherForecastData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = Config.weatherForecastData},
	["activityMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {} },
	["passDataMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {} },
	["signData"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {} },
	["cycleCardDatas"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {} },
	["miniPassMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex02", roleList = false, firstLoad = false, sync = true, default = {} },

	--user_ex03
	["combatIntelligenctInfo"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = Player.converIntKeyFromJsonArray, toJsonFunc = Player.convertKeyToStringJson, inUserInfo = true, indb = "user_ex03", roleList = false, firstLoad = false, sync = true, default = {} },
	["redeemCode"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex03", roleList = false, firstLoad = false, sync = true, default = {} },
	["shareMap"] = { fromProtoFunc = directRet, fromGM = directRet, toProtoFunc = directRet, fromJsonFunc = jsonDecode, toJsonFunc = jsonEncode, inUserInfo = true, indb = "user_ex03", roleList = false, firstLoad = false, sync = true, default = {} },
}

Player.SerialiseValues = serialiseValues

Player.NtfProtos = {"user.UserInfoUpdate"}

-- 从协议数据转换为玩家数据
function Player:propToProto(key, data)
	return serialiseValues[key].toProtoFunc(data or self[key])
end

-- 卸载不必要的数据
-- 遍历 serialiseValues 表中的所有键值对
-- 如果值的 firstLoad 属性为 false，则将 Player 对象中的对应键设为 nil
function Player:unloadNonNecessary()
	for k,v in pairs(serialiseValues) do
		if not v.firstLoad then
			self[k] = nil
		end
	end
end

-- 将用户信息从协议缓冲区转换为玩家数据
--- @param userInfo table: 用户信息协议缓冲区
--- @param useDefault boolean: 标志是否使用默认值来填补缺失的数据
--- @return table: 更新后的玩家数据
function Player:convertFromUserInfoProto(userInfo, useDefault)
	local setting = CommonLogic.LoadPlayerInitSettings()
    for k,v in pairs(serialiseValues) do
    	local value = userInfo[k]

        if value then
        	self[k] = v.fromProtoFunc(value)
        elseif v.inUserInfo and useDefault then
			value = setting[k] or clone(v.default)
        	self[k] = value
        end
        -- LuaLogger.d("initFromUserInfoProto %s fromProto:%s self:%s", k, tablex.dump(value), tablex.dump(self[k]))
    end

    return self
end

-- 从用户信息协议缓冲区初始化玩家数据
---@param userInfo UserInfo
function Player:initFromUserInfoProto(userInfo)
	self:convertFromUserInfoProto(userInfo, true)
    self:calcProp()
end

-- 从用户信息协议缓冲区更新玩家数据
---@param userInfo UserInfo
function Player:copyFromUserInfoProto(userInfo)
	self:convertFromUserInfoProto(userInfo, false)
    self:calcProp()
end

-- 将玩家数据转换为协议数据
---@param matchFunc function? 是否需要转换的字段
---@return UserInfo
function Player:convertUserInfoToProto(matchFunc)
	local proto = {}
    for k,v in pairs(serialiseValues) do
    	local value = self[k]

    	 --LuaLogger.d("start convertUserInfoToProto k:%s v:%s", k, tablex.dump(v))
    	if v.inUserInfo then
	        if value ~= nil and (not matchFunc or matchFunc(k)) then
	        	proto[k] = v.toProtoFunc(value)
	        	-- LuaLogger.d("convertUserInfoToProto %s self:%s toProto:%s", k, tablex.dump(value), tablex.dump(proto[k]))
	        else
	        	-- LuaLogger.e("No value for %s", k)
	        end
    	end
    end

    return proto
end

-- 所有标记为indb的如果有default都会转换
---@param info UserInfo
---@param useDefault boolean
---@param firstDefault boolean
---@return Player
function Player:loadFromUserInfoDB(info, useDefault, firstDefault)
	-- LuaLogger.ds("info is ", tablex.dump(info))
	local setting = CommonLogic.LoadPlayerInitSettings()
    for k,v in pairs(serialiseValues) do
        local value = info and info[k] or nil

		if value then
			self[k] = v.fromJsonFunc(value)
		else
			if useDefault or (firstDefault and v.firstLoad) then
				value = setting[k] or v.default
				value = clone(value)
				self[k] = value
			end
		end

        if self[k] == JsonNull then
            LuaLogger.ds(k, "is null")
        	self[k] = nil
        end
    end

    return self
end

--允许保存部分数据
--param {string} name
--return {boolean}
function Player.allowPartSave(name)
	local info = Player.SerialiseValues[name]
	return info and info.partSave
end

-- 转换玩家数据为数据库数据
---@return table
---@return table
function Player:convertToUserInfoDB()
	local dbInfos = {}
	local dbJsonPartInfos = {}
    for k,v in pairs(self) do
        local value = Player.SerialiseValues[k]
        if value and value.indb then
        	local saveInfos = value.partSave and dbJsonPartInfos or dbInfos
        	local dbInfo = saveInfos[value.indb]
        	if not dbInfo then
        		dbInfo = {}
        		saveInfos[value.indb] = dbInfo
        	end
            dbInfo[k] = value.toJsonFunc(clone(v), k)
        end
    end
    return dbInfos, dbJsonPartInfos
end

-- 获得玩家数据库数据
---@return table
function Player:getDataInSerialise()
	local info = {}
    for k,v in pairs(serialiseValues) do
    	if self[k] then
    		info[k] = self[k]
    	end
    end

    return info
end

-- 获得玩家数据库数据json
---@return string
function Player:getJson(extraData)
	local saveData = {}
	for k,v in pairs(Player.SerialiseValues) do
		if v.indb and self[k] ~= nil then
			saveData[k] = v.toJsonFunc(clone(self[k]))
		end
	end

	if extraData then
		for k, v in pairs(extraData) do
			saveData[k] = v
		end
	end

	return json.encode(saveData)
end

local singleFunc = 
{
    -- ["items"] = Player.convertItemToProto,
    -- ["equips"] = Player.converEquipToProto,
    -- ["heroes"] = Player.convertHeroUnitToProto,
    default = function (v) return v end
}

local function singleConvert(key, value)
    local func = singleFunc[key]
    if not func then
        func = singleFunc.default
    end
    return func(value)
end

local function getProtoArrayKey(name)
	local key = serialiseValues[name].arrayKey
	return key
end

-- 插入协议数据
---@param proto UserInfo
---@param key string
---@param data any
---@param bValue boolean?
---@return table?
function InsertProtoData(proto, key, data, bValue)
	return InsertData(proto, key, singleConvert(key, data), bValue, getProtoArrayKey)
end

return Player