-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseView.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseView", package.seeall)

local AtomicDataBaseView = class("AtomicDataBaseView", BaseView)

function AtomicDataBaseView:onInitView()
	self.goTabItem = gohelper.findChild(self.viewGO, "root/tab/#go_tabitem")

	gohelper.setActive(self.goTabItem, false)

	self.goLocked = gohelper.findChild(self.viewGO, "root/#go_Locked")
	self.txtTips = gohelper.findChildTextMesh(self.viewGO, "root/#go_Locked/Image_TipsBG/#txt_Tips")

	gohelper.setActive(self.goLocked, false)

	self.btnCloseLocked = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Locked/Image_Mask", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.scroll = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_cultural")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDataBaseView:addEvents()
	self.addClickCb(self, self.btnCloseLocked, self.onCloseLocked, self)
	self.addEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseTabChange, self.onTabChange, self)
	self.addEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseUpdate, self.refreshView, self)
	self.addEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseShowLocked, self.showLocked, self)
end

function AtomicDataBaseView:removeEvents()
	self:removeClickCb(self.btnCloseLocked)
	self.removeEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseTabChange, self.onTabChange, self)
	self.removeEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseUpdate, self.refreshView, self)
	self.removeEventCb(self, AtomicDataBaseController.instance, AtomicEvent.DataBaseShowLocked, self.showLocked, self)
end

function AtomicDataBaseView:_editableInitView()
	return
end

function AtomicDataBaseView:onCloseLocked()
	gohelper.setActive(self.goLocked, false)
end

function AtomicDataBaseView:onTabChange()
	self.scroll.verticalNormalizedPosition = 1

	self:refreshView()
end

function AtomicDataBaseView:onUpdateParam()
	return
end

function AtomicDataBaseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_screen_open)
	AtomicDataBaseController.instance:onOpenView()
	self:refreshView()
end

function AtomicDataBaseView:onClose()
	AtomicDataBaseController.instance:onCloseView()
end

function AtomicDataBaseView:refreshView()
	self:refreshTabList()
end

function AtomicDataBaseView:refreshTabList()
	local tabList = AtomicDataBaseViewModel.instance:geTabList()

	self.tabItemList = self.tabItemList or {}

	for i = 1, math.max(#tabList, #self.tabItemList) do
		local tab = tabList[i]
		local item = self:getTabItem(i)

		self:updateTabItem(item, tab)
	end
end

function AtomicDataBaseView:getTabItem(index)
	local item = self.tabItemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self.goTabItem, tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicDataBaseTabItem)
		self.tabItemList[index] = item
	end

	return item
end

function AtomicDataBaseView:updateTabItem(item, tab)
	if not item then
		return
	end

	item:updateData(tab)
end

function AtomicDataBaseView:showLocked(tips)
	gohelper.setActive(self.goLocked, true)

	self.txtTips.text = tips
end

function AtomicDataBaseView:onDestroyView()
	return
end

return AtomicDataBaseView
