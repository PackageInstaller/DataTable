-- chunkname: @modules/logic/gm/view/GM_ClothesStoreView.lua

module("modules.logic.gm.view.GM_ClothesStoreView", package.seeall)

local GM_ClothesStoreView = class("GM_ClothesStoreView", BaseView)

function GM_ClothesStoreView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_ClothesStoreView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_ClothesStoreView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_ClothesStoreView:onOpen()
	self:_refreshItem1()
end

function GM_ClothesStoreView:onDestroyView()
	return
end

GM_ClothesStoreView.s_ShowAllTabId = false

function GM_ClothesStoreView:_refreshItem1()
	self._item1Toggle.isOn = GM_ClothesStoreView.s_ShowAllTabId
end

function GM_ClothesStoreView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_ClothesStoreView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.ClothesStoreView_ShowAllTabIdUpdate, isOn)
end

return GM_ClothesStoreView
