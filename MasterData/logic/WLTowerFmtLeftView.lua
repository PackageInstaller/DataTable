-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/formation/WLTowerFmtLeftView.lua

module("logic.extensions.waterdraktower.view.formation.WLTowerFmtLeftView", package.seeall)

local WLTowerFmtLeftView = class("WLTowerFmtLeftView", FormationLeftView)

function WLTowerFmtLeftView:onEnter()
	self._params = self:getFirstParam()

	if self._params == nil or self._params.actId == nil then
		return
	end

	self:_getCurFormation():ResetPosition()
	WLTowerFmtLeftView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerGetForm, self._onGetFormRes, self)
	WaterdraktowerController.instance:csGetWaterDarkTowerGetFormReq(self._params.actId, self._params.towerType)
end

function WLTowerFmtLeftView:onExit()
	WLTowerFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerGetForm, self._onGetFormRes, self)

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(nil)
end

function WLTowerFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if petId == nil or petId <= 0 then
		return true
	end

	if self._params and self._params.formCondition > 0 then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._params.formCondition, self:_getCurFormation(), isShowTip)
	end

	return true
end

function WLTowerFmtLeftView:dealWithLimitPetPos()
	self:_filterFormationPosOnEnter()
	WLTowerFmtLeftView.super.dealWithLimitPetPos(self)
end

function WLTowerFmtLeftView:_filterFormationPosOnEnter()
	if self._params and self._params.formCondition > 0 then
		WLTowerFmtLeftView.super._filterFormationPosOnEnter(self, self._params.formCondition)
	end
end

function WLTowerFmtLeftView:_onGetFormRes(simpleForm)
	if simpleForm == nil then
		return
	end

	local function func(id)
		return self:_getPet(id)
	end

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(func)

	local pos = simpleForm.pos

	self:_isShowNewActBonds(false)

	if simpleForm.extParams and simpleForm.extParams.heroSkillId then
		self:_getCurFormation():SetHeroSkillId(simpleForm.extParams.heroSkillId)
	end

	self:_setPositionForce(pos, true)
	self:_isShowNewActBonds(true)
end

function WLTowerFmtLeftView:_saveCurrFmt()
	return
end

function WLTowerFmtLeftView:_initSelfFormation()
	return
end

function WLTowerFmtLeftView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WLTowerFmtLeftView:_getPet(petId)
	return WaterdraktowerModel.instance:getPetMo(petId)
end

return WLTowerFmtLeftView
