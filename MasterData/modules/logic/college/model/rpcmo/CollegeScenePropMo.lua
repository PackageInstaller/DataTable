-- chunkname: @modules/logic/college/model/rpcmo/CollegeScenePropMo.lua

module("modules.logic.college.model.rpcmo.CollegeScenePropMo", package.seeall)

local CollegeScenePropMo = pureTable("CollegeScenePropMo")

function CollegeScenePropMo:init(data)
	self.hotfix = data.hotfix
	self.clientData = data.clientData
	self.stage = data.stage
	self.round = data.round
	self.clientDataMo = CollegeClientDataMo.Create(data.clientData)
end

function CollegeScenePropMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeScenePropMo" then
		return false
	end

	local isSame = true

	if self.stage ~= otherMo.stage then
		isSame = false

		logError(string.format("CollegeScenePropMo compareWith stage not same: %s >> %s", self.stage, otherMo.stage))
	end

	if self.round ~= otherMo.round then
		isSame = false

		logError(string.format("CollegeScenePropMo compareWith round not same: %s >> %s", self.round, otherMo.round))
	end

	return isSame
end

return CollegeScenePropMo
