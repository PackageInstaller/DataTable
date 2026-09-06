-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowSourcemonStack.lua

module("logic.extensions.bag.panel.stack.PetShowSourcemonStack", package.seeall)

local PetShowSourcemonStack = class("PetShowSourcemonStack", ViewComponent)

function PetShowSourcemonStack:ctor()
	PetShowSourcemonStack.super.ctor(self)
end

function PetShowSourcemonStack:destroyUI()
	PetShowSourcemonStack.super.destroyUI(self)
end

function PetShowSourcemonStack:onExitFinished()
	PetShowSourcemonStack.super.onExitFinished(self)
end

function PetShowSourcemonStack:onEnterFinished()
	PetShowSourcemonStack.super.onEnterFinished(self)
end

function PetShowSourcemonStack:unbindEvents()
	PetShowSourcemonStack.super.unbindEvents(self)
	self.btnRtn:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	GameUtil.asBtn(self._BtnLvlup):RemoveClickListener()
	GameUtil.asBtn(self._BtnChange):RemoveClickListener()
end

function PetShowSourcemonStack:bindEvents()
	PetShowSourcemonStack.super.bindEvents(self)
	self.btnRtn:AddClickListener(self.onTabClick, self)
	GameUtil.asBtn(self._BtnLvlup):AddClickListener(self.lvlupClick, self)
	GameUtil.asBtn(self._BtnChange):AddClickListener(self.changeClick, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
end

function PetShowSourcemonStack:onExit()
	PetShowSourcemonStack.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
end

function PetShowSourcemonStack:buildUI()
	PetShowSourcemonStack.super.buildUI(self)

	self.btnRtn = self:getBtn("Nego_Right/Nego_Info/imgSourcemon")
	self.cellList = {}

	for i = 1, 3 do
		local cell = self:getGo("Nego_Right/Nego_Info/Cell" .. i)

		table.insert(self.cellList, cell)
	end

	self.txtSkill = goutil.findChildTextComponent(self.mainGO, "Nego_Right/Nego_Info/Bottom/ScrollView/Viewport/txtSkill")
	self._BtnLvlup = goutil.findChildButtonComponent(self.mainGO, "Nego_Right/Nego_Info/Btns/BtnLvlup")
	self._BtnChange = goutil.findChildButtonComponent(self.mainGO, "Nego_Right/Nego_Info/Btns/BtnChange")
	self.Nego_Instruction = self:getGo("Nego_Instruction")
	self.txtSourcemon = self:getTxt("Nego_Right/Nego_Info/imgSourcemon/txt")
	self._Slider_Sourcemon = self:getGo("Nego_Right/Nego_Info/imgSourcemon/progressBar"):GetComponent(typeof(ProgressBar))
end

function PetShowSourcemonStack:showEffect()
	local effect = self:getGo("Nego_Right/Nego_Info/imgSourcemon/progressBar/Mask/imgTop/effect")
	local effectMaxLv = self:getGo("Nego_Right/Nego_Info/imgSourcemon/progressBar/Mask/effectMaxLv")
	local maskRect = goutil.findChild(self._Slider_Sourcemon, "Mask"):GetComponent(goutil.Type_RectTransform)

	BagPetsFacade._loadEffect(self, effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_mask.prefab", 1, maskRect)
	BagPetsFacade._loadEffect(self, effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_nomask.prefab", 1, maskRect)
end

function PetShowSourcemonStack:onEnter()
	PetShowSourcemonStack.super.onEnter(self)
	self:_ShowPetDetail()
	self:showEffect()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
end

function PetShowSourcemonStack:lvlupClick()
	local petId = BagPetsController.instance:GetCurPetId()

	UIStateManager.instance:push(ViewName.SourceMon, petId, SourceMonView.TAB_LVLUP)
end

function PetShowSourcemonStack:changeClick()
	local petId = BagPetsController.instance:GetCurPetId()

	UIStateManager.instance:push(ViewName.SourceMon, petId, SourceMonView.TAB_CHANGE)
end

function PetShowSourcemonStack:onTabClick()
	GlobalDispatcher:dispatch(GlobalNotify.PET_VIEW_CHANGE_TAB, PetShowView.TAB_INFO)
end

function PetShowSourcemonStack:_OnPetDataUpdated(oldPet, newPet)
	self:_ShowPetDetail()
end

function PetShowSourcemonStack:_OnTalentTraining(isSuc)
	self:_SetGeniusType(self.curMo)
	self.petStackView1:_SetTalents(false)
	self:_PlayEff()
end

function PetShowSourcemonStack:_OnTalentStrength(isSuc)
	self:_SetGeniusType(self.curMo)
	self.petStackView2:_SetTalents(false)
	self:_PlayEff()
end

function PetShowSourcemonStack:_PlayEff()
	UIEffectManager.instance:playEffect(self, "fx_ui_tianfu/fx_ui_tianfu.prefab", self._Nego_Effect, 0, 0, false)
end

function PetShowSourcemonStack:_SetGeniusType(petMo)
	self._TxtC_GeniusType.text = ""

	GameUtil.SetActive(self._ImgC_GeniusType, false)

	if petMo then
		local type = petMo:GetGeniusType()

		self._curGeniusType = type
		self._TxtC_GeniusType.text = ConstString.GeniusName[type]

		GameUtil.SetActive(self._ImgC_GeniusType, true)
		self._ImgC_GeniusType:SetState(type)
	end

	self:setPower()
end

function PetShowSourcemonStack:_OnPetDataUpdated(oldPet, newPet)
	self.petId = BagPetsController.instance:GetCurPetId()

	local pet = BagPetsController.instance:GetCurPetMo()

	self:_ShowPetDetail(pet)
end

function PetShowSourcemonStack:setPower()
	return
end

function PetShowSourcemonStack:_ShowPetDetail()
	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	self:setData(bagPetMo)

	self.curMo = bagPetMo
	self.petId = bagPetMo.petId

	self:setSourceMon()
end

function PetShowSourcemonStack:setSourceMon()
	self.monViewList = {}

	local bagPetMo = self.curMo

	self.txtSkill.text = ""

	local mons = {}
	local filterArr = {}

	if bagPetMo then
		-- block empty
	end

	local arr = {}

	for i = 1, #self.cellList do
		local cell = self.cellList[i]
		local sourcemonMo = mons[i]

		self:_updateCell(cell, sourcemonMo)

		if sourcemonMo then
			local tem, filterArr = SourceMonConfig.instance:getSkillByIdArr(sourcemonMo.defineId, bagPetMo, filterArr)

			for i = 1, #tem do
				table.insert(arr, tem[i])
			end
		end
	end

	self.txtSkill.text = table.concat(arr, "\n\n")
end

function PetShowSourcemonStack:_updateCell(cell, data)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.asBtn(btn):RemoveClickListener()

	txtName.text = ""
	txtDesc.text = ""

	MaterialMgr.setCellByData(MatType.SourceMon, data, con)

	if data then
		GameUtil.asBtn(btn):AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self.Nego_Instruction, MatType.SourceMon, data.defineId, data.level, data.mutatedType)
		end)

		txtName.text = SourceMonConfig.instance:getDescByIdLvl(data.defineId, data.level, " ", 8, 3)

		local ext = SourceMonConfig.instance:getMutatedTypeId(data.mutatedType, data.level)

		if ext ~= "" then
			txtDesc.text = ext
		end
	end
end

function PetShowSourcemonStack:setData(bagPetMo)
	local cfg = CharacterConfig.instance:getPetCo(bagPetMo.raceId)
end

return PetShowSourcemonStack
