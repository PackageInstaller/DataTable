-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyBagView.lua

module("modules.logic.sp01.odyssey.view.OdysseyBagView", package.seeall)

local OdysseyBagView = class("OdysseyBagView", BaseView)

function OdysseyBagView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_fullbg")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "root/Top/#btn_equip")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/Top/#btn_task")
	self._goequipReddot = gohelper.findChild(self.viewGO, "root/Top/#btn_equip/go_reddot")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "root/Top/#btn_task/go_reddot")
	self._scrollLeftTab = gohelper.findChildScrollRect(self.viewGO, "root/Equip/#scroll_LeftTab")
	self._goTabItem = gohelper.findChild(self.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#image_icon")
	self._goselect = gohelper.findChild(self.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#btn_click")
	self._scrollEquip = gohelper.findChildScrollRect(self.viewGO, "root/Equip/#scroll_Equip")
	self._goDetailEquip = gohelper.findChild(self.viewGO, "root/Equip/#go_DetailEquip")
	self._goDetailItem = gohelper.findChild(self.viewGO, "root/Equip/#go_DetailItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyBagView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, self.onItemSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, self.OnEquipSuitSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshList, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshBagReddot, self.refreshReddot, self)
end

function OdysseyBagView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, self.onItemSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, self.OnEquipSuitSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshList, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshBagReddot, self.refreshReddot, self)
end

function OdysseyBagView:_editableInitView()
	OdysseyEquipSuitTabListModel.instance:initList()

	self._goEquipUnSelect = gohelper.findChild(self.viewGO, "root/Top/#btn_equip/unselect")
	self._goEquipSelected = gohelper.findChild(self.viewGO, "root/Top/#btn_equip/selected")
	self._goItemUnSelect = gohelper.findChild(self.viewGO, "root/Top/#btn_task/unselect")
	self._goItemSelected = gohelper.findChild(self.viewGO, "root/Top/#btn_task/selected")
	self._equipDetailItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goDetailEquip, OdysseyBagEquipDetailItem)
	self._itemDetailItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goDetailItem, OdysseyBagItemDetailItem)
	self._animView = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._animEquip = gohelper.findChildComponent(self.viewGO, "root/Equip/#go_DetailEquip", gohelper.Type_Animator)
	self._animItem = gohelper.findChildComponent(self.viewGO, "root/Equip/#go_DetailItem", gohelper.Type_Animator)
	self._animScroll = gohelper.findChildComponent(self.viewGO, "root/Equip/#scroll_Equip", gohelper.Type_Animator)
end

function OdysseyBagView:_btnequipOnClick()
	self:switchList(OdysseyEnum.ItemType.Equip)
end

function OdysseyBagView:_btntaskOnClick()
	if not OdysseyItemModel.instance:haveTaskItem() then
		logError("奥德赛下半角色活动 暂无任务道具")

		return
	end

	self:switchList(OdysseyEnum.ItemType.Item)
end

function OdysseyBagView:switchList(targetType)
	if self._itemType == targetType then
		return
	end

	self._itemType = targetType
	self._equipFilterType = nil

	OdysseyEquipSuitTabListModel.instance:clearSelect()

	if targetType == OdysseyEnum.ItemType.Equip then
		OdysseyEquipSuitTabListModel.instance:selectAllTag()
	end

	self:refreshList()
	self:refreshItemBtnState()

	local firstMo = OdysseyEquipListModel.instance:getFirstMo()

	if firstMo then
		OdysseyEquipListModel.instance:setSelect(firstMo.itemMo.uid)
	else
		self:onItemSelect(nil)
	end
end

function OdysseyBagView:refreshItemBtnState()
	local isEquip = self._itemType == OdysseyEnum.ItemType.Equip
	local haveTaskItem = OdysseyItemModel.instance:haveTaskItem()

	gohelper.setActive(self._btntask, haveTaskItem)
	gohelper.setActive(self._goItemSelected, not isEquip)
	gohelper.setActive(self._goItemUnSelect, isEquip)
	gohelper.setActive(self._goEquipSelected, isEquip)
	gohelper.setActive(self._goEquipUnSelect, not isEquip)
	gohelper.setActive(self._scrollLeftTab, isEquip)
end

function OdysseyBagView:_btnclickOnClick()
	return
end

function OdysseyBagView:onUpdateParam()
	return
end

function OdysseyBagView:onOpen()
	local viewParam = self.viewParam

	if viewParam and viewParam.itemType then
		if not viewParam.itemType then
			local itemType = OdysseyEnum.ItemType.Equip

			if itemType == OdysseyEnum.ItemType.Item and not OdysseyItemModel.instance:haveTaskItem() then
				logError("奥德赛下半角色活动 暂无任务道具")

				itemType = OdysseyEnum.ItemType.Equip
			end

			self:switchList(itemType)
			OdysseyStatHelper.instance:initViewStartTime()
		end
	end
end

function OdysseyBagView:refreshList()
	OdysseyEquipListModel.instance:copyListFromEquipModel(self._itemType, self._equipFilterType, OdysseyEnum.BagType.Bag)
	self:refreshReddot()
	self._animScroll:Play("flash", 0, 0)
end

function OdysseyBagView:onItemSelect(mo)
	local isSelect = mo ~= nil
	local currentType = self._itemType
	local isEquip = currentType == OdysseyEnum.ItemType.Equip

	gohelper.setActive(self._goDetailEquip, isSelect and isEquip)
	gohelper.setActive(self._goDetailItem, isSelect and not isEquip)

	if isSelect and isEquip then
		self._animEquip:Play("open", 0, 0)
	elseif isSelect and not isEquip then
		self._animItem:Play("open", 0, 0)
	end

	if isSelect then
		if isEquip then
			if not self._equipDetailItem then
				local item = self._itemDetailItem

				item:setInfo(mo.itemMo)
			end
		end
	end

	self:refreshReddot()
end

function OdysseyBagView:OnEquipSuitSelect(mo)
	local suitType

	if mo.type == OdysseyEnum.EquipSuitType.All then
		-- block empty
	else
		suitType = mo and mo.suitId

		if self._equipFilterType == suitType then
			return
		end
	end

	self._equipFilterType = suitType

	local selectMo = OdysseyEquipListModel.instance:getSelectMo()

	self:refreshList()
	OdysseyEquipListModel.instance:setSelect(selectMo.uid)
end

function OdysseyBagView:refreshReddot()
	local canShowEquipReddot = OdysseyItemModel.instance:checkBagTagShowReddot(OdysseyEnum.ItemType.Equip)

	gohelper.setActive(self._goequipReddot, canShowEquipReddot)

	local canShowTaskReddot = OdysseyItemModel.instance:checkBagTagShowReddot(OdysseyEnum.ItemType.Item)

	gohelper.setActive(self._gotaskReddot, canShowTaskReddot)
end

function OdysseyBagView:onClose()
	local hasClickItemList = OdysseyItemModel.instance:getHasClickItemList()

	if #hasClickItemList > 0 then
		OdysseyRpc.instance:sendOdysseyBagUpdateItemNewFlagRequest(hasClickItemList)
	end

	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyBagView")
end

function OdysseyBagView:onDestroyView()
	return
end

return OdysseyBagView
