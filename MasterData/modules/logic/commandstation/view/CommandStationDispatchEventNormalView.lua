-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventNormalView.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventNormalView", package.seeall)

local CommandStationDispatchEventNormalView = class("CommandStationDispatchEventNormalView", BaseView)

function CommandStationDispatchEventNormalView:onInitView()
	self._goDispatchEvent = gohelper.findChild(self.viewGO, "#go_DispatchEvent")
	self._goDispatchDetail = gohelper.findChild(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail/Scroll View/Viewport/#txt_Descr")
	self._btnDispatch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#btn_Dispatch")
	self._btnHaveDispatch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail/#btn_HaveDispatch")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#go_DispatchEvent/#go_DispatchDetail/Role/#simage_hero")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDispatchEventNormalView:addEvents()
	self._btnDispatch:AddClickListener(self._btnDispatchOnClick, self)
	self._btnHaveDispatch:AddClickListener(self._btnHaveDispatchOnClick, self)
end

function CommandStationDispatchEventNormalView:removeEvents()
	self._btnDispatch:RemoveClickListener()
	self._btnHaveDispatch:RemoveClickListener()
end

function CommandStationDispatchEventNormalView:_btnDispatchOnClick()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ClickDispatch)
end

function CommandStationDispatchEventNormalView:_btnHaveDispatchOnClick()
	return
end

function CommandStationDispatchEventNormalView:_editableInitView()
	gohelper.setActive(self._btnHaveDispatch, false)

	self._animator = self.viewGO:GetComponent("Animator")
end

function CommandStationDispatchEventNormalView:onUpdateParam()
	return
end

function CommandStationDispatchEventNormalView:onOpen()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.DispatchChangeTab, self._onDispatchChangeTab, self)
end

function CommandStationDispatchEventNormalView:_onDispatchChangeTab(isChange, isToLeft)
	if self._isShow and not isChange and isToLeft ~= nil then
		if not self._oldEventConfig then
			return
		end

		self:_updateEventInfo(self._oldEventConfig)
		self._animator:Play(isToLeft and "switchleft" or "switchright", 0, 0)
		TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
		TaskDispatcher.runDelay(self._afterSwitchUpdateEventInfo, self, 0.167)
	end
end

function CommandStationDispatchEventNormalView:_afterSwitchUpdateEventInfo()
	self:_updateEventInfo(self._eventConfig)
end

function CommandStationDispatchEventNormalView:onTabSwitchOpen()
	if not self._isShow then
		self._animator:Play("open", 0, 0)
	end

	self._isShow = true
	self._oldEventConfig = self._eventConfig
	self._eventConfig = self.viewContainer:getCurrentEventConfig()

	self:_updateEventInfo(self._eventConfig)
end

function CommandStationDispatchEventNormalView:onTabSwitchClose()
	self._isShow = false
end

function CommandStationDispatchEventNormalView:_updateEventInfo(eventConfig)
	local textList = string.splitToNumber(eventConfig.eventTextId, "#")
	local eventId = eventConfig.id
	local eventInfo = CommandStationModel.instance:getDispatchEventInfo(eventId)
	local getRewarded = eventInfo and eventInfo:hasGetReward()

	gohelper.setActive(self._btnHaveDispatch, getRewarded)
	gohelper.setActive(self._btnDispatch, not getRewarded)

	if getRewarded then
		if not textList[2] then
			local eventTextId = textList[1]
			local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

			self._txtDescr.text = eventTxtConfig and eventTxtConfig.text
			self._txtTitle.text = eventConfig.eventTitleId

			self._simagehero:LoadImage(ResUrl.getHeadIconSmall(eventConfig.charaProfile))
		end
	end
end

function CommandStationDispatchEventNormalView:onClose()
	self._animator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
end

function CommandStationDispatchEventNormalView:onDestroyView()
	return
end

return CommandStationDispatchEventNormalView
