-- chunkname: @modules/logic/gm/view/GM_VersionActivity_EnterView.lua

module("modules.logic.gm.view.GM_VersionActivity_EnterView", package.seeall)

local GM_VersionActivity_EnterView = class("GM_VersionActivity_EnterView", BaseView)

local function _defaultBtnGmFunc()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_EnterView)
end

function GM_VersionActivity_EnterView.VersionActivityX_XEnterView(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self, _defaultBtnGmFunc)
		GM_VersionActivity_EnterViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_VersionActivity_EnterViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(SelfObj)
		SelfObj:refreshUI()
	end
end

function GM_VersionActivity_EnterView.VersionActivityEnterViewTabItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "refreshNameText")

	local kYellow = "#FFFF00"

	function T.refreshNameText(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "refreshNameText", ...)

		if not GM_VersionActivity_EnterView.s_ShowAllTabId then
			return
		end

		local actId = SelfObj.actId
		local idStr = gohelper.getRichColorText(tostring(actId), kYellow)

		SelfObj.activityNameTexts.select.text = idStr
		SelfObj.activityNameTexts.normal.text = idStr
	end
end

function GM_VersionActivity_EnterView.VersionActivityX_XEnterViewTabItemBase_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "afterSetData")

	local kYellow = "#FFFF00"

	function T.afterSetData(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "afterSetData", ...)

		if not GM_VersionActivity_EnterView.s_ShowAllTabId then
			return
		end

		local activityCo = SelfObj.activityCo
		local actId = activityCo.id
		local idStr = gohelper.getRichColorText(tostring(actId), kYellow)

		SelfObj.txtName.text = idStr
		SelfObj.txtNameEn.text = idStr
	end
end

function GM_VersionActivity_EnterView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_VersionActivity_EnterView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_VersionActivity_EnterView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_VersionActivity_EnterView:onOpen()
	self:_refreshItem1()
end

function GM_VersionActivity_EnterView:onDestroyView()
	return
end

GM_VersionActivity_EnterView.s_ShowAllTabId = false

function GM_VersionActivity_EnterView:_refreshItem1()
	self._item1Toggle.isOn = GM_VersionActivity_EnterView.s_ShowAllTabId
end

function GM_VersionActivity_EnterView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_VersionActivity_EnterView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_EnterView_ShowAllTabIdUpdate, isOn)
end

return GM_VersionActivity_EnterView
