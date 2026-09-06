-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFormationselectView.lua

module("logic.extensions.pk.view.PkFormationselectView", package.seeall)

local PkFormationselectView = class("PkFormationselectView", RankRaceFmtSelectView)

function PkFormationselectView:ctor()
	PkFormationselectView.super.ctor(self)
end

function PkFormationselectView:buildUI()
	PkFormationselectView.super.buildUI(self)

	self._Icon_Go_BuffForm = goutil.findChild(self._btnFormation, "icon")
	self._Icon_BuffForm = goutil.findChild(self._btnFormation, "icon"):GetComponent("UIImageSpriteChange")
	self._Txt_Lv_BuffForm = goutil.findChildTextComponent(self._Icon_Go_BuffForm, "lv/txt")
	self._MarkLock_BuffForm = goutil.findChild(self._btnFormation, "markLock")
	self._MarkNotActive_BuffForm = goutil.findChild(self._btnFormation, "markNotActive")
	self._waitTip = self:getGo("waitTip")
	self._timeValue = goutil.findChildTextComponent(self.mainGO, "time/value")
end

function PkFormationselectView:bindEvents()
	PkFormationselectView.super.bindEvents(self)
end

function PkFormationselectView:unbindEvents()
	PkFormationselectView.super.unbindEvents(self)
end

function PkFormationselectView:destroyUI()
	PkFormationselectView.super.destroyUI(self)
end

function PkFormationselectView:onEnter()
	self._usePublicAttr = TraincampqiecuoModel.instance:getPkRoomCommonAttrState()
	self._publicPets = {}

	self.addGEvent(self, TrainCampQieCuoAgent.TC_SetDefenseFormRes, self._onSetDefense, self)

	self._matchType = self:getFirstParam()

	goutil.setActive(self._waitTip, false)
	goutil.setActive(self._btnDefault.gameObject, true)
	goutil.setActive(self._btnGotoFormation.gameObject, true)
	goutil.setActive(self._txtTips.gameObject, true)
	self:_refreshFormation()
	GlobalDispatcher:addListener(GlobalNotify.ChangeToAttack, self._changeToAttack, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPosChanged, self._refreshFormation, self)

	if self:getFirstParam() then
		self:_onClickUseDefault()
	end

	self._targetTickTime = TraincampqiecuoController.instance:getSetDefenseTargetTime()

	local time = self._targetTickTime - ServerTime.now()

	self._timeValue.text = string.format("%d秒", time)

	settimer(1, self._timer, self, true)
end

function PkFormationselectView:onEnterFinished()
	PkFormationselectView.super.onEnterFinished(self)
end

function PkFormationselectView:onExit()
	self:_removeSummonContractSkillEffect()
	GlobalDispatcher:removeListener(GlobalNotify.ChangeToAttack, self._changeToAttack, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPosChanged, self._refreshFormation, self)
	removetimer(self._timer, self)

	self._setDefenseForm = nil

	QieCuoAgent.instance:getDispatcher():removeAllListener(QieCuoAgent.PM_SetDefenseFormRes)
	QieCuoAgent.instance:getDispatcher():removeAllListener(QieCuoAgent.PM_LeaveGameRes)
	UIStateManager.instance:closeAllModalViews()
end

function PkFormationselectView:onExitFinished()
	PkFormationselectView.super.onExitFinished(self)
end

function PkFormationselectView:_refreshFormation()
	self:_setHeroSkill(self:_getHeroSkillId())
	self:_setPowerAndSpeed()
	self:_refeshSeats()
	self:_refreshBuffForm()

	if self._autoFormation then
		self:_onClickUseDefault()
	end

	self:_setSummonContractSkillEffect()
end

function PkFormationselectView:_onClickUseDefault()
	local formMo = self:_getCurFormation()

	if formMo:isEmpty() and not self._autoFormation then
		TipsFacade.instance:openTipWindow(lang("tip"), "当前默认阵型为空，将进行一键布阵", function()
			PkFastFormation.instance:setFormation()

			self._autoFormation = true
		end)
	else
		local form = self:_getCurFormation():createFormPb()

		TrainCampQieCuoAgent.instance:sendPM_TC_SetDefenseFormReq(form)
	end
end

function PkFormationselectView:_onClickGotoFormation()
	UIStateManager.instance:push(ViewName.PkFormationView)
	self:close()
end

function PkFormationselectView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("tip"), "是否确认现在退出,退出将会视为战斗失败", function()
		TrainCampQieCuoAgent.instance:sendPM_TC_LeaveGameReq()
		self:close()
	end)
end

function PkFormationselectView:_getPowerAndSpeed()
	local formation = self:_getCurFormation()
	local fid = 0
	local flvl = 0
	local info = formation:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
	end

	local power, speed = 0, 0
	local team = {}

	info = FormationNewModel.instance:getFormStrengthInfo(fid)

	if info then
		flvl = info.formStrengthLv
	end

	for _, v in ipairs(formation:GetPositions()) do
		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				local fightingPowerMo = pet:toFightingPowerPetMo()

				table.insert(team, fightingPowerMo)

				if pet.summonMasterId <= 0 then
					speed = speed + pet._speed
				end
			end
		end
	end

	local heroSkillId = self:_getHeroSkillId()
	local eleMap = formation:getCurElementRelationMap()
	local cutePetRaceId, cutePetQuality = formation:getCutePetInfo()
	local masterId = formation:GetSummonMasterPetId()
	local summonId = formation:GetSummonPetId()

	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId), speed
end

