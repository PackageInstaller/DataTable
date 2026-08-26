-- chunkname: @modules/logic/gm/view/GM_ActivityBeginnerView.lua

module("modules.logic.gm.view.GM_ActivityBeginnerView", package.seeall)

local GM_ActivityBeginnerView = class("GM_ActivityBeginnerView", BaseView)
local kYellow = "#FFFF00"

function GM_ActivityBeginnerView.register()
	GM_ActivityBeginnerView.ActivityBeginnerView_register(ActivityBeginnerView)
	GM_ActivityBeginnerView.ActivityCategoryItem_register(ActivityCategoryItem)
end

function GM_ActivityBeginnerView.ActivityBeginnerView_register(T)
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
		GM_ActivityBeginnerViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_ActivityBeginnerViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		ActivityBeginnerCategoryListModel.instance:onModelUpdate()
	end
end

function GM_ActivityBeginnerView.ActivityCategoryItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshItem")

	function T._refreshItem(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshItem", ...)

		if not GM_ActivityBeginnerView.s_ShowAllTabId then
			return
		end

		local mo = selfObj._mo
		local actId = mo.id
		local desc = gohelper.getRichColorText(actId, kYellow)

		selfObj._txtnamecn.text = desc
		selfObj._txtunselectnamecn.text = desc
	end
end

function GM_ActivityBeginnerView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_ActivityBeginnerView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_ActivityBeginnerView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_ActivityBeginnerView:onOpen()
	self:_refreshItem1()
end

function GM_ActivityBeginnerView:onDestroyView()
	return
end

GM_ActivityBeginnerView.s_ShowAllTabId = false

function GM_ActivityBeginnerView:_refreshItem1()
	self._item1Toggle.isOn = GM_ActivityBeginnerView.s_ShowAllTabId
end

function GM_ActivityBeginnerView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_ActivityBeginnerView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, isOn)
end

return GM_ActivityBeginnerView
