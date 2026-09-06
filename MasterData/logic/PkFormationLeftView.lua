-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFormationLeftView.lua

module("logic.extensions.pk.view.PkFormationLeftView", package.seeall)

local PkFormationLeftView = class("PkFormationLeftView", FormationLeftViewBase)

function PkFormationLeftView:unbindEvents()
	PkFormationLeftView.super.unbindEvents(self)
	self._oneKeyBtn:RemoveClickListener()
	self._cleanBtn:RemoveClickListener()
end

function PkFormationLeftView:bindEvents()
	PkFormationLeftView.super.bindEvents(self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKey, self)
	self._cleanBtn:AddClickListener(self._onClickClean, self)
end

function PkFormationLeftView:onExit()
	PkFormationLeftView.super.onExit(self)
end

function PkFormationLeftView:buildUI()
	PkFormationLeftView.super.buildUI(self)

	self._oneKeyBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_OneKey")
	self._cleanBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_Clean")
end

function PkFormationLeftView:onEnter()
	self._usePublicAttr = TraincampqiecuoModel.instance:getPkRoomCommonAttrState()
	self._publicPets = {}

	PkFastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	PkFormationLeftView.super.onEnter(self)
end

function PkFormationLeftView:_OnClickBtnBuffForm()
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

function PkFormationLeftView:_onClickOneKey()
	PkFastFormation.instance:setFormation()
end

function PkFormationLeftView:_onClickClean()
	local fixedPosDic = MissionModel.instance:getFixedPos()

	PkFastFormation.instance:clean(fixedPosDic)
end

function PkFormationLeftView:_onSetFormationTabSuccess()
	return
end

function PkFormationLeftView:_setCurFmtName(tabId, tabName)
	return
end

function PkFormationLeftView:_getCurFormation()
	return TraincampqiecuoModel.instance:getMyFormation()
end

function PkFormationLeftView:_setPositionForce(positions, forceDispatch)
	TraincampqiecuoModel.instance:getMyFormation():setPositionForce(positions, forceDispatch)
end

function PkFormationLeftView:_changePosition(pos, value)
	local petDat = BagPetsController.instance:getPet(value)

	self:_getCurFormation():SetPosition(pos, value)
end

function PkFormationLeftView:_getPetsHeroSkills()
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

	local fmo = self:_getCurFormation()
	local summonId = fmo:GetSummonPetId()
	local masterId = fmo:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, fmo:getCurElementRelationMap(), masterId, summonId))
end

function PkFormationLeftView:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function PkFormationLeftView:_changeHeroSkillId(id)
	self:_getCurFormation():SetHeroSkillId(id)
end

function PkFormationLeftView:_saveCurrFmt()
	return
end

function PkFormationLeftView:_getPet(petId)
	if self._usePublicAttr then
		return self:_getPublickPet(petId)
	else
		return BagPetsController.instance:getPet(petId)
	end
end

function PkFormationLeftView:_getPublickPet(petId)
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

function PkFormationLeftView:_onSelectBuffForm(formId, formLv)
	if self._usePublicAttr then
		formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
	end

	PkFormationLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function PkFormationLeftView:_OnClickBtnBuffForm()
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

function PkFormationLeftView:_refreshBuffForm()
	if not self._usePublicAttr then
		PkFormationLeftView.super._refreshBuffForm(self)

		return
	end

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

return PkFormationLeftView
