-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/mission/LongnvFmtLeftView.lua

module("logic.extensions.mangtower.view.LongnvFmtLeftView", package.seeall)

local LongnvFmtLeftView = class("LongnvFmtLeftView", FormationLeftView)

function LongnvFmtLeftView:onEnter()
	self._formCondition = self:_getMonsterCo().formCondition

	LongnvFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
end

function LongnvFmtLeftView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type
		local stageId = params.stageId
		local planId = LongnvModel.instance:getPlanId()
		local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
		local monsterPlan = checknumber(cfg.monsterPlan)
		local monsterList = LongnvConfig.instance:getMonsterListCfg(type, monsterPlan) or {}

		return monsterList[stageId]
	end

	return {}
end

function LongnvFmtLeftView:onExit()
	LongnvFmtLeftView.super.onExit(self)
end

function LongnvFmtLeftView:_filterFormationPosOnEnter()
	LongnvFmtLeftView.super._filterFormationPosOnEnter(self, self._formCondition)
end

function LongnvFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:_getCurFormation(), isShowTip)
end

return LongnvFmtLeftView
