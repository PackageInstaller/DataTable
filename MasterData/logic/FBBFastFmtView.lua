-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBFastFmtView.lua

module("logic.extensions.fbbchallenge.view.mission.FBBFastFmtView", package.seeall)

local FBBFastFmtView = class("FBBFastFmtView", FastSupportFormation)

function FBBFastFmtView:_getCurFormation()
	return FbbchallengeModel.instance:getCurFormation()
end

function FBBFastFmtView:_getPets()
	local pets = BagPetsController.instance:getFightBagPet()
	local helpPets = FbbchallengeModel.instance:getAllHelpPets()

	for _, v in ipairs(helpPets) do
		table.insert(pets, v)
	end

	return pets
end

function FBBFastFmtView:_getSupportCfgs()
	local supportPlanId = FbbchallengeModel.instance:getCurrSupportPlanId()

	return FbbchallengeConfig.instance:getSupportCfg(supportPlanId) or {}
end

FBBFastFmtView.instance = FBBFastFmtView.New()

return FBBFastFmtView
