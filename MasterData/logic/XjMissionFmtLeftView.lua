-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjMissionFmtLeftView.lua

module("logic.extensions.xingjiang.view.XjMissionFmtLeftView", package.seeall)

local XjMissionFmtLeftView = class("XjMissionFmtLeftView", FormationLeftView)

function XjMissionFmtLeftView:onEnter()
	XjMissionFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:setBtnFormActive(false)
end

function XjMissionFmtLeftView:_filterFormationPosOnEnter()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])
	local form = XingJiangConfig.instance:getTeamCfg(creepsMasterId).formCondition

	XjMissionFmtLeftView.super._filterFormationPosOnEnter(self, form)
end

function XjMissionFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local mo = self:_getPet(petId)

	if not mo then
		return true
	end

	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])
	local form = XingJiangConfig.instance:getTeamCfg(creepsMasterId).formCondition

	return (FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, form, self:_getCurFormation(), isShowTip))
end

function XjMissionFmtLeftView:_getCurFormation()
	return (XingJiangModel.instance:GetCurFormation())
end

function XjMissionFmtLeftView:resetNum()
	return 9
end

return XjMissionFmtLeftView
