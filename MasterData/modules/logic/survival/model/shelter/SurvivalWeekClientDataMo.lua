-- chunkname: @modules/logic/survival/model/shelter/SurvivalWeekClientDataMo.lua

module("modules.logic.survival.model.shelter.SurvivalWeekClientDataMo", package.seeall)

local SurvivalWeekClientDataMo = pureTable("SurvivalWeekClientDataMo")

function SurvivalWeekClientDataMo:ctor()
	self.keyReplace = {
		"ver",
		"nowUnlockMapsCount",
		"shopLevelUI",
		"shopHUDLevelUI",
		"decodingItemNum",
		"isBossWeak",
		"bossRepress",
		"bossRepressProgress",
		"techLockCheckLevel"
	}
end

function SurvivalWeekClientDataMo:init(data, weekMo)
	local dict = {}

	if not string.nilorempty(data) then
		dict = cjson.decode(data)
		dict = self:decompressionTable(dict)
	end

	if dict.ver and dict.ver ~= self:getCurVersion() then
		dict = {}
	end

	dict.ver = dict.ver or self:getCurVersion()
	dict.shopLevelUI = dict.shopLevelUI or {}
	dict.shopHUDLevelUI = dict.shopHUDLevelUI or {}
	dict.decodingItemNum = dict.decodingItemNum or 0
	dict.isBossWeak = dict.isBossWeak or false
	dict.bossRepress = dict.bossRepress or {}
	dict.bossRepressProgress = dict.bossRepressProgress or 0.089
	dict.techLockCheckLevel = dict.techLockCheckLevel or 1
	self.data = dict

	local isChange = false

	if isChange and weekMo.day > 0 then
		self.isDirty = true

		self:saveDataToServer()
	end
end

function SurvivalWeekClientDataMo:getCurVersion()
	return 1
end

function SurvivalWeekClientDataMo:setHeroCount(value)
	self.data.npcCount = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setNpcCount(value)
	self.data.heroCount = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setIsBossWeak(value)
	self.data.isBossWeak = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setDecodingItemNum(value)
	self.data.decodingItemNum = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:getReputationShopUILevel(shopId)
	local key = tostring(shopId)

	if self.data.shopLevelUI[key] then
		return self.data.shopLevelUI[key]
	end

	return 0
end

function SurvivalWeekClientDataMo:setReputationShopUILevel(shopId, level)
	if self:getReputationShopUILevel(shopId) ~= level then
		local key = tostring(shopId)

		self.data.shopLevelUI[key] = level
		self.isDirty = true
	end
end

function SurvivalWeekClientDataMo:getReputationShopHUDUILevel(shopId)
	local key = tostring(shopId)

	if self.data.shopHUDLevelUI[key] then
		return self.data.shopHUDLevelUI[key]
	end

	return 0
end

function SurvivalWeekClientDataMo:setReputationShopHUDUILevel(shopId, level)
	if self:getReputationShopHUDUILevel(shopId) ~= level then
		local key = tostring(shopId)

		self.data.shopHUDLevelUI[key] = level
		self.isDirty = true
	end
end

function SurvivalWeekClientDataMo:getBossRepress(fightId, id)
	if self.data.bossRepress.fightId == fightId and self.data.bossRepress.repress then
		for i, fId in ipairs(self.data.bossRepress.repress) do
			if fId == id then
				return true
			end
		end
	end

	return false
end

function SurvivalWeekClientDataMo:setBossRepress(fightId, id)
	if self.data.bossRepress.fightId ~= fightId then
		self.data.bossRepress.fightId = fightId
		self.data.bossRepress.repress = {}
	end

	table.insert(self.data.bossRepress.repress, id)

	self.isDirty = true
end

function SurvivalWeekClientDataMo:getBossRepressProgress(fightId)
	local key = tostring(fightId)

	if self.data.bossRepressProgress[key] then
		return self.data.bossRepressProgress[key]
	end

	return 0.089
end

function SurvivalWeekClientDataMo:setBossRepressProgress(value)
	self.data.bossRepressProgress = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:saveDataToServer(force)
	if SurvivalModel.instance:getSurvivalSettleInfo() then
		return
	end

	if force or self.isDirty then
		local newData = self:compressTable(self.data)

		SurvivalWeekRpc.instance:sendSurvivalSurvivalWeekClientData(cjson.encode(newData))

		self.isDirty = false
	end
end

function SurvivalWeekClientDataMo:setTechLockCheckLevel(value)
	if self.data.techLockCheckLevel ~= value then
		self.data.techLockCheckLevel = value
		self.isDirty = true
	end
end

function SurvivalWeekClientDataMo:compressTable(data)
	local newData = {}

	for key, v in pairs(data) do
		local index = self:compressKey(key)

		newData[index] = v
	end

	return newData
end

function SurvivalWeekClientDataMo:decompressionTable(data)
	local newData = {}

	for i, v in ipairs(data) do
		local index = self:deCompressKey(i)

		newData[index] = v
	end

	return newData
end

function SurvivalWeekClientDataMo:compressKey(key)
	for i, k in ipairs(self.keyReplace) do
		if k == key then
			return i
		end
	end
end

function SurvivalWeekClientDataMo:deCompressKey(index)
	return self.keyReplace[index]
end

return SurvivalWeekClientDataMo
