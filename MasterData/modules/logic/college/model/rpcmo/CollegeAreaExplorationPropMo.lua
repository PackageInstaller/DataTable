-- chunkname: @modules/logic/college/model/rpcmo/CollegeAreaExplorationPropMo.lua

module("modules.logic.college.model.rpcmo.CollegeAreaExplorationPropMo", package.seeall)

local CollegeAreaExplorationPropMo = pureTable("CollegeAreaExplorationPropMo")

function CollegeAreaExplorationPropMo:init(data)
	self.progress = data.progress
	self.remainRound = data.remainRound
end

function CollegeAreaExplorationPropMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeAreaExplorationPropMo" then
		return false
	end

	local isSame = true

	if self.progress ~= otherMo.progress then
		isSame = false

		logError(string.format("CollegeAreaExplorationPropMo compareWith progress not same: %s >> %s", self.progress, otherMo.progress))
	end

	if self.remainRound ~= otherMo.remainRound then
		isSame = false

		logError(string.format("CollegeAreaExplorationPropMo compareWith remainRound not same: %s >> %s", self.remainRound, otherMo.remainRound))
	end

	return isSame
end

return CollegeAreaExplorationPropMo
