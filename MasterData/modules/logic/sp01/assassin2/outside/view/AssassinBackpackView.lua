-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBackpackView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBackpackView", package.seeall)

local AssassinBackpackView = class("AssassinBackpackView", BaseView)

function AssassinBackpackView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "root/#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_info/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#go_info/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_info/#simage_icon/#txt_num")
	self._gofightEff = gohelper.findChild(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff")
	self._txtfightEffDesc = gohelper.findChildText(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff/#txt_fightEffDesc")
	self._gostealthEff = gohelper.findChild(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff")
	self._txtstealthEffDesc = gohelper.findChildText(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff/#txt_stealthEffDesc")
	self._goremove = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_remove")
	self._goequip = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_equip")
	self._goban = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_ban")
	self._btnchange = gohelper.findChildClickWithAudio(self.viewGO, "root/#go_info/change/#btn_change", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goIsEquiped = gohelper.findChild(self.viewGO, "root/#go_info/#go_Equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBackpackView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._animationEvent:AddEventListener("changeInfo", self.refreshSelectedItemInfo, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnSelectBackpackItem, self.onSelectItem, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
end

function AssassinBackpackView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._animationEvent:RemoveEventListener("changeInfo")
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnSelectBackpackItem, self.onSelectItem, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
end

function AssassinBackpackView:_btnchangeOnClick()
	AssassinController.instance:changeEquippedItem(self._assassinHeroId)
end

function AssassinBackpackView:onSelectItem(isPlaySwitch)
	if isPlaySwitch then
		self.animator:Play("switch", 0, 0)
	else
		self:refreshSelectedItemInfo()
	end
end

function AssassinBackpackView:_onChangeEquippedItem()
	self:refreshSelectedItemInfo()
end

function AssassinBackpackView:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self:refreshSelectedItemInfo()
end

function AssassinBackpackView:onUpdateParam()
	self._assassinHeroId = self.viewParam.assassinHeroId
	self._carryIndex = self.viewParam.carryIndex
end

function AssassinBackpackView:onOpen()
	self:onUpdateParam()

	local index
	local assassinItemId = AssassinHeroModel.instance:getCarryItemId(self._assassinHeroId, self._carryIndex)

	if assassinItemId then
		local assassinItemMo = AssassinItemModel.instance:getAssassinItemMo(assassinItemId)

		index = AssassinBackpackListModel.instance:getIndex(assassinItemMo)
	else
		local itemMoList = AssassinBackpackListModel.instance:getList()

		for i, itemMo in ipairs(itemMoList) do
			local isNew = itemMo:isNew()

			if isNew then
				index = i
			end
		end
	end

	AssassinController.instance:backpackSelectItem(index)
end

function AssassinBackpackView:refreshSelectedItemInfo()
	local selectedItemId = AssassinBackpackListModel.instance:getSelectedItemId()

	if not selectedItemId then
		gohelper.setActive(self._goinfo, false)

		return
	end

	self._txtname.text = AssassinConfig.instance:getAssassinItemName(selectedItemId)

	AssassinHelper.setAssassinItemIcon(selectedItemId, self._imageicon)

	self._txtnum.text = AssassinItemModel.instance:getAssassinItemCount(selectedItemId)

	local fightEffDesc = AssassinConfig.instance:getAssassinItemFightEffDesc(selectedItemId)
	local hasFightEff = not string.nilorempty(fightEffDesc)

	if hasFightEff then
		self._txtfightEffDesc.text = fightEffDesc
	end

	gohelper.setActive(self._gofightEff, hasFightEff)

	local stealthEffDesc = AssassinConfig.instance:getAssassinItemStealthEffDesc(selectedItemId)
	local hasStealthEff = not string.nilorempty(stealthEffDesc)

	if hasStealthEff then
		self._txtstealthEffDesc.text = stealthEffDesc
	end

	gohelper.setActive(self._gostealthEff, hasStealthEff)

	local equipIndex = AssassinHeroModel.instance:getItemCarryIndex(self._assassinHeroId, selectedItemId)

	if equipIndex then
		gohelper.setActive(self._goremove, true)
		gohelper.setActive(self._goequip, false)
		gohelper.setActive(self._goban, false)
		gohelper.setActive(self._goIsEquiped, true)
	else
		local isEquipFull = AssassinHeroModel.instance:isCarryItemFull(self._assassinHeroId)

		gohelper.setActive(self._goremove, false)
		gohelper.setActive(self._goequip, not isEquipFull)
		gohelper.setActive(self._goban, isEquipFull)
		gohelper.setActive(self._goIsEquiped, false)
	end

	gohelper.setActive(self._goinfo, true)
end

function AssassinBackpackView:onClose()
	return
end

function AssassinBackpackView:onDestroyView()
	return
end

return AssassinBackpackView
