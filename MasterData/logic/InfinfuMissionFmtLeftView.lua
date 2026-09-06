-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuMissionFmtLeftView.lua

module("logic.extensions.infinitefuture.view.InfinfuMissionFmtLeftView", package.seeall)

local InfinfuMissionFmtLeftView = class("InfinfuMissionFmtLeftView", FormationLeftView)

function InfinfuMissionFmtLeftView:onEnter()
	self.petCopyMoCache = {}

	InfinfuMissionFmtLeftView.super.onEnter(self)
	self:_closeViretaFMo()
	self:_setActiveBtnFormation(false)
end

function InfinfuMissionFmtLeftView:onExit()
	self.petCopyMoCache = nil

	InfinfuMissionFmtLeftView.super.onExit(self)
end

function InfinfuMissionFmtLeftView:_filterFormationPosOnEnter()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])
	local form = InfinitefutureConfig.instance:getTeamCfg(creepsMasterId).formCondition

	InfinfuMissionFmtLeftView.super._filterFormationPosOnEnter(self, form)
end

function InfinfuMissionFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local params = self:getOpenParam()
	local mo = self:_getPet(petId, params[1])

	if not mo then
		return true
	end

	local creepsMasterId = checknumber(params[4])
	local form = InfinitefutureConfig.instance:getTeamCfg(creepsMasterId).formCondition
	local isMatch = FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, form, self:_getCurFormation(), isShowTip)
	local lock = InfinitefutureModel.instance:isBeLock(mo.raceId)

	return isMatch and not lock
end

function InfinfuMissionFmtLeftView:_getPet(petId, actId)
	return InfinitefutureModel.instance:getPetMo(petId, actId)
end

function InfinfuMissionFmtLeftView:_getCurFormation()
	local params = self:getOpenParam()

	return InfinitefutureModel.instance:GetCurFormation(params[1])
end

function InfinfuMissionFmtLeftView:_closeViretaFMo()
	local params = self:getOpenParam()
	local activityId = params[1]
	local isClose = InfinitefutureModel.instance.viretaActIds[3] ~= activityId

	goutil.setActive(self._Btn_Formation.gameObject, false)
	self:setBtnFormActive(isClose)
end

return InfinfuMissionFmtLeftView
