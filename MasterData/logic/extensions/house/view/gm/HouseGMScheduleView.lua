-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMScheduleView.lua

module("logic.extensions.house.view.gm.HouseGMScheduleView", package.seeall)

local M = class("HouseGMScheduleView", ViewComponent)
local WorkStatus = HouseEnum.WorkStatus

function M:buildUI()
	self._toggleWork = self:getGo("schedule_select_tips_1163455909"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleEat = self:getGo("schedule_select_tips_1448385796"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleSleep = self:getGo("schedule_select_tips_1982638089"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleRest = self:getGo("schedule_select_tips_-219773050"):GetComponent(UIComponentType.SpaceXToggle)
	self._btnConfirm = self:getBtn("schedule_select_tips_2060692610")
	self._btnCancel = self:getBtn("schedule_select_tips_-1594640280")
end

function M:destroyUI()
	self._toggleWork = nil
	self._toggleEat = nil
	self._toggleSleep = nil
	self._toggleRest = nil
	self._btnConfirm = nil
	self._btnCancel = nil
	self._selectedStatus = false
end

function M:bindEvents()
	self._toggleWork:AddListener(self._onToggleWork, self)
	self._toggleEat:AddListener(self._onToggleEat, self)
	self._toggleSleep:AddListener(self._onToggleSleep, self)
	self._toggleRest:AddListener(self._onToggleRest, self)
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
end

function M:unbindEvents()
	self._toggleWork:RemoveListener()
	self._toggleEat:RemoveListener()
	self._toggleSleep:RemoveListener()
	self._toggleRest:RemoveListener()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function M:onEnter()
	self._paramData = self:getFirstParam() or {}
	self._selectedStatus = HouseGMController.instance:getFocusWorkStatus()

	self:_refreshView()
end

function M:onExit()
	self._selectedStatus = false
end

function M:_refreshView()
	self._toggleWork.IsOn = self._selectedStatus == WorkStatus.Work
	self._toggleEat.IsOn = self._selectedStatus == WorkStatus.Eat
	self._toggleSleep.IsOn = self._selectedStatus == WorkStatus.Sleep
	self._toggleRest.IsOn = self._selectedStatus == WorkStatus.Rest
end

function M:_changeSelectedStatus(status, isOn)
	if isOn then
		self._selectedStatus = status
	elseif self._selectedStatus == status then
		self._selectedStatus = false
	end

	self:_refreshView()
end

function M:_onToggleWork(toggle, isOn)
	self:_changeSelectedStatus(WorkStatus.Work, isOn)
end

function M:_onToggleEat(toggle, isOn)
	self:_changeSelectedStatus(WorkStatus.Eat, isOn)
end

function M:_onToggleSleep(toggle, isOn)
	self:_changeSelectedStatus(WorkStatus.Sleep, isOn)
end

function M:_onToggleRest(toggle, isOn)
	self:_changeSelectedStatus(WorkStatus.Rest, isOn)
end

function M:_onClickBtnConfirm()
	HouseGMController.instance:setFocusWorkStatus(self._selectedStatus)

	if self._paramData.confirmCallback then
		self._paramData.confirmCallback(self._paramData.confirmTarget)
	end

	self:close()
end

function M:_onClickBtnCancel()
	self:close()
end

return M
