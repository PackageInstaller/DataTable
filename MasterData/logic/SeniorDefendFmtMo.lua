-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/model/SeniorDefendFmtMo.lua

module("logic.extensions.seniorarena.model.SeniorDefendFmtMo", package.seeall)

local SeniorDefendFmtMo = class("SeniorDefendFmtMo", BaseCustomFmtMo)

function SeniorDefendFmtMo:onInit()
	SeniorDefendFmtMo.super.onInit(self)

	self.useMaxFightPower = false
	self.isShowTab = true
	self.curTabIndex = 1
end

function SeniorDefendFmtMo:initFormationMo()
	self._changeIndexList = {
		1,
		2,
		3
	}
	self.forMationMap = {}

	local forms = SeniorArenaModel.instance:getMyDefendFormMos()

	for i, v in ipairs(self._changeIndexList) do
		local fmo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
		local playerFormMo = forms[i]

		if playerFormMo then
			fmo:SetData(playerFormMo._curForm)
		end

		self.forMationMap[i] = fmo
	end
end

function SeniorDefendFmtMo:getCurFormation()
	return self:_createOrGetFormation(self.curTabIndex)
end

function SeniorDefendFmtMo:onFmoSetDown()
	local fmo = self:getCurFormation()
	local posList = fmo:GetPositions()
	local forms = {
		1,
		2,
		3
	}

	for i, v in ipairs(forms) do
		if i ~= self.curTabIndex then
			local tarMo = self:_createOrGetFormation(i)
			local posList = tarMo:GetPositions()

			for pos, petId in pairs(posList) do
				if fmo:HasPet(petId) then
					tarMo:SetPosition(pos, 0, true)
				end
			end
		end
	end
end

function SeniorDefendFmtMo:_createOrGetFormation(idx)
	self.formationMo = self.forMationMap[idx]

	return self.formationMo
end

function SeniorDefendFmtMo:sendSaveMsg()
	if not SeniorArenaController.instance:getIsOpen(true) then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

		return
	end

	local forms = {}

	for i, v in ipairs(self._changeIndexList) do
		local form = Arena3v3Extension_pb.Arena3v3SetFormNO()

		form.formId = i

		local fmtMo = self:_createOrGetFormation(i)

		FormationFacade.createFormPb(form.simpleForm, fmtMo)
		table.insert(forms, form)
	end

	SeniorArenaController.instance._setForms = forms
	SeniorArenaController.instance._isAttack = false

	Arena3v3Agent.instance:sendArena3v3SetMyDefenseFormationReq(forms, SeniorArenaController.instance._onSetMyFormRes, SeniorArenaController.instance, SeniorArenaController.instance._errorCall)
end

function SeniorDefendFmtMo:checkPetIsForbit(petMo, baseCheck)
	local fmo = self:getCurFormation()
	local posList = fmo:GetPositions()

	for i, v in ipairs(self._changeIndexList) do
		if i ~= self.curTabIndex then
			local tarMo = self:_createOrGetFormation(i)

			if tarMo:HasPet(petMo.petId) then
				return true
			end
		end
	end

	return false
end

function SeniorDefendFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) then
		FloatWordMgr.instance:show("其他阵型中已使用该精灵")
	end
end

function SeniorDefendFmtMo:getFormationMos()
	return self.forMationMap
end

return SeniorDefendFmtMo
