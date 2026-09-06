-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xj2MissionView.lua

module("logic.extensions.xingjiang.view.Xj2MissionView", package.seeall)

local Xj2MissionView = class("Xj2MissionView", MissionView)

function Xj2MissionView:ctor()
	Xj2MissionView.super.ctor(self)
end

function Xj2MissionView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._creepsMasterId = params[2]
	self._curformCond = XingJiangConfig.instance:getTeam2Cfg(self._creepsMasterId).formCondition

	XingJiangModel.instance:onResetInfo()
	self:onEnterInherit()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return self:_GetAllPetList()
	end)
end

function Xj2MissionView:procMid()
	local titleStr = "精灵挑战"
	local levelStr = 1
	local ruleDesc = "击败所有对方精灵"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_initFormCondition(self._curformCond)
end

function Xj2MissionView:_enterBattle()
	UIJumper.instance:saveCurStack(self._viewPresentor.viewName)
	XingJiangController.instance:sendChallenge2Req(self._activityId)
end

function Xj2MissionView:_isShowBtnEvaluate()
	return false
end

function Xj2MissionView:_isFormationValidatorMatchOnStart()
	if self._curformCond then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._curformCond, self:_getCurFormation()))
	end

	return true
end

function Xj2MissionView:_onFormationChangeFinish()
	Xj2MissionView.super._onFormationChangeFinish(self)

	if self._curformCond then
		self:_setValidatorDesc(self._curformCond)
	end
end

function Xj2MissionView:_GetAllPetList()
	return XingJiangModel.instance:getAllPetList()
end

return Xj2MissionView
