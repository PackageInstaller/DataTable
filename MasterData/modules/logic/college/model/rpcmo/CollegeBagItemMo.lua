-- chunkname: @modules/logic/college/model/rpcmo/CollegeBagItemMo.lua

module("modules.logic.college.model.rpcmo.CollegeBagItemMo", package.seeall)

local CollegeBagItemMo = pureTable("CollegeBagItemMo")

function CollegeBagItemMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.count = data.count
	self.itemCo = lua_college_item.configDict[self.id]
end

function CollegeBagItemMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBagItemMo" then
		return false
	end

	local isSame = true

	if self.uid ~= otherMo.uid then
		isSame = false

		logError(string.format("CollegeBagItemMo compareWith uid not same: %s >> %s", self.uid, otherMo.uid))
	end

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeBagItemMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.count ~= otherMo.count then
		isSame = false

		logError(string.format("CollegeBagItemMo compareWith count not same: %s >> %s", self.count, otherMo.count))
	end

	return isSame
end

return CollegeBagItemMo
