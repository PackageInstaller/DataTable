-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingFastFmtView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingFastFmtView", package.seeall)

local LightKingFastFmtView = class("LightKingFastFmtView", FastSupportFormation)

function LightKingFastFmtView:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function LightKingFastFmtView:_getPets()
	local challengeType = LightKingModel.instance:getCurChallengeType()
	local pets = BagPetsController.instance:getFightBagPet()
	local helpPets = LightKingModel.instance:getAllHelpPets()

	for _, v in ipairs(helpPets) do
		table.insert(pets, v)
	end

	return pets
end

function LightKingFastFmtView:_getSupportCfgs()
	local stageCfg = LightKingModel.instance:getCurStageCfg()

	if stageCfg then
		return LightKingConfig.instance:getSupportCfg(stageCfg.supportPlanId) or {}
	else
		return {}
	end
end

LightKingFastFmtView.instance = LightKingFastFmtView.New()

return LightKingFastFmtView
