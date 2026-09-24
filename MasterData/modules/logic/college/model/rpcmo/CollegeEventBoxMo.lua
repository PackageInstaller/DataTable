-- chunkname: @modules/logic/college/model/rpcmo/CollegeEventBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeEventBoxMo", package.seeall)

local CollegeEventBoxMo = pureTable("CollegeEventBoxMo")

function CollegeEventBoxMo:init(data)
	self.eventId = data.eventId
	self.co = lua_college_event.configDict[self.eventId[1]]
end

function CollegeEventBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeEventBoxMo" then
		return false
	end

	local isSame = true

	if #self.eventId ~= #otherMo.eventId then
		isSame = false

		logError(string.format("CollegeEventBoxMo compareWith eventId count not same: %s >> %s", #self.eventId, #otherMo.eventId))
	else
		for i = 1, #self.eventId do
			if self.eventId[i] ~= otherMo.eventId[i] then
				isSame = false

				logError(string.format("CollegeEventBoxMo compareWith eventId not same: %s >> %s", self.eventId[i], otherMo.eventId[i]))
			end
		end
	end

	return isSame
end

return CollegeEventBoxMo