function PkFormationselectView:_timer()
	local leftTime = self._targetTickTime - ServerTime.now()

	if leftTime <= 0 then
		removetimer(self._timer, self)

		local form = self:_getCurFormation():createFormPb()

		TrainCampQieCuoAgent.instance:sendPM_TC_SetDefenseFormReq(form)
	else
		self._timeValue.text = string.format("%d秒", leftTime)
	end
end

function PkFormationselectView:_getItemSeatCls()
	return ItemSeat
end

function PkFormationselectView:_changeToAttack()
	UIStateManager.instance:push(ViewName.PkmissionView)
	self:close()
end

function PkFormationselectView:_getPetsHeroSkills()
	local pet_poisition = self:_getCurFormation():GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, fmtMo:getCurElementRelationMap(), masterId, summonId))
end

function PkFormationselectView:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function PkFormationselectView:_onSetDefense()
	removetimer(self._timer, self)

	self._setDefenseForm = true
	self._timeValue.text = "等待中"

	goutil.setActive(self._waitTip, true)
	goutil.setActive(self._btnDefault.gameObject, false)
	goutil.setActive(self._btnGotoFormation.gameObject, false)
	goutil.setActive(self._txtTips.gameObject, false)
end

function PkFormationselectView:_getCurFormation()
	return TraincampqiecuoModel.instance:getMyFormation()
end

function PkFormationselectView:_getPet(petId)
	if self._usePublicAttr then
		return self:_getPublickPet(petId)
	else
		return BagPetsController.instance:getPet(petId)
	end
end

function PkFormationselectView:_getPublickPet(petId)
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

function PkFormationselectView:_setFormLv(formStrengthId, formStrengthLv)
	if self._usePublicAttr then
		formStrengthLv = BattleConfig.instance:getFormStrengthMaxLv(formStrengthId)
	end

	self._Txt_Lv_BuffForm.text = "Lv." .. formStrengthLv
end

function PkFormationselectView:_refreshBuffForm()
	if not self._usePublicAttr then
		self:_refreshBuffFormBySelf()

		return
	end

	self:_refreshBuffFormByPublic()
end

function PkFormationselectView:_refreshBuffFormBySelf()
	local info = self:_getCurFormation():GetFormStrengthInfo()

	info = FormationNewModel.instance:getFormStrengthInfo((info and info.formStrengthId and info.formStrengthId > 0 or nil) and info.formStrengthId)

	self:_onUpdateBuffFormById(info)
end

function PkFormationselectView:_onUpdateBuffFormById(info)
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	goutil.setActive(self._MarkLock_BuffForm, not isOpen)
	goutil.setActive(self._Icon_Go_BuffForm, false)

	local formId

	self._Txt_Lv_BuffForm.text = ""
	self._txtFormation.text = "阵法"

	if isOpen then
		local cfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(info and info.formStrengthId)

		if cfg then
			goutil.setActive(self._Icon_Go_BuffForm, true)
			self._Icon_BuffForm:SetState(cfg.formStrengthId - 1)

			self._Txt_Lv_BuffForm.text = "Lv." .. info.formStrengthLv
			self._txtFormation.text = cfg.name

			self:_getCurFormation():SetFormStrengthInfo(info)
			self:_setPowerAndSpeed()
		end
	else
		self:_getCurFormation():SetFormStrengthInfo(nil)
	end
end

function PkFormationselectView:_refreshBuffFormByPublic()
	local positions = self:_getCurFormation():GetPositions()
	local posDataList = {}
	local compA = 0

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo.summonMasterId <= 0 then
				table.insert(posDataList, i)

				compA = compA + math.pow(2, i)
			end
		end
	end

	local fsMap = {}

	for i = 1, 8 do
		local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

		fsMap[i] = {
			formStrengthId = i,
			formStrengthLv = _maxlv
		}
	end

	for k, v in pairs(fsMap or {}) do
		if v.formStrengthLv > 0 then
			local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(v.formStrengthId)

			if posCfg then
				local posList = posCfg.posList

				if posList and #posList == #posDataList then
					local compB = 0

					for i = 1, #posList do
						local pp_b = posList[i]

						compB = compB + math.pow(2, pp_b)
					end

					if compA == compB then
						self:_onUpdateBuffFormById(v)

						return
					end
				end
			end
		end
	end

	self:_onUpdateBuffFormById(nil)
end

function PkFormationselectView:_getPowerAndSpeed(isUseCutePet)
	local team, formation, speed = self:getTeamAndFormation()
	local fid, flvl = 0, 0
	local fmtMo = self:_getCurFormation()
	local info = fmtMo:GetFormStrengthInfo()

	if info then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	local heroSkill = fmtMo:GetHeroSkillId()
	local cutePetRaceId, cutePetQuality = 0, 0

	if isUseCutePet == nil or isUseCutePet == true then
		cutePetRaceId, cutePetQuality = fmtMo:getCutePetInfo()
	end

	local masterId = fmtMo:GetSummonMasterPetId()
	local summonId = fmtMo:GetSummonPetId()

	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkill, fid, flvl, fmtMo:getCurElementRelationMap(), cutePetRaceId, cutePetQuality, masterId, summonId), speed
end

function PkFormationselectView:getTeamAndFormation()
	local curForm = self:_getCurFormation()
	local team = {}
	local formations = {}
	local speed = 0

	for idx = 1, 9 do
		local v = checknumber(curForm:GetPosition(idx))

		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				table.insert(team, pet)

				formations[idx] = pet

				if not pet:isSummonedPet() then
					speed = speed + pet._speed
				end
			end
		end
	end

	return team, formations, speed
end

return PkFormationselectView
