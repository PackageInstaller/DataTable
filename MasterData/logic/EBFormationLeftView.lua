-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/EBFormationLeftView.lua

module("logic.extensions.formation.view.EBFormationLeftView", package.seeall)

local EBFormationLeftView = class("EBFormationLeftView", FormationLeftView)

function EBFormationLeftView:onEnter()
	EBFormationLeftView.super.onEnter(self)
	goutil.setActive(self._Btn_Formation.gameObject, false)
	goutil.setActive(self._Btn_BuffForm.gameObject, false)
	self:_isSkipFirstHeroSkillEffect(true)
	GlobalDispatcher:addListener(GlobalNotify.GetInfiniteFightFormRes, self._onGetInfiniteFightFormRes, self)
end

function EBFormationLeftView:onExit()
	EBFormationLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GetInfiniteFightFormRes, self._onGetInfiniteFightFormRes, self)
end

function EBFormationLeftView:_setBtnFormationActive()
	return false
end

function EBFormationLeftView:_saveCurrFmt()
	return
end

function EBFormationLeftView:_initSelfFormation()
	return
end

function EBFormationLeftView:_onGetInfiniteFightFormRes()
	local simpleForm = EndlessBattleModel.instance:getFormation()

	self:_beforeUseFormationMo()

	local poses = self:_getCurFormation():GetPositions()

	self:_isShowNewActBonds(false)

	if simpleForm.extParams and simpleForm.extParams.heroSkillId then
		self:_SetHeroSkill(simpleForm.extParams.heroSkillId)
	end

	self:_updateDomainSkill()
	self:_setPositionForce(poses, true)
	self:_isShowNewActBonds(true)
end

function EBFormationLeftView:_getCurFormation()
	return EndlessBattleModel.instance:_getCurFormation()
end

function EBFormationLeftView:_getPet(id)
	local mo = EBFormationLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function EBFormationLeftView:_beforeUseFormationMo()
	local formationMo = EndlessBattleModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_ENDLESS, formationMo)
end

function EBFormationLeftView:onFmoSetDown()
	local formationMo = EndlessBattleModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_ENDLESS, formationMo)
end

return EBFormationLeftView
