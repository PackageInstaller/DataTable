-- chunkname: @modules/logic/college/model/rpcmo/CollegeBuildingRefinedPropMo.lua

module("modules.logic.college.model.rpcmo.CollegeBuildingRefinedPropMo", package.seeall)

local CollegeBuildingRefinedPropMo = pureTable("CollegeBuildingRefinedPropMo")

function CollegeBuildingRefinedPropMo:init(data)
	self.uid = data.uid
	self.newEntryId = data.newEntryId or {}
end

function CollegeBuildingRefinedPropMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeBuildingRefinedPropMo" then
		return false
	end

	local isSame = true

	if self.uid ~= otherMo.uid then
		isSame = false

		logError(string.format("CollegeBuildingRefinedPropMo compareWith uid not same: %s >> %s", self.uid, otherMo.uid))
	end

	if #self.newEntryId ~= #otherMo.newEntryId then
		isSame = false

		logError(string.format("CollegeBuildingRefinedPropMo compareWith newEntryId count not same: %s >> %s", #self.newEntryId, #otherMo.newEntryId))
	else
		for i = 1, #self.newEntryId do
			if self.newEntryId[i] ~= otherMo.newEntryId[i] then
				isSame = false

				logError(string.format("CollegeBuildingRefinedPropMo compareWith newEntryId not same: [%s] %s >> %s", i, self.newEntryId[i], otherMo.newEntryId[i]))

				break
			end
		end
	end

	return isSame
end

return CollegeBuildingRefinedPropMo
