-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/formation/SkslMissionView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.formation.SkslMissionView", package.seeall)

local SkslMissionView = class("SkslMissionView", MissionView)

function SkslMissionView:ctor()
	SkslMissionView.super.ctor(self)
end

function SkslMissionView:onEnter()
	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._activityId = params[1]
	self._creepsMasterId = params[2]
	self._curformCond = ShikongshenglongConfig.instance:getTeamCfg(self._creepsMasterId).formCondition

	self:onEnterInherit()
	self:procMid()

	if self._activityId == 110002 then
		self:showTabAt(self._extension, ViewName.ZxlpresentwishView)
	else
		self:showTabAt("")
	end
end

function SkslMissionView:procMid()
	local titleStr = ShikongshenglongConfig.instance:getTeamCfg(self._creepsMasterId).name
	local levelStr = ShikongshenglongModel.instance.curStageId
	local ruleDesc = "击败所有对方精灵"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_initFormCondition(self._curformCond)
end

function SkslMissionView:_enterBattle()
	printInfo("test 活动id是", self._activityId)

	if self._activityId == ShikongshenglongController.SkslActivityId then
		UIJumper.instance:pushOneStack(ViewName.SkslmainView)
		UIJumper.instance:pushOneStack(ViewName.SksldifficultyView)
	elseif self._activityId == ShikongshenglongController.SiYuanActivityId then
		UIJumper.instance:pushOneStack(ViewName.SiYuanmainView)
		UIJumper.instance:pushOneStack(ViewName.SiYuandifficultyView)
	elseif self._activityId == ShikongshenglongController.SYWDLYActivityId then
		UIJumper.instance:pushOneStack(ViewName.Skslmaincopy1View)
		UIJumper.instance:pushOneStack(ViewName.Sksldifficultycopy1View)
	elseif self._activityId == ShikongshenglongController.ZxlActivityId then
		UIJumper.instance:pushOneStack(ViewName.ZxlmainView)
		UIJumper.instance:pushOneStack(ViewName.ZxldifficultyView)
	elseif self._activityId == ShikongshenglongController.SLYJDActivityId then
		UIJumper.instance:pushOneStack(ViewName.SmallLuyngardeMainView)
		UIJumper.instance:pushOneStack(ViewName.SmallluyngardedifficultyView)
	else
		UIJumper.instance:saveCurStack(self._viewPresentor.viewName)
	end

	ShikongshenglongController.instance:sendToFight(self._activityId)
end

function SkslMissionView:_isShowBtnEvaluate()
	return false
end

function SkslMissionView:_isFormationValidatorMatchOnStart()
	if self._curformCond then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._curformCond, self:_getCurFormation()))
	end

	return true
end

function SkslMissionView:_onFormationChangeFinish()
	SkslMissionView.super._onFormationChangeFinish(self)

	if self._curformCond then
		self:_setValidatorDesc(self._curformCond)
	end
end

return SkslMissionView
