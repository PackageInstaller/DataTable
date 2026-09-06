-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WarriorFormationLeftView.lua

module("logic.extensions.formation.view.WarriorFormationLeftView", package.seeall)

local WarriorFormationLeftView = class("WarriorFormationLeftView", FormationLeftView)

function WarriorFormationLeftView:ctor()
	WarriorFormationLeftView.super.ctor(self)
end

function WarriorFormationLeftView:onEnter()
	self.towerId = WTowerModel.instance:getTowerId()

	WarriorFormationLeftView.super.onEnter(self)
	self:_setActiveBtnFormationUse(true)

	if self.towerId ~= WTowerModel.TowerType.Warrior then
		GameUtil.SetActive(self._Btn_Formation, false)

		self._Btn_BuffForm.transform.localPosition = self._Btn_Formation.transform.localPosition

		self:_setActiveBtnFormationUse(false)
	end
end

function WarriorFormationLeftView:_getCurFormId()
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		return 0
	else
		return WarriorFormationLeftView.super._getCurFormId(self)
	end
end

function WarriorFormationLeftView:_getPetsHeroSkills()
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		return WTowerModel.instance:getFormPetsHeroSkills()
	else
		return WarriorFormationLeftView.super._getPetsHeroSkills(self)
	end
end

function WarriorFormationLeftView:_getHeroSkillId()
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		return WTowerModel.instance:getHeroSkillId()
	else
		return WarriorFormationLeftView.super._getHeroSkillId(self)
	end
end

function WarriorFormationLeftView:_changeHeroSkillId(id)
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		WTowerModel.instance:changeSkillId(id)
	else
		WarriorFormationLeftView.super._changeHeroSkillId(self, id)
	end
end

function WarriorFormationLeftView:_changeTeamId(id)
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		if id == self:_getCurrTeamId() then
			return
		end

		local team = FormationNewModel.instance:GetTeam(id)
		local formation = team:GetCurFormation()
		local positions = formation:GetPositions()
		local currFmt = self:_getCurFormation()

		for i = 1, #positions do
			currFmt:SetPosition(i, positions[i])
		end

		WTowerModel.instance:setTeamId(id)
		GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
	else
		WarriorFormationLeftView.super._changeTeamId(self, id)
	end
end

function WarriorFormationLeftView:_getCurrTeamId()
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		return WTowerModel.instance:getTeamId()
	else
		return WarriorFormationLeftView.super._getCurrTeamId(self)
	end
end

function WarriorFormationLeftView:_saveCurrFmt()
	if self.towerId ~= WTowerModel.TowerType.Warrior then
		WTowerModel.instance:saveCurrFormation()
	else
		WarriorFormationLeftView.super._saveCurrFmt(self)
	end
end

function WarriorFormationLeftView:_getCurFormation()
	return WTowerModel.instance:_getCurFormation()
end

function WarriorFormationLeftView:_beforeUseFormationMo()
	if WTowerModel.TowerType.Warrior == WTowerModel.instance:getTowerId() then
		local formationMo = WTowerModel.instance:getOriginalCurFormation()

		PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
	end
end

function WarriorFormationLeftView:onFmoSetDown()
	if WTowerModel.TowerType.Warrior == WTowerModel.instance:getTowerId() then
		local formationMo = WTowerModel.instance:getOriginalCurFormation()

		PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
	end
end

function WarriorFormationLeftView:_getPet(id)
	local mo = WarriorFormationLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function WarriorFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local mo = self:_getPet(petId)

	if mo then
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
		local firstEle = PetSkinConfig.instance:getFisrtEleAttrIdx(mo.curFaceId)
		local towerId = WTowerModel.instance:getTowerId()

		if WTowerModel.TowerType.Warrior == towerId then
			-- block empty
		else
			return firstEle == towerId - 1
		end
	end

	return true
end

return WarriorFormationLeftView
