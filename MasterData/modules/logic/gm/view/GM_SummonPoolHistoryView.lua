-- chunkname: @modules/logic/gm/view/GM_SummonPoolHistoryView.lua

module("modules.logic.gm.view.GM_SummonPoolHistoryView", package.seeall)

local GM_SummonPoolHistoryView = class("GM_SummonPoolHistoryView", BaseView)
local kGreen = "#00FF00"

function GM_SummonPoolHistoryView.register()
	GM_SummonPoolHistoryView.SummonPoolHistoryView_register(SummonPoolHistoryView)
	GM_SummonPoolHistoryView.SummonPoolHistoryTypeItem_register(SummonPoolHistoryTypeItem)
end

function GM_SummonPoolHistoryView.SummonPoolHistoryView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_SummonPoolHistoryViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_SummonPoolHistoryViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		SummonPoolHistoryTypeListModel.instance:onModelUpdate()
	end
end

function GM_SummonPoolHistoryView.SummonPoolHistoryTypeItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onUpdateMO")

	function T.onUpdateMO(selfObj, mo, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onUpdateMO", mo, ...)

		if not GM_SummonPoolHistoryView.s_ShowAllTabId then
			return
		end

		local config = mo.config
		local desc = config.name .. gohelper.getRichColorText(config.id, kGreen)

		selfObj._txtunname.text = desc
		selfObj._txtname.text = desc
	end
end

function GM_SummonPoolHistoryView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_SummonPoolHistoryView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_SummonPoolHistoryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_SummonPoolHistoryView:onOpen()
	self:_refreshItem1()
end

function GM_SummonPoolHistoryView:onDestroyView()
	return
end

GM_SummonPoolHistoryView.s_ShowAllTabId = false

function GM_SummonPoolHistoryView:_refreshItem1()
	self._item1Toggle.isOn = GM_SummonPoolHistoryView.s_ShowAllTabId
end

function GM_SummonPoolHistoryView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_SummonPoolHistoryView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, isOn)
end

return GM_SummonPoolHistoryView
