-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventMainView.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventMainView", package.seeall)

local CommandStationDispatchEventMainView = class("CommandStationDispatchEventMainView", BaseView)

function CommandStationDispatchEventMainView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gochild = gohelper.findChild(self.viewGO, "#go_child")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDispatchEventMainView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CommandStationDispatchEventMainView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CommandStationDispatchEventMainView:_btncloseOnClick()
	self:checkClose()
end

function CommandStationDispatchEventMainView:checkClose()
	if self._curTabViewId == CommandStationEnum.DispatchTabView.Process then
		local eventInfo = CommandStationModel.instance:getDispatchEventInfo(self._curEventConfig.id)

		if not eventInfo then
			self:_openTabView(CommandStationEnum.DispatchTabView.Normal)

			return
		end
	end

	self:closeThis()
end

function CommandStationDispatchEventMainView:_btnLeftOnClick()
	self._toLeft = true
	self._curIndex = self._curIndex - 1

	if self._curIndex < 1 then
		self._curIndex = #self._eventList
	end

	self:_updateEventInfo()

	self._toLeft = nil

	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationDispatchEventMainView:_btnRightOnClick()
	self._toLeft = false
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._eventList then
		self._curIndex = 1
	end

	self:_updateEventInfo()

	self._toLeft = nil

	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationDispatchEventMainView:_updateBtnState()
	if self._curTabViewId == CommandStationEnum.DispatchTabView.Process and CommandStationModel.instance:getDispatchEventState(self._curEventConfig.id) == CommandStationEnum.DispatchState.NotStart then
		gohelper.setActive(self._btnLeft, false)
		gohelper.setActive(self._btnRight, false)

		return
	end

	gohelper.setActive(self._btnLeft.gameObject, self._maxIndex ~= 1)
	gohelper.setActive(self._btnRight.gameObject, self._maxIndex ~= 1)
end

function CommandStationDispatchEventMainView:_updateEventInfo()
	local eventId = self._eventList[self._curIndex]
	local eventConfig = lua_copost_event.configDict[eventId]

	if not eventConfig then
		logError("CommandStationDispatchEventMainView _updateEventInfo eventConfig is nil")

		return
	end

	self._curEventConfig = eventConfig

	local tabViewId = self:_getTabId(eventId)

	self:_openTabView(tabViewId)

	self.viewParam.defaultTabIds[2] = tabViewId
end

function CommandStationDispatchEventMainView:_getTabId(eventId)
	local eventInfo = CommandStationModel.instance:getDispatchEventInfo(eventId)

	if not eventInfo then
		return CommandStationEnum.DispatchTabView.Normal
	end

	if not eventInfo:hasGetReward() then
		return CommandStationEnum.DispatchTabView.Process
	end

	return CommandStationEnum.DispatchTabView.Normal
end

function CommandStationDispatchEventMainView:_editableInitView()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.ClickDispatch, self._onClickDispatch, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.DispatchFinish, self._onDispatchFinish, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.DispatchStart, self._onDispatchStart, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.AfterEventFinish, self._onAfterEventFinish, self)
end

function CommandStationDispatchEventMainView:_onAfterEventFinish()
	if not self._unlockEventList or #self._unlockEventList == 0 then
		return
	end

	for i, v in ipairs(self._unlockEventList) do
		if CommandStationModel.instance:eventIsActivated(v) then
			local eventId = self._eventList[self._curIndex]

			self:_initEventList(eventId)
			self:_updateBtnState()

			return
		end
	end
end

function CommandStationDispatchEventMainView:_onClickDispatch()
	self:_openTabView(CommandStationEnum.DispatchTabView.Process)
end

function CommandStationDispatchEventMainView:_onDispatchFinish()
	self:_openTabView(CommandStationEnum.DispatchTabView.Normal)
end

function CommandStationDispatchEventMainView:_onDispatchStart()
	self:_updateBtnState()
end

function CommandStationDispatchEventMainView:_openTabView(tabViewId)
	if self._curTabViewId then
		local isChangeTab = self._curTabViewId ~= tabViewId

		self.viewContainer:switchTab(tabViewId, self._curEventConfig)

		self._curTabViewId = tabViewId

		CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchChangeTab, isChangeTab, self._toLeft)
		self:_updateBtnState()
	end
end

function CommandStationDispatchEventMainView:onOpen()
	self._timeId = self.viewParam.timeId

	local eventId = self.viewParam.eventId

	self.viewParam.defaultTabIds = {}
	self._paramEventId = eventId

	self:_initEventList(eventId)
	self:_updateEventInfo()
end

function CommandStationDispatchEventMainView:_initEventList(eventId)
	self._eventList, self._unlockEventList = self:_getEventList()
	self._minIndex = 1
	self._maxIndex = #self._eventList
	self._curIndex = tabletool.indexOf(self._eventList, eventId)
end

function CommandStationDispatchEventMainView:_getEventList()
	local list = CommandStationConfig.instance:getEventList(self._timeId, self._paramEventId)
	local result = {}
	local unlockList = {}

	for i, eventId in ipairs(list) do
		if CommandStationModel.instance:eventIsActivated(eventId) then
			table.insert(result, eventId)
		else
			table.insert(unlockList, eventId)
		end
	end

	return result, unlockList
end

function CommandStationDispatchEventMainView:onClose()
	return
end

function CommandStationDispatchEventMainView:onDestroyView()
	return
end

return CommandStationDispatchEventMainView
