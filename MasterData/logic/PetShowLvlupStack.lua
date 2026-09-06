-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowLvlupStack.lua

module("logic.extensions.bag.panel.stack.PetShowLvlupStack", package.seeall)

local PetShowLvlupStack = class("PetShowLvlupStack", TableViewComponent)

function PetShowLvlupStack:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Nego_Right/Nego_Info/ScrollView"
	}
end

function PetShowLvlupStack:ctor()
	PetShowLvlupStack.super.ctor(self)
end

function PetShowLvlupStack:destroyUI()
	PetShowLvlupStack.super.destroyUI(self)
end

function PetShowLvlupStack:onExitFinished()
	PetShowLvlupStack.super.onExitFinished(self)
end

function PetShowLvlupStack:onEnterFinished()
	PetShowLvlupStack.super.onEnterFinished(self)
end

function PetShowLvlupStack:unbindEvents()
	PetShowLvlupStack.super.unbindEvents(self)
	self.btnRtn:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialGet, self._showAllFruits, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
end

function PetShowLvlupStack:bindEvents()
	PetShowLvlupStack.super.bindEvents(self)
	self.btnRtn:AddClickListener(self.onTabClick, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._showAllFruits, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
end

function PetShowLvlupStack:onExit()
	PetShowLvlupStack.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
end

function PetShowLvlupStack:buildUI()
	PetShowLvlupStack.super.buildUI(self)

	self.btnRtn = self:getBtn("Nego_Right/Nego_Info/imgLvl")
	self.expSlider = self:getGo("Nego_Right/Nego_Info/imgLvl/expSlider"):GetComponent("Slider")
	self.txtLvl = self:getTxt("Nego_Right/Nego_Info/imgLvl/txtLvl")
	self.stars = self:getGo("Nego_Right/Nego_Info/imgLvl/stars")
end

function PetShowLvlupStack:onEnter()
	PetShowLvlupStack.super.onEnter(self)
	self:_ShowPetDetail()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
end

function PetShowLvlupStack:onTabClick()
	GlobalDispatcher:dispatch(GlobalNotify.PET_VIEW_CHANGE_TAB, PetShowView.TAB_INFO)
end

function PetShowLvlupStack:_OnPetDataUpdated(oldPet, newPet)
	self:_ShowPetDetail()
end

function PetShowLvlupStack:_ShowPetDetail()
	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	self:setData(bagPetMo)

	self.curMo = bagPetMo
	self.petId = bagPetMo.petId
	self.raceId = bagPetMo.raceId
	self._isMaxLevel = self.curMo:isMaxLv()

	self:_showAllFruits()
end

function PetShowLvlupStack:_showAllFruits(msg)
	self._curViewDatas = ItemConfig.instance:getEmptyItems(MatType.Item_Fruit)

	TableUtil.UpperSort(self._curViewDatas, "order", false)

	local datas = MaterialFacade.instance:getMatByTypeAndSub(MatType.Item_Fruit)

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

function PetShowLvlupStack:_updateCell(view, cell, data)
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
		GameUtil.SetActive(btnUse, true)

		if self._isMaxLevel then
			uGuiUtil.setGoGrayState(btnUse, true)
			GameUtil.asBtn(btnUse):AddClickListener(function()
				TipsFacade.instance:openCommonTips(lang("精灵已经满级，无需使用"))
			end)
		else
			if data.id == 7 and self.curMo.level >= 50 then
				uGuiUtil.setGoGrayState(btnUse, true)
				GameUtil.asBtn(btnUse):AddClickListener(function()
					TipsFacade.instance:openCommonTips(lang("精灵等级已超过使用道具的等级，无需使用"))
				end)

				return
			end

			if data.id == 8 and self.curMo.level >= 100 then
				uGuiUtil.setGoGrayState(btnUse, true)
				GameUtil.asBtn(btnUse):AddClickListener(function()
					TipsFacade.instance:openCommonTips(lang("精灵等级已超过使用道具的等级，无需使用"))
				end)

				return
			end

			uGuiUtil.setGoGrayState(btnUse, false)
		end

		GameUtil.asBtn(btnUse):AddClickListener(function()
			self:useItem(data)
		end)
	elseif co and co.source ~= "" then
		GameUtil.SetActive(btnGet, true)
		GameUtil.asBtn(btnGet):AddClickListener(function()
			MaterialMgr.openGetSourceByData(data)
		end)
	end
end

function PetShowLvlupStack:useItem(data)
	if self.curMo then
		if self._isMaxLevel then
			TipsFacade.instance:openCommonTips(lang("精灵已满级"))
		elseif data.id == 6 or data.id == 7 or data.id == 8 then
			UIStateManager.instance:open(ViewName.FruitPopup, data)
		else
			UIStateManager.instance:open(ViewName.FruitLvlup, data)
		end
	else
		TipsFacade.instance:openCommonTips(lang("没有可以升级的精灵"))
	end
end

function PetShowLvlupStack:setData(bagPetMo)
	local cfg = CharacterConfig.instance:getPetCo(bagPetMo.raceId)

	self.txtLvl.text = bagPetMo.level
	self.expSlider.value = bagPetMo.level / CharacterConfig.instance:GetMaxLevel(bagPetMo.raceId)

	if not cfg.starCount then
		local starCount = 1

		for i = 1, 6 do
			local mc = goutil.findChild(self.stars, "star" .. i)

			GameUtil.SetActive(mc, i <= starCount)
		end

		GameUtil.setAnchoredPos(self.stars, 35 + 12 * (6 - starCount), -150)
	end
end

return PetShowLvlupStack
