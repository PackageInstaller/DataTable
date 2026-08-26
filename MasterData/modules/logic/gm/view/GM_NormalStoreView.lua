-- chunkname: @modules/logic/gm/view/GM_NormalStoreView.lua

module("modules.logic.gm.view.GM_NormalStoreView", package.seeall)

local GM_NormalStoreView = class("GM_NormalStoreView", BaseView)

function GM_NormalStoreView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
end

function GM_NormalStoreView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
end

function GM_NormalStoreView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
end

function GM_NormalStoreView:onOpen()
	self:_refreshItem1()
	self:_refreshItem2()
end

function GM_NormalStoreView:onDestroyView()
	return
end

GM_NormalStoreView.s_ShowAllTabId = false

function GM_NormalStoreView:_refreshItem1()
	self._item1Toggle.isOn = GM_NormalStoreView.s_ShowAllTabId
end

function GM_NormalStoreView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_NormalStoreView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.NormalStoreView_ShowAllTabIdUpdate, isOn)
end

GM_NormalStoreView.s_ShowAllGoodsId = false

function GM_NormalStoreView:_refreshItem2()
	self._item2Toggle.isOn = GM_NormalStoreView.s_ShowAllGoodsId
end

function GM_NormalStoreView:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn

	GM_NormalStoreView.s_ShowAllGoodsId = isOn

	GMController.instance:dispatchEvent(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, isOn)
end

return GM_NormalStoreView
