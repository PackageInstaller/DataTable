-- chunkname: @modules/logic/necrologiststory/prefs/NecrologistStoryPlayerPrefs.lua

module("modules.logic.necrologiststory.prefs.NecrologistStoryPlayerPrefs", package.seeall)

local NecrologistStoryPlayerPrefs = class("NecrologistStoryPlayerPrefs", BaseModel)

function NecrologistStoryPlayerPrefs:clear()
	self.prefsDataDict = {}
end

function NecrologistStoryPlayerPrefs:getPrefsData(key)
	local data = self.prefsDataDict[key]

	if not data then
		data = NecrologistStoryPlayerPrefsDataBase.New(key)
		self.prefsDataDict[key] = data
	end

	return data
end

function NecrologistStoryPlayerPrefs:isExist(key, id)
	local data = self:getPrefsData(key)

	return data:isExist(id)
end

function NecrologistStoryPlayerPrefs:setExist(key, id)
	local data = self:getPrefsData(key)

	data:setExist(id)
end

function NecrologistStoryPlayerPrefs:deletePrefsData(rolestoryId)
	self.prefsDataDict = {}

	for k, v in pairs(NecrologistStoryEnum.PrefsKey) do
		GameUtil.deleteKey(v)
	end

	local key = RoleStoryModel.instance:getRoleStoryDungeonUnlockAnimKey(rolestoryId)

	if key then
		PlayerPrefsHelper.deleteKey(key)
	end
end

NecrologistStoryPlayerPrefs.instance = NecrologistStoryPlayerPrefs.New()

return NecrologistStoryPlayerPrefs
