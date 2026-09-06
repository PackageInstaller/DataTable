-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkMissionLeftView.lua

module("logic.extensions.pk.view.PkMissionLeftView", package.seeall)

local PkMissionLeftView = class("PkMissionLeftView", FormationLeftView)

function PkMissionLeftView:onEnter()
	self._usePublicAttr = TraincampqiecuoModel.instance:getPkRoomCommonAttrState()
	self._publicPets = {}

	PkMissionLeftView.super.onEnter(self)
end

function PkMissionLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false)
end

function PkMissionLeftView:_getPet(petId)
	if self._usePublicAttr then
		return self:_getPublickPet(petId)
	else
		return BagPetsController.instance:getPet(petId)
	end
end

function PkMissionLeftView:_getPublickPet(petId)
	if petId <= 0 then
		return
	end

	local petMo = self._publicPets[petId]

	if not petMo then
		local mo = BagPetsController.instance:getPet(petId)

		petMo = mo:usePublicStrengths()
		self._publicPets[petId] = petMo
	end

	return petMo
end

function PkMissionLeftView:_onSelectBuffForm(formId, formLv)
	if self._usePublicAttr then
		formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
	end

	PkMissionLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function PkMissionLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, true, self._usePublicAttr)
end

function PkMissionLeftView:_getPowerAndSpeed(isUseCutePet)
	local team, formation, speed = self:getTeamAndFormation()
	local fid, flvl = self:GetFormStrengthIdAndLv()
	local heroSkill = self:_getHeroSkillId()
	local cutePetRaceId, cutePetQuality = 0, 0

	if isUseCutePet == nil or isUseCutePet == true then
		cutePetRaceId, cutePetQuality = self:_getCutePetInfo()
	end

	local fmtMo = self:_getCurFormation()
	local masterId = fmtMo:GetSummonMasterPetId()
	local summonId = fmtMo:GetSummonPetId()

	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkill, fid, (fid and fid > 0 and self._usePublicAttr or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid), fmtMo:getCurElementRelationMap(), cutePetRaceId, cutePetQuality, masterId, summonId), speed
end

function PkMissionLeftView:getCurAllFormStrengthInfo()
	if not self._usePublicAttr then
		return PkMissionLeftView.super.getCurAllFormStrengthInfo(self)
	end

	local data = FightingPowerPetMo.getFormStrengthMax()

	return data.formStrengths
end

return PkMissionLeftView
