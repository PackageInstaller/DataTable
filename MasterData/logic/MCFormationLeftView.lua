-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MCFormationLeftView.lua

module("logic.extensions.materialchallenge.view.MCFormationLeftView", package.seeall)

local MCFormationLeftView = class("MCFormationLeftView", FormationLeftView)

function MCFormationLeftView:_filterFormationPosOnEnter()
	local cfgTeam = self:_getTeamCfg()

	if cfgTeam then
		MCFormationLeftView.super._filterFormationPosOnEnter(self, cfgTeam.formCondition)
	end
end

function MCFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local cfgTeam = self:_getTeamCfg()

	if cfgTeam then
		return (FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, cfgTeam.formCondition, self:_getCurFormation(), isShowTip))
	end

	return true
end

function MCFormationLeftView:_getTeamCfg()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return nil
	end

	local chapterId = checknumber(params[1])
	local stageId = checknumber(params[2])
	local cfg = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

	if not cfg then
		return nil
	end

	local teamIds = cfg.teamIds

	return MaterialChallengeConfig.instance:getTeamCfg(teamIds)
end

function MCFormationLeftView:_getCurFormation()
	return MaterialChallengeModel.instance:_getCurFormation()
end

function MCFormationLeftView:_getPet(id)
	local mo = MCFormationLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function MCFormationLeftView:_beforeUseFormationMo()
	local formationMo = MaterialChallengeModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

function MCFormationLeftView:onFmoSetDown()
	local formationMo = MaterialChallengeModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

return MCFormationLeftView
