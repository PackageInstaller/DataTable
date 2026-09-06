-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainCampQieCuoPVEMissionLeftView.lua

module("logic.extensions.traincampqiecuo.view.TrainCampQieCuoPVEMissionLeftView", package.seeall)

local TrainCampQieCuoPVEMissionLeftView = class("TrainCampQieCuoPVEMissionLeftView", FormationLeftView)

function TrainCampQieCuoPVEMissionLeftView:onEnter()
	self._usePublicAttr = false
	self._publicPets = {}

	TrainCampQieCuoPVEMissionLeftView.super.onEnter(self)
end

function TrainCampQieCuoPVEMissionLeftView:_OnClickBtnBuffForm()
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

function TrainCampQieCuoPVEMissionLeftView:_getPet(petId)
	if self._usePublicAttr then
		return self:_getPublickPet(petId)
	else
		return BagPetsController.instance:getPet(petId)
	end
end

function TrainCampQieCuoPVEMissionLeftView:_getPublickPet(petId)
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

function TrainCampQieCuoPVEMissionLeftView:_onSelectBuffForm(formId, formLv)
	if self._usePublicAttr then
		formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
	end

	TrainCampQieCuoPVEMissionLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function TrainCampQieCuoPVEMissionLeftView:_OnClickBtnBuffForm()
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

function TrainCampQieCuoPVEMissionLeftView:_getPowerAndSpeed(isUseCutePet)
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

function TrainCampQieCuoPVEMissionLeftView:getCurAllFormStrengthInfo()
	if not self._usePublicAttr then
		return TrainCampQieCuoPVEMissionLeftView.super.getCurAllFormStrengthInfo(self)
	end

	local data = FightingPowerPetMo.getFormStrengthMax()

	return data.formStrengths
end

function TrainCampQieCuoPVEMissionLeftView:_getCurFormation()
	return TraincampqiecuoModel.instance:getMyPVEFormation()
end

function TrainCampQieCuoPVEMissionLeftView:_onBagBeginDrag(bagPetMo)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onBagBeginDrag(self, bagPetMo)
end

function TrainCampQieCuoPVEMissionLeftView:_onBagEndDrag()
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onBagEndDrag(self)
end

function TrainCampQieCuoPVEMissionLeftView:_OnDropSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnDropSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_OnBeginDragSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnBeginDragSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_OnDragSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnDragSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onEnterSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onEnterSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onExitSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onExitSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_OnDropBg(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnDropBg(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onFormationBeginDragSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onFormationBeginDragSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onFormationEndDragSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onFormationEndDragSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onFormationEnterSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onFormationEnterSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_onFormationExitSeat(go, eventData)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onFormationExitSeat(self, go, eventData)
end

function TrainCampQieCuoPVEMissionLeftView:_OnSeatValueChanged(pos, petId)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnSeatValueChanged(self, pos, petId)
end

function TrainCampQieCuoPVEMissionLeftView:_onFormationSelectPsychicedSkill(id)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._onFormationSelectPsychicedSkill(self, id)
end

function TrainCampQieCuoPVEMissionLeftView:_setElementSkill()
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._setElementSkill(self)
end

function TrainCampQieCuoPVEMissionLeftView:_OnHeroSkillChanged(id)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	TrainCampQieCuoPVEMissionLeftView.super._OnHeroSkillChanged(self, id)
end

return TrainCampQieCuoPVEMissionLeftView
