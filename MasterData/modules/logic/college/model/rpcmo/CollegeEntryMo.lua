-- chunkname: @modules/logic/college/model/rpcmo/CollegeEntryMo.lua

module("modules.logic.college.model.rpcmo.CollegeEntryMo", package.seeall)

local CollegeEntryMo = pureTable("CollegeEntryMo")

function CollegeEntryMo:init(data)
	self.id = data.id
	self.locked = data.locked
	self.co = lua_college_entry.configDict[self.id]
	self.unlock = true
end

function CollegeEntryMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeEntryMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeEntryMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.locked ~= otherMo.locked then
		isSame = false

		logError(string.format("CollegeEntryMo compareWith locked not same: %s >> %s", self.locked, otherMo.locked))
	end

	return isSame
end

function CollegeEntryMo.CreateLock(lvCo)
	local mo = CollegeEntryMo.New()

	mo.lvCo = lvCo
	mo.unlock = false

	return mo
end

return CollegeEntryMo
