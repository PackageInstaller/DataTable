-- chunkname: @modules/logic/gm/view/GM_SummonMainView.lua

module("modules.logic.gm.view.GM_SummonMainView", package.seeall)

local GM_SummonMainView = class("GM_SummonMainView", BaseView)

function GM_SummonMainView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_SummonMainView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_SummonMainView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_SummonMainView:onOpen()
	self:_refreshItem1()
end

function GM_SummonMainView:onDestroyView()
	return
end

GM_SummonMainView.s_ShowAllTabId = false

function GM_SummonMainView:_refreshItem1()
	self._item1Toggle.isOn = GM_SummonMainView.s_ShowAllTabId
end

function GM_SummonMainView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_SummonMainView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.SummonMainView_ShowAllTabIdUpdate, isOn)
end

return GM_SummonMainView
