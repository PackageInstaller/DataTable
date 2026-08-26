-- chunkname: @modules/logic/gm/view/GM_TaskListCommonItem.lua

module("modules.logic.gm.view.GM_TaskListCommonItem", package.seeall)

local GM_TaskListCommonItem = class("GM_TaskListCommonItem", BaseView)

function GM_TaskListCommonItem:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
	self._item3Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item3/Button")
end

function GM_TaskListCommonItem:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
	self._item3Btn:AddClickListener(self._onItem3Click, self)
end

function GM_TaskListCommonItem:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
	self._item3Btn:RemoveClickListener()
end

function GM_TaskListCommonItem:onOpen()
	self:_refreshItem1()
	self:_refreshItem2()
end

function GM_TaskListCommonItem:onDestroyView()
	return
end

function GM_TaskListCommonItem:_refreshItem1()
	local cls = self.class

	if not cls.s_ShowAllTabId then
		self._item1Toggle.isOn = cls.s_ShowAllTabId
	end
end

function GM_TaskListCommonItem:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn
	local cls = self.class

	if cls.s_ShowAllTabId == isOn then
		return
	end

	cls.s_ShowAllTabId = isOn

	self.viewContainer:_gm_showAllTabIdUpdate(isOn)
end

function GM_TaskListCommonItem:_refreshItem2()
	local cls = self.class

	if not cls.s_enableFinishSelectedTask then
		self._item2Toggle.isOn = cls.s_enableFinishSelectedTask
	end
end

function GM_TaskListCommonItem:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn
	local cls = self.class

	if cls.s_enableFinishSelectedTask == isOn then
		return
	end

	cls.s_enableFinishSelectedTask = isOn

	self.viewContainer:_gm_enableFinishOnSelect(isOn)
end

function GM_TaskListCommonItem:_onItem3Click()
	self.viewContainer:_gm_onClickFinishAll()
end

return GM_TaskListCommonItem
