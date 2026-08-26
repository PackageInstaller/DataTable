-- chunkname: @modules/logic/versionactivity3_3/arcade/view/handbook/ArcadeHandBookView.lua

module("modules.logic.versionactivity3_3.arcade.view.handbook.ArcadeHandBookView", package.seeall)

local ArcadeHandBookView = class("ArcadeHandBookView", BaseView)

function ArcadeHandBookView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "#go_view/root/scroll")
	self._goitem = gohelper.findChild(self.viewGO, "#go_view/root/scroll/Viewport/Content/#go_item")
	self._simagehero = gohelper.findChildImage(self.viewGO, "#go_view/root/scroll/Viewport/Content/#go_item/unlock/#simage_hero")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHandBookView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCbs()
end

function ArcadeHandBookView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCbs()
end

function ArcadeHandBookView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeHandBookView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeHandBookView:addEventCbs()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeHandBookView:removeEventCbs()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeHandBookView:_onClickHandBookItem(type, id)
	local tabItem = self._tabItems[type]

	tabItem:refreshReddot()
end

function ArcadeHandBookView:_onCutHandBookTab(type)
	self:refreshView()
end

function ArcadeHandBookView:_editableInitView()
	self._model = ArcadeHandBookModel.instance
	self._gotab = gohelper.findChild(self.viewGO, "tab")

	gohelper.setActive(self._goitem, false)

	self._tabItems = self:getUserDataTb_()

	for i = 1, 4 do
		local go = gohelper.findChild(self._gotab, "#go_tab" .. i)
		local type = self._model.instance:getTypeByIndex(i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeHandBookTabItem)

		item:onUpdateMO(type)

		self._tabItems[type] = item
	end

	self._goContent = gohelper.findChild(self.viewGO, "#go_view/root/scroll/Viewport/Content")
	self._itemList = self:getUserDataTb_()
end

function ArcadeHandBookView:onUpdateParam()
	return
end

function ArcadeHandBookView:onOpen()
	self:refreshView()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeHandBookView:refreshView()
	self:_refreshItem()
	self:_refreshTab()
	self:_refreshReddot()

	self._scroll.verticalNormalizedPosition = 1
end

function ArcadeHandBookView:_refreshTab()
	local curType, id = self._model:getShowTypeId()

	for _type, item in pairs(self._tabItems) do
		item:onSelect(curType == _type)
	end
end

function ArcadeHandBookView:_refreshReddot()
	local list = ArcadeHandBookListModel.instance:getList()
	local isClearNew = false

	for i, mo in ipairs(list) do
		if not mo:isLock() and mo:isNew() then
			mo:setNew()
			mo:saveNew()

			isClearNew = true
		end
	end

	if isClearNew then
		ArcadeHallModel.instance:refreshHandBookReddot()
		ArcadeController.instance:dispatchEvent(ArcadeEvent.OnRefreshHallBuildingReddot, ArcadeHallEnum.HallInteractiveId.HandBook)
	end
end

function ArcadeHandBookView:_refreshItem()
	local list = ArcadeHandBookListModel.instance:getList()

	for i, mo in ipairs(list) do
		local item = self:_getItem(i)

		item:onUpdateMO(mo)
	end

	for i = 1, #self._itemList do
		gohelper.setActive(self._itemList[i].viewGO, i <= #list)
	end

	local lastMo = list[#list]
	local _, sizeY = lastMo:getIconSize()
	local _, anchorY = lastMo:getAnchor()
	local itemParams = ArcadeEnum.HandBookItemParams

	recthelper.setHeight(self._goContent.transform, sizeY + anchorY + itemParams.DiffY)
end

function ArcadeHandBookView:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goitem, "item_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeHandBookItem)
		self._itemList[index] = item
	end

	return item
end

function ArcadeHandBookView:onClose()
	return
end

function ArcadeHandBookView:onDestroyView()
	return
end

return ArcadeHandBookView
