-- chunkname: @modules/logic/gm/view/GM_ActivityWelfareView.lua

module("modules.logic.gm.view.GM_ActivityWelfareView", package.seeall)

local GM_ActivityWelfareView = class("GM_ActivityWelfareView", BaseView)
local kYellow = "#FFFF00"

function GM_ActivityWelfareView.register()
	GM_ActivityWelfareView.ActivityWelfareView_register(ActivityWelfareView)
	GM_ActivityWelfareView.ActivityWelfareCategoryItem_register(ActivityWelfareCategoryItem)
end

function GM_ActivityWelfareView.ActivityWelfareView_register(T)
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
		GM_ActivityWelfareViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_ActivityWelfareViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		ActivityWelfareListModel.instance:onModelUpdate()
	end
end

function GM_ActivityWelfareView.ActivityWelfareCategoryItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshItem")
	GMMinusModel.instance:saveOriginalFunc(T, "refreshSelect")

	function T._refreshItem(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshItem", ...)

		if not GM_ActivityWelfareView.s_ShowAllTabId then
			return
		end

		local mo = selfObj._mo
		local actId = mo.id
		local desc = gohelper.getRichColorText(actId, kYellow)

		selfObj._txtnamecn.text = desc
		selfObj._txtunselectnamecn.text = desc
	end

	function T.refreshSelect(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "refreshSelect", ...)

		if not GM_ActivityWelfareView.s_ShowAllTabId then
			return
		end

		gohelper.setActive(selfObj._gonewwelfare, false)
		gohelper.setActive(selfObj._goselectwelfare, false)
		gohelper.setActive(selfObj._goselect, selfObj._selected)
		gohelper.setActive(selfObj._gounselect, not selfObj._selected)
	end
end

function GM_ActivityWelfareView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_ActivityWelfareView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_ActivityWelfareView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_ActivityWelfareView:onOpen()
	self:_refreshItem1()
end

function GM_ActivityWelfareView:onDestroyView()
	return
end

GM_ActivityWelfareView.s_ShowAllTabId = false

function GM_ActivityWelfareView:_refreshItem1()
	self._item1Toggle.isOn = GM_ActivityWelfareView.s_ShowAllTabId
end

function GM_ActivityWelfareView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_ActivityWelfareView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.ActivityWelfareView_ShowAllTabIdUpdate, isOn)
end

return GM_ActivityWelfareView
