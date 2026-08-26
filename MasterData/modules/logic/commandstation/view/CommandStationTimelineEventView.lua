-- chunkname: @modules/logic/commandstation/view/CommandStationTimelineEventView.lua

module("modules.logic.commandstation.view.CommandStationTimelineEventView", package.seeall)

local CommandStationTimelineEventView = class("CommandStationTimelineEventView", BaseView)

function CommandStationTimelineEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goTimeAxis = gohelper.findChild(self.viewGO, "#go_TimeAxis")
	self._goTimeAxisEvent = gohelper.findChild(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/Scroll View/Viewport/#txt_Descr")
	self._btnLeftDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_LeftDisable")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_Left")
	self._btnRightDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_RightDisable")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_Right")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationTimelineEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnLeftDisable:AddClickListener(self._btnLeftDisableOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRightDisable:AddClickListener(self._btnRightDisableOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CommandStationTimelineEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnLeftDisable:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRightDisable:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CommandStationTimelineEventView:_btnLeftDisableOnClick()
	return
end

function CommandStationTimelineEventView:_btnRightDisableOnClick()
	return
end

function CommandStationTimelineEventView:_btncloseOnClick()
	self:closeThis()
end

function CommandStationTimelineEventView:_btnLeftOnClick()
	self._curIndex = self._curIndex - 1

	if self._curIndex < 1 then
		self._curIndex = #self._eventList
	end

	self:_FocusEvent()
	self:_updateEventInfo()
	self:_updateBtnState()
end

function CommandStationTimelineEventView:_btnRightOnClick()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._eventList then
		self._curIndex = 1
	end

	self:_FocusEvent()
	self:_updateEventInfo()
	self:_updateBtnState()
end

function CommandStationTimelineEventView:_FocusEvent()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationTimelineEventView:_editableInitView()
	return
end

function CommandStationTimelineEventView:onUpdateParam()
	return
end

function CommandStationTimelineEventView:onOpen()
	self._timeId = self.viewParam.timeId
	self._eventId = self.viewParam.eventId
	self._eventList = CommandStationConfig.instance:getEventList(self._timeId, self._eventId)
	self._minIndex = 1
	self._maxIndex = #self._eventList
	self._curIndex = tabletool.indexOf(self._eventList, self._eventId)

	self:_updateEventInfo()
	self:_updateBtnState()
end

function CommandStationTimelineEventView:_updateBtnState()
	local showButton = self._maxIndex ~= 1

	gohelper.setActive(self._btnLeft.gameObject, showButton)
	gohelper.setActive(self._btnRight.gameObject, showButton)
	gohelper.setActive(self._btnLeftDisable.gameObject, false)
	gohelper.setActive(self._btnRightDisable.gameObject, false)
end

function CommandStationTimelineEventView:_updateEventInfo()
	local eventId = self._eventList[self._curIndex]
	local eventConfig = lua_copost_event.configDict[eventId]

	if not eventConfig then
		return
	end

	local eventTextId = tonumber(eventConfig.eventTextId)
	local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

	self._txtDescr.text = eventTxtConfig and eventTxtConfig.text
	self._txtTitle.text = eventConfig.eventTitleId
end

function CommandStationTimelineEventView:onClose()
	return
end

function CommandStationTimelineEventView:onDestroyView()
	return
end

return CommandStationTimelineEventView
