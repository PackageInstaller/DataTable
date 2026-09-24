-- chunkname: @modules/logic/college/model/rpcmo/CollegeAttributeValueMo.lua

module("modules.logic.college.model.rpcmo.CollegeAttributeValueMo", package.seeall)

local CollegeAttributeValueMo = pureTable("CollegeAttributeValueMo")

function CollegeAttributeValueMo:init(data)
	self.id = data.id
	self.value = tonumber(data.value) or 0
end

function CollegeAttributeValueMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeAttributeValueMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeAttributeValueMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.value ~= otherMo.value then
		isSame = false

		logError(string.format("CollegeAttributeValueMo compareWith value not same: %s >> %s", self.value, otherMo.value))
	end

	return isSame
end

return CollegeAttributeValueMo
