-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/model/SeniorAttackFmtMo.lua

module("logic.extensions.seniorarena.model.SeniorAttackFmtMo", package.seeall)

local SeniorAttackFmtMo = class("SeniorAttackFmtMo", BaseCustomFmtMo)

function SeniorAttackFmtMo:onInit()
	SeniorAttackFmtMo.super.onInit(self)

	self.useMaxFightPower = false
	self.isShowTab = true
	self.curTabIndex = 1
	self.topTitleStr = "高级竞技场"
	self.ruleDescStr = "击败对方全体精灵"
end

function SeniorAttackFmtMo:initFormationMo()
	self._changeIndexList = {
		1,
		2,
		3
	}
	self.forMationMap = {}

	local forms = SeniorArenaModel.instance:getMyAttackFormMos()

	for i, v in ipairs(self._changeIndexList) do
		local fmo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
		local playerFormMo = forms[i]

		if playerFormMo then
			fmo:SetData(playerFormMo._curForm)

			local masterId = 0
			local summonId = 0

			for i, v in pairs(fmo:GetPositions() or {}) do
				local petMo = fmo:_getPet(v, true)

				if petMo and checknumber(petMo.summonMasterId) > 0 then
					summonId = petMo.petId
					masterId = checknumber(petMo.summonMasterId)
				end
			end

			if checknumber(fmo.summonMasterPetId) <= 0 and checknumber(fmo.summonedPetId) <= 0 and masterId > 0 and summonId > 0 then
				fmo.summonMasterPetId = masterId
				fmo.summonedPetId = summonId
			end
		end

		self.forMationMap[i] = fmo
	end
end

function SeniorAttackFmtMo:getChangeIndexList()
	return self._changeIndexList
end

function SeniorAttackFmtMo:updateChangeIndexList(list)
	self._changeIndexList = list
end

function SeniorAttackFmtMo:getCurFormation()
	local idx = self._changeIndexList[self.curTabIndex]

	return self:_getRealFormation(idx)
end

function SeniorAttackFmtMo:onFmoSetDown()
	local fmo = self:getCurFormation()
	local posList = fmo:GetPositions()

	for i, v in ipairs(self._changeIndexList) do
		if i ~= self.curTabIndex then
			local tarMo = self:_getRealFormation(v)
			local posList = tarMo:GetPositions()

			for pos, petId in pairs(posList) do
				if fmo:HasPet(petId) then
					tarMo:SetPosition(pos, 0, true)
				end
			end
		end
	end
end

function SeniorAttackFmtMo:_getRealFormation(idx)
	self.formationMo = self.forMationMap[idx]

	return self.formationMo
end

function SeniorAttackFmtMo:checkPetIsForbit(petMo, baseCheck)
	local fmo = self:getCurFormation()
	local posList = fmo:GetPositions()

	for i, v in ipairs(self._changeIndexList) do
		if i ~= self.curTabIndex then
			local tarMo = self:_getRealFormation(v)

			if tarMo:HasPet(petMo.petId) then
				return true
			end
		end
	end

	return false
end

function SeniorAttackFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) then
		FloatWordMgr.instance:show("其他阵型中已使用该精灵")
	end
end

function SeniorAttackFmtMo:sendSaveMsg()
	if not SeniorArenaController.instance:getIsOpen(true) then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

		return
	end

	local forms = {}

	for i, v in ipairs(self._changeIndexList) do
		local form = Arena3v3Extension_pb.Arena3v3SetFormNO()

		form.formId = i

		local fmtMo = self:_getRealFormation(v)

		FormationFacade.createFormPb(form.simpleForm, fmtMo)
		table.insert(forms, form)
	end

	SeniorArenaController.instance._setForms = forms
	SeniorArenaController.instance._isAttack = true

	Arena3v3Agent.instance:sendArena3v3SetMyAttackFormationReq(forms, SeniorArenaController.instance._onSetMyFormRes, SeniorArenaController.instance, SeniorArenaController.instance._errorCall)
end

function SeniorAttackFmtMo:sendFightMsg()
	for i, v in ipairs(self._changeIndexList) do
		local tarMo = self:_getRealFormation(v)

		if tarMo:isEmpty() then
			TipsFacade.instance:openTipWindow("提示", langPara("[%s]阵是空阵不能进行挑战，请返回布阵", i), function()
				self.curTabIndex = i

				GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
			end, "去布阵")
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	SeniorArenaController.instance._handler = SeniorArenaController.instance.reqChallenge
	SeniorArenaController.instance._handlerTarget = SeniorArenaController.instance

	self:sendSaveMsg()
end

function SeniorAttackFmtMo:_getMonsterCo()
	local temp = {}

	temp.heroSkillId = 0
	temp.psychicSkillId = 0
	temp.cutePetRaceId = 0
	temp.cutePetQuality = 0

	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()

	if playerFormMo then
		temp.heroSkillId = playerFormMo:getHeroSkillId()
		temp.psychicSkillId = playerFormMo:getPsychicedSkillId()

		local cutePetRaceId, cutePetQuality = playerFormMo:getCutePetInfo()

		temp.cutePetRaceId = cutePetRaceId
		temp.cutePetQuality = cutePetQuality
	end

	return temp
end

function SeniorAttackFmtMo:getExtParams(formations)
	local formMos = SeniorArenaController.instance:getCurOpponentFormMos() or {}
	local playerFormMo = formMos[self.curTabIndex]

	if playerFormMo then
		return (playerFormMo:getExtParams())
	end
end

function SeniorAttackFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}
	local formMos = SeniorArenaController.instance:getCurOpponentFormMos() or {}
	local playerFormMo = formMos[self.curTabIndex]

	if playerFormMo then
		local pets = playerFormMo:getPetMoList()

		for i = 1, 9 do
			local pet = playerFormMo:getPetMoByIdx(i)

			if pet then
				local fPetMo = pet:toFightingPowerPetMo(pets)

				table.insert(teams, fPetMo)

				formations[i] = fPetMo
			end
		end

		ArraySort.sortOn(teams, "position")
	end

	return teams, formations
end

function SeniorAttackFmtMo:getExtendViewName()
	return ViewName.SeniorfmtextView
end

function SeniorAttackFmtMo:getFmtInfoConfig()
	local userId = SeniorArenaController.instance:getCurOpponentId()
	local forms = SeniorArenaModel.instance:getOppenentDefendForms(userId)

	if forms then
		for i, v in ipairs(forms) do
			if v:getFormId() == self.curTabIndex then
				return v:getExtParams() or {}
			end
		end
	end

	return {}
end

return SeniorAttackFmtMo
