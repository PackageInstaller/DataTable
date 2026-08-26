-- chunkname: @modules/logic/necrologiststory/prefs/NecrologistStoryPlayerPrefsDataBase.lua

module("modules.logic.necrologiststory.prefs.NecrologistStoryPlayerPrefsDataBase", package.seeall)

local NecrologistStoryPlayerPrefsDataBase = class("NecrologistStoryPlayerPrefsDataBase")

function NecrologistStoryPlayerPrefsDataBase:ctor(key)
	self.prefsKey = key

	self:initData()
end

function NecrologistStoryPlayerPrefsDataBase:initData()
	self.dict = {}

	local val = GameUtil.playerPrefsGetStringByUserId(self.prefsKey, "")
	local list = string.splitToNumber(val, "#")

	for _, v in ipairs(list) do
		self.dict[v] = true
	end
end

function NecrologistStoryPlayerPrefsDataBase:isExist(id)
	return self.dict[id]
end

function NecrologistStoryPlayerPrefsDataBase:setExist(id)
	if self:isExist(id) then
		return
	end

	self.dict[id] = true

	self:saveData()
end

function NecrologistStoryPlayerPrefsDataBase:saveData()
	local list = {}

	for id, _ in pairs(self.dict) do
		table.insert(list, id)
	end

	GameUtil.playerPrefsSetStringByUserId(self.prefsKey, table.concat(list, "#"))
end

return NecrologistStoryPlayerPrefsDataBase
