-- chunkname: @modules/logic/summon/model/SummonFlagSubModel.lua

module("modules.logic.summon.model.SummonFlagSubModel", package.seeall)

local SummonFlagSubModel = class("SummonFlagSubModel", BaseModel)

function SummonFlagSubModel:init()
	self._isNew = false
	self._newFlagDict = {}

	self:initLocalSave()
end

function SummonFlagSubModel:initLocalSave()
	self._lastDict = {}

	local rs = PlayerPrefsHelper.getString(self:getLocalKey(), "")

	if not string.nilorempty(rs) then
		local list = cjson.decode(rs)

		for _, id in ipairs(list) do
			self._lastDict[id] = 1
		end
	end
end

function SummonFlagSubModel:compareRecord(newPoolList)
	self._newFlagDict = {}

	local curSet = {}

	for i = 1, #newPoolList do
		local info = newPoolList[i]

		if not self._lastDict[info.id] then
			self._newFlagDict[info.id] = 1
		end

		curSet[info.id] = 1
	end

	local isDirty = false

	for poolId, _ in pairs(self._lastDict) do
		if not curSet[poolId] then
			self._lastDict[poolId] = nil
			isDirty = true
		end
	end

	if isDirty then
		self:flush()
	end

	SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
end

function SummonFlagSubModel:cleanFlag(poolId)
	if self._newFlagDict[poolId] then
		self._newFlagDict[poolId] = nil
		self._lastDict[poolId] = 1

		self:flush()
		SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
	end
end

function SummonFlagSubModel:hasNew()
	if self._newFlagDict and next(self._newFlagDict) then
		return true
	end

	return false
end

function SummonFlagSubModel:isNew(poolId)
	if self._newFlagDict and self._newFlagDict[poolId] then
		return true
	end

	return false
end

function SummonFlagSubModel:flush()
	local list = {}

	for poolId, _ in pairs(self._lastDict) do
		table.insert(list, poolId)
	end

	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(list))
end

function SummonFlagSubModel:getLocalKey()
	return "SummonFlagSubModel#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return SummonFlagSubModel
