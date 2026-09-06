-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/mission/WaterDarkTowerFmtLeftView.lua

module("logic.extensions.waterdraktower.view.mission.WaterDarkTowerFmtLeftView", package.seeall)

local WaterDarkTowerFmtLeftView = class("WaterDarkTowerFmtLeftView", FormationLeftView)

function WaterDarkTowerFmtLeftView:onEnter()
	self._conditionId = self:getOpenParam()[2].formCondition

	local params = self:getOpenParam()

	self._actId = params[1]
	self._towerType = params[3]

	self:_getCurFormation():ResetPosition()
	WaterDarkTowerFmtLeftView.super.onEnter(self)
	GlobalDispatcher:addListener(WaterdraktowerController.PM_WaterDarkTowerGetFormRes, self._onGetFormRes, self)
	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetFormReq(self._actId, self._towerType)
end

function WaterDarkTowerFmtLeftView:onExit()
	WaterDarkTowerFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(WaterdraktowerController.PM_WaterDarkTowerGetFormRes, self._onGetFormRes, self)

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(nil)
end

function WaterDarkTowerFmtLeftView:_filterFormationPosOnEnter()
	if self._conditionId then
		WaterDarkTowerFmtLeftView.super._filterFormationPosOnEnter(self, self._conditionId)
	end
end

function WaterDarkTowerFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._conditionId then
		return (FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._conditionId, self:_getCurFormation(), isShowTip))
	end

	return true
end

function WaterDarkTowerFmtLeftView:_onGetFormRes(status, msg)
	if status ~= 0 then
		return
	end

	local simpleForm = msg.simpleForm

	local function func(id)
		return self:_getPet(id)
	end

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(func)

	local pos = simpleForm.pos

	self:_isShowNewActBonds(false)
	formationMo:SetData(simpleForm)
	self:_setPositionForce(pos, true)
	self:_isShowNewActBonds(true)
end

function WaterDarkTowerFmtLeftView:_saveCurrFmt()
	return
end

function WaterDarkTowerFmtLeftView:_initSelfFormation()
	return
end

function WaterDarkTowerFmtLeftView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WaterDarkTowerFmtLeftView:_getPet(petId)
	return WaterdraktowerModel.instance:getPetMo(petId)
end

return WaterDarkTowerFmtLeftView
