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

function NecrologistStoryPlayerPrefs:deletePrefsData()
	self.prefsDataDict = {}

	for k, v in pairs(NecrologistStoryEnum.PrefsKey) do
		GameUtil.deleteKey(v)
	end
end

NecrologistStoryPlayerPrefs.instance = NecrologistStoryPlayerPrefs.New()

return NecrologistStoryPlayerPrefs
