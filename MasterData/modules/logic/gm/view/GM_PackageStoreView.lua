-- chunkname: @modules/logic/gm/view/GM_PackageStoreView.lua

module("modules.logic.gm.view.GM_PackageStoreView", package.seeall)

local GM_PackageStoreView = class("GM_PackageStoreView", BaseView)

function GM_PackageStoreView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
end

function GM_PackageStoreView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
end

function GM_PackageStoreView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
end

function GM_PackageStoreView:onOpen()
	self:_refreshItem1()
	self:_refreshItem2()
end

function GM_PackageStoreView:onDestroyView()
	return
end

GM_PackageStoreView.s_ShowAllTabId = false

function GM_PackageStoreView:_refreshItem1()
	self._item1Toggle.isOn = GM_PackageStoreView.s_ShowAllTabId
end

function GM_PackageStoreView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_PackageStoreView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.PackageStoreView_ShowAllTabIdUpdate, isOn)
end

GM_PackageStoreView.s_ShowAllItemId = false

function GM_PackageStoreView:_refreshItem2()
	self._item2Toggle.isOn = GM_PackageStoreView.s_ShowAllItemId
end

function GM_PackageStoreView:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn

	GM_PackageStoreView.s_ShowAllItemId = isOn

	GMController.instance:dispatchEvent(GMEvent.PackageStoreView_ShowAllItemIdUpdate, isOn)
end

return GM_PackageStoreView
