-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowTalentStack.lua

module("logic.extensions.bag.panel.stack.PetShowTalentStack", package.seeall)

local PetShowTalentStack = class("PetShowTalentStack", TableViewComponent)

function PetShowTalentStack:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Nego_Right/Nego_Info/Stack/Bag/ScrollView"
	}
end

function PetShowTalentStack:ctor()
	PetShowTalentStack.super.ctor(self)
end

function PetShowTalentStack:destroyUI()
	PetShowTalentStack.super.destroyUI(self)
end

function PetShowTalentStack:onExitFinished()
	PetShowTalentStack.super.onExitFinished(self)
end

function PetShowTalentStack:onEnterFinished()
	PetShowTalentStack.super.onEnterFinished(self)
end

function PetShowTalentStack:unbindEvents()
	PetShowTalentStack.super.unbindEvents(self)
	GameUtil.asBtn(self.btn1):RemoveClickListener()
	GameUtil.asBtn(self.btn2):RemoveClickListener()
	GameUtil.asBtn(self.btn3):RemoveClickListener()
	self.btnRtn:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.TalentTraining, self._OnTalentTraining, self)
	GlobalDispatcher:removeListener(GlobalNotify.TalentStrength, self._OnTalentStrength, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialGet, self._showAllItems, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsed", self.onItemUse, self)
	self._btnRule:RemoveClickListener()
	self._btnCloseRule:RemoveClickListener()
end

function PetShowTalentStack:bindEvents()
	PetShowTalentStack.super.bindEvents(self)
	GameUtil.asBtn(self.btn1):AddClickListener(function()
		self:_OnClickAnyFunc(self.btn1, 1)
	end)
	GameUtil.asBtn(self.btn2):AddClickListener(function()
		self:_OnClickAnyFunc(self.btn2, 2)
	end)
	GameUtil.asBtn(self.btn3):AddClickListener(function()
		self:_OnClickAnyFunc(self.btn3, 3)
	end)
	self.btnRtn:AddClickListener(self.onTabClick, self)
	GlobalDispatcher:addListener(GlobalNotify.TalentTraining, self._OnTalentTraining, self)
	GlobalDispatcher:addListener(GlobalNotify.TalentStrength, self._OnTalentStrength, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._showAllItems, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self.onItemUse, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnCloseRule:AddClickListener(self._onClickCloseRule, self)
end

function PetShowTalentStack:onExit()
	PetShowTalentStack.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
end

function PetShowTalentStack:buildUI()
	PetShowTalentStack.super.buildUI(self)

	self.btnRtn = self:getBtn("Nego_Right/Nego_Info/imgTalent")

	local _Nego_GeniusType = self:getGo("Nego_Right/Nego_Info/imgTalent/Nego_GeniusType")

	self._ImgC_GeniusType = _Nego_GeniusType:GetComponent("UIChangeGroup")
	self._TxtC_GeniusType = goutil.findChild(_Nego_GeniusType, "TxtC_GeniusType"):GetComponent(goutil.Type_UIText)
	self.btn1 = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Btns/btn1"):GetComponent("UIChangeGroup")
	self.btn2 = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Btns/btn2"):GetComponent("UIChangeGroup")
	self.btn3 = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Btns/btn3"):GetComponent("UIChangeGroup")
	self.bag = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Stack/Bag")
	self.talent = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Stack/Talent")
	self.talent2 = goutil.findChild(self.mainGO, "Nego_Right/Nego_Info/Stack/Talent2")
	self.tabList = {
		self.bag,
		self.talent,
		self.talent2
	}
	self.petStackView1 = PetTalentStack1.New(self.talent)
	self.petStackView2 = PetTalentStack2.New(self.talent2)
	self._Nego_Effect = self:getGo("Nego_Right/Nego_Info/Nego_Effect")

	self:_OnClickAnyFunc(self.btn2, 2)

	self._btnRule = self:getBtn("Nego_Right/Nego_Info/Stack/Talent/btnRule")
	self._btnCloseRule = self:getBtn("tipsRule/btnCloseRule")
	self._tipsRule = self:getGo("tipsRule")

	self._tipsRule:SetActive(false)
end

function PetShowTalentStack:_onClickRule()
	self._tipsRule:SetActive(true)
end

function PetShowTalentStack:_onClickCloseRule()
	self._tipsRule:SetActive(false)
end

function PetShowTalentStack:onEnter()
	PetShowTalentStack.super.onEnter(self)
	self:onUpdatePet(true)
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self.onPetSelect, self)
end

function PetShowTalentStack:onTabClick()
	GlobalDispatcher:dispatch(GlobalNotify.PET_VIEW_CHANGE_TAB, PetShowView.TAB_INFO)
end

function PetShowTalentStack:_OnClickAnyFunc(btn, idx)
	idx = idx or 1

	if self._curFunc == btn then
		return
	end

	if self._curFunc then
		self._curFunc:SetState(0)
	end

	self._curFunc = btn

	self._curFunc:SetState(1)

	for i = 1, #self.tabList do
		local go = self.tabList[i]

		if i == idx then
			GameUtil.SetActive(go, true)
		else
			GameUtil.SetActive(go, false)
		end
	end
end

function PetShowTalentStack:_OnTalentTraining(isSuc)
	self:_SetGeniusType(self.curMo)
	self.petStackView1:_SetTalents(false)
	self.petStackView2:_SetTalents(true)
	self:_PlayEff()
end

function PetShowTalentStack:_OnTalentStrength(isSuc)
	self:_SetGeniusType(self.curMo)
	self.petStackView1:_SetTalents(true)
	self.petStackView2:_SetTalents(false)
	self:_PlayEff()
end

function PetShowTalentStack:_PlayEff()
	if self.lastEff ~= nil then
		UIEffectManager.instance:stopEffect(self.lastEff)

		self.lastEff = nil
	end

	self.lastEff = UIEffectManager.instance:playEffect(self, "fx_ui_tianfu/fx_ui_tianfu.prefab", self._Nego_Effect, 70, 0, false)
end

function PetShowTalentStack:_SetGeniusType(petMo)
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

function PetShowTalentStack:_OnPetDataUpdated(oldPet, newPet)
	self.petId = BagPetsController.instance:GetCurPetId()

	local pet = BagPetsController.instance:GetCurPetMo()

	self:_ShowPetDetail(pet)
end

function PetShowTalentStack:setPower()
	return
end

function PetShowTalentStack:onItemUse()
	self:onUpdatePet(true)
end

function PetShowTalentStack:onPetSelect()
	self:onUpdatePet()
end

function PetShowTalentStack:onUpdatePet(first)
	self:_ShowPetDetail()
	self.petStackView1:setPetId(self.petId, first)
	self.petStackView2:setPetId(self.petId, first)
end

function PetShowTalentStack:_ShowPetDetail()
	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	self:setData(bagPetMo)

	self.curMo = bagPetMo
	self.petId = bagPetMo.petId

	self:_SetGeniusType(bagPetMo)
	self:_showAllItems()
end

function PetShowTalentStack:_showAllItems(msg)
	self._curViewDatas = ItemConfig.instance:getEmptyItems(MatType.Item_Talent)

	TableUtil.UpperSort(self._curViewDatas, "order", false)

	local datas = MaterialFacade.instance:getMatByTypeAndSub(MatType.Item_Talent)

	for i, v in ipairs(self._curViewDatas) do
		v.num = 0

		for i1, v1 in ipairs(datas) do
			if v1.id == v.id then
				v.num = v1.num
			end
		end
	end

	self._tableview:ReloadData()
	self._tableview:Refresh()
end

function PetShowTalentStack:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtExp = goutil.findChildTextComponent(cell, "txtExp")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local btnUse = goutil.findChildButtonComponent(cell, "btnUse")
	local btnGet = goutil.findChildButtonComponent(cell, "btnGet")
	local iconLock = goutil.findChild(cell, "iconLock")

	txtName.text = ""
	txtExp.text = ""
	txtNum.text = ""

	GameUtil.SetActive(btnUse, false)
	GameUtil.SetActive(btnGet, false)
	GameUtil.SetActive(iconLock, false)
	GameUtil.asBtn(btnUse):RemoveClickListener()
	GameUtil.asBtn(btnGet):RemoveClickListener()
	uGuiUtil.setGoGrayState(btnUse, false)

	local num = MaterialFacade.instance:getMatNumber(MatType.Item, data.id)
	local co = ItemConfig.instance:getCfgById(data.id)

	txtName.text = co.name
	txtExp.text = co.effect
	txtNum.text = num

	if num == 0 then
		txtNum.text = "<color=#ff0000>0</color>"
	end

	local proxy = MaterialMgr.setCell(MatType.Item, data.id, con)

	if num > 0 then
		if self._curGeniusType >= TalentConfig.instance:getTalentItemType(data.id) then
			GameUtil.SetActive(iconLock, true)
			uGuiUtil.setGoGrayState(btnUse, true)
			GameUtil.SetActive(btnUse, true)
			GameUtil.asBtn(btnUse):AddClickListener(function()
				TipsFacade.instance:openCommonTips(lang("精灵天赋已超过使用道具的天赋，无需使用"))
			end)
		else
			GameUtil.SetActive(btnUse, true)
			GameUtil.asBtn(btnUse):AddClickListener(function()
				self:useItem(data)
			end)
		end
	elseif co and co.source ~= "" then
		GameUtil.SetActive(btnGet, true)
		GameUtil.asBtn(btnGet):AddClickListener(function()
			MaterialMgr.openGetSourceByData(data)
		end)
	end
end

function PetShowTalentStack:useItem(data)
	if self.curMo then
		UIStateManager.instance:open(ViewName.TalentLvlup, data)
	else
		TipsFacade.instance:openCommonTips(lang("没有可以提升天赋的精灵"))
	end
end

function PetShowTalentStack:setData(bagPetMo)
	local cfg = CharacterConfig.instance:getPetCo(bagPetMo.raceId)
end

return PetShowTalentStack
