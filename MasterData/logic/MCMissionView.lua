-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MCMissionView.lua

module("logic.extensions.materialchallenge.view.MCMissionView", package.seeall)

local MCMissionView = class("MCMissionView", MissionView)

function MCMissionView:onEnter()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	GlobalDispatcher:addListener(MaterialChallengeAgent.MCLG_ChallengeRes, self._onChallengeRes, self)

	self._teamCfg = nil
	self._chapterId = params[1]
	self._stageId = params[2]

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("mc_%s_%s", self._chapterId, self._stageId))
	self:onEnterInherit()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return MaterialChallengeModel.instance:getAllShowPetList()
	end)
end

function MCMissionView:onEnterFinished()
	MCMissionView.super.onEnterFinished(self)

	local isShow = not GameUtil.getUserDayData(MissionConst.MissionMaterial .. self._chapterId)

	if isShow then
		self:_onClickRule()
	end
end

function MCMissionView:onExit()
	MCMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(MaterialChallengeAgent.MCLG_ChallengeRes, self._onChallengeRes, self)
end

function MCMissionView:procMid()
	local cfg = MaterialChallengeConfig.instance:getStageById(self._chapterId, self._stageId)

	if not cfg then
		return
	end

	local teamIds = cfg.teamIds
	local cfgTeam = MaterialChallengeConfig.instance:getTeamCfg(teamIds)
	local titleStr = cfg.stageName
	local levelStr = ""

	if cfg.passDesc then
		if not cfg.passDesc then
			local ruleDesc = ""

			self:_setDescStr(titleStr, levelStr, ruleDesc)
			self:_setRedPoint(cfgTeam.redPoint)
			self:_initFormCondition(cfgTeam.formCondition)
		end
	end
end

function MCMissionView:_enterBattle()
	local chapterId = self._chapterId
	local stageId = self._stageId
	local params = {}
	local cfg = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

	if not cfg then
		return
	end

	local teamCfg = MaterialChallengeConfig.instance:getTeamCfg(cfg.teamIds)

	if not teamCfg then
		return
	end

	params.chapterId = chapterId
	params.progress = MaterialChallengeModel.instance:curDailyTaskProgress(chapterId)
	params.rewardScore = cfg.rewardScore
	params.winId = teamCfg.winId
	params.oldStageEvaluate = MaterialChallengeModel.instance:getStageEvaluate(chapterId, stageId)

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.ResCopy, params)
	MaterialChallengeController.instance:sendMCLG_ChallengeReq(chapterId, stageId)
	MaterialChallengeController.instance:pushOneStackView(chapterId, stageId)
end

function MCMissionView:_onChallengeRes(status, msg)
	self:_onMissionBattleResBack(status)
end

function MCMissionView:_openPassRuleView()
	UIStateManager.instance:open(ViewName.SpecialPassRuleView, self._chapterId)
end

function MCMissionView:_getTeamCfg()
	if self._teamCfg then
		return self._teamCfg
	end

	local cfg = MaterialChallengeConfig.instance:getStageById(self._chapterId, self._stageId)

	if not cfg then
		return nil
	end

	local teamIds = cfg.teamIds

	self._teamCfg = MaterialChallengeConfig.instance:getTeamCfg(teamIds)

	return self._teamCfg
end

function MCMissionView:_setBtnOneKeyActive()
	local cfgTeam = self:_getTeamCfg()

	if cfgTeam and cfgTeam.formCondition > 0 then
		return false
	else
		return true
	end
end

function MCMissionView:_isFormationValidatorMatchOnStart()
	local cfgTeam = self:_getTeamCfg()

	if cfgTeam then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(cfgTeam.formCondition, self:_getCurFormation()))
	end

	return true
end

function MCMissionView:_onFormationChangeFinish()
	MCMissionView.super._onFormationChangeFinish(self)

	local cfgTeam = self:_getTeamCfg()

	if cfgTeam then
		self:_setValidatorDesc(cfgTeam.formCondition)
	end
end

function MCMissionView:_saveFormationEx()
	PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

	return MCMissionView.super._saveFormationEx(self)
end

function MCMissionView:_getCurFormation()
	return MaterialChallengeModel.instance:_getCurFormation()
end

return MCMissionView
