-- chunkname: @modules/logic/commandstation/view/CommandStationCharacterEventView.lua

module("modules.logic.commandstation.view.CommandStationCharacterEventView", package.seeall)

local CommandStationCharacterEventView = class("CommandStationCharacterEventView", BaseView)

function CommandStationCharacterEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goCharacterEvent = gohelper.findChild(self.viewGO, "#go_CharacterEvent")
	self._goCharacterEventPanel = gohelper.findChild(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel")
	self._goCharacter3 = gohelper.findChild(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#go_Character3")
	self._goCharacter2 = gohelper.findChild(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#go_Character2")
	self._goCharacter1 = gohelper.findChild(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#go_Character1")
	self._btnopentimeline = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_opentimeline")
	self._btnLeftDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_LeftDisable")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Left")
	self._btnRightDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_RightDisable")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Right")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._btnchangecharacter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Change")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationCharacterEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnopentimeline:AddClickListener(self._btnopentimelineOnClick, self)
	self._btnLeftDisable:AddClickListener(self._btnLeftDisableOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRightDisable:AddClickListener(self._btnRightDisableOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnchangecharacter:AddClickListener(self._btnchangecharacterOnClick, self)
end

function CommandStationCharacterEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnopentimeline:RemoveClickListener()
	self._btnLeftDisable:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRightDisable:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnchangecharacter:RemoveClickListener()
end

function CommandStationCharacterEventView:_btnchangecharacterOnClick()
	local eventId = self._eventList[self._curIndex]
	local eventConfig = lua_copost_character_event.configDict[eventId]

	self._chaIndex = self._chaIndex + 1

	if self._chaIndex > #eventConfig.chasId then
		self._chaIndex = 1
	end

	self._changeTimelineAfterChangeCharacter = self._isOpenTimeline

	self:_showSwitchChaAnim(false)
end

function CommandStationCharacterEventView:_showSwitchChaAnim(isLeft)
	self._animator.enabled = true

	self._animator:Play("change_num" .. #self._eventConfig.chasId, 0, 0)
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)

	local time = 0.167

	UIBlockHelper.instance:startBlock("CommandStationCharacterEventView_SwitchAnim", time)
	TaskDispatcher.runDelay(self._afterSwitchUpdateEventInfo, self, time)
	AudioMgr.instance:trigger(AudioEnum3_3.CommandStationMap.play_ui_yuanzheng_zhb_zhi)
end

function CommandStationCharacterEventView:_btnLeftDisableOnClick()
	return
end

function CommandStationCharacterEventView:_btnRightDisableOnClick()
	return
end

function CommandStationCharacterEventView:_btnopentimelineOnClick()
	if self._isOpenTimeline then
		return
	end

	self._isOpenTimeline = not self._isOpenTimeline

	self:_openTimeline()
	CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("btnopentimelineOnClick_%s", self._curCharacterId))
end

function CommandStationCharacterEventView:_openTimeline()
	self:_moveTimeline(self._isOpenTimeline and {
		node = self.viewGO,
		leftopNode = self._golefttop
	} or nil)
end

function CommandStationCharacterEventView:_moveTimeline(param)
	local isTimelineCharacterMode = param ~= nil

	if isTimelineCharacterMode then
		CommandStationMapModel.instance:setCharacterId(self._curCharacterId)
	else
		CommandStationMapModel.instance:setCharacterId(nil)
	end

	CommandStationMapModel.instance:setTimelineCharacterMode(isTimelineCharacterMode)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveTimeline, param)
	gohelper.setActive(self._btnclose, isTimelineCharacterMode)
	self:_updateBtnState()
end

function CommandStationCharacterEventView:checkClose()
	self:closeThis()
end

function CommandStationCharacterEventView:_btncloseOnClick()
	self:checkClose()
end

function CommandStationCharacterEventView:_btnLeftOnClick()
	self._curIndex = self._curIndex - 1

	if self._curIndex < 1 then
		self._curIndex = #self._eventList
	end

	self:_updateEventData()
	self:_changeEvent()
	self:_updateBtnState()
	self:_FocusEvent()
	self:_showSwitchAnim(true)
end

function CommandStationCharacterEventView:_btnRightOnClick()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._eventList then
		self._curIndex = 1
	end

	self:_updateEventData()
	self:_changeEvent()
	self:_updateBtnState()
	self:_FocusEvent()
	self:_showSwitchAnim(false)
end

function CommandStationCharacterEventView:_changeEvent()
	self._chaIndex = 1
end

function CommandStationCharacterEventView:_updateSwitchCharacterBtn()
	gohelper.setActive(self._btnchangecharacter, #self._eventConfig.chasId > 0)
end

function CommandStationCharacterEventView:_editableInitView()
	gohelper.setActive(self._btnclose, false)

	self._isOpenTimeline = false
	self._animator = self.viewGO:GetComponent("Animator")

	self:_initCharacterGos()
end

function CommandStationCharacterEventView:_initCharacterGos()
	self._characterGoList = self:getUserDataTb_()

	for i = 1, 3 do
		local go = self["_goCharacter" .. i]
		local txt_Time = gohelper.findChildText(go, "txt_Time")
		local txt_Name = gohelper.findChildText(go, "txt_Name")
		local txt_Descr = gohelper.findChildText(go, "Scroll View/Viewport/txt_Descr")
		local image_Icon = gohelper.findChildSingleImage(go, "Head/image_Icon")
		local t = self:getUserDataTb_()

		t.txt_Time = txt_Time
		t.txt_Name = txt_Name
		t.txt_Descr = txt_Descr
		t.image_Icon = image_Icon
		t.go = go

		gohelper.setActive(t.go, false)

		self._characterGoList[i] = t

		if i == 2 then
			self._clickRole = SLFramework.UGUI.UIClickListener.Get(t.image_Icon.gameObject)

			self._clickRole:AddClickListener(self._clickRoleHandler, self)
		end
	end
end

function CommandStationCharacterEventView:_clickRoleHandler()
	self:_btnchangecharacterOnClick()
end

function CommandStationCharacterEventView:_showSwitchAnim(isLeft)
	self._animator.enabled = true

	self._animator:Play(isLeft and "switchleft" or "switchright", 0, 0)
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)

	local time = 0.167

	UIBlockHelper.instance:startBlock("CommandStationCharacterEventView_SwitchAnim", time)
	TaskDispatcher.runDelay(self._afterSwitchUpdateEventInfo, self, time)

	if #self._eventConfig.chasId > 0 then
		AudioMgr.instance:trigger(AudioEnum3_3.CommandStationMap.play_ui_yuanzheng_zhb_zhi)
	end
end

function CommandStationCharacterEventView:_afterSwitchUpdateEventInfo()
	self:_updateEventInfo()

	if self._changeTimelineAfterChangeCharacter then
		self._changeTimelineAfterChangeCharacter = false

		self:_openTimeline()
	end
end

function CommandStationCharacterEventView:onUpdateParam()
	local eventId = self._eventList[self._curIndex]

	if eventId == self.viewParam.eventId then
		return
	end

	self._animator.enabled = true

	self._animator:Play("switchtime", 0, 0)
	TaskDispatcher.cancelTask(self._showEvent, self)
	TaskDispatcher.runDelay(self._showEvent, self, 0.167)
end

function CommandStationCharacterEventView:onOpen()
	self:_showEvent()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.SelectTimePoint, self._onSelectTimePoint, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.EventCreateFinish, self._onEventCreateFinish, self)
end

function CommandStationCharacterEventView:_onEventCreateFinish()
	return
end

function CommandStationCharacterEventView:_onSelectTimePoint(timeId)
	if self._timeId == timeId then
		return
	end

	self._timeId = timeId
	self._eventList = CommandStationConfig.instance:getCharacterEventList(self._timeId)

	local isMatch = false

	for i, v in ipairs(self._eventList) do
		if CommandStationConfig.instance:eventContainCharacterId(v, self._curCharacterId) then
			self._eventId = v
			isMatch = true

			break
		end
	end

	if not isMatch then
		logError(string.format("CommandStationCharacterEventView _onSelectTimePoint not match timeId:%d, characterId:%d, eventId:%d", self._timeId, self._curCharacterId, self._eventId))
	end

	self:_initEventData(true)
	self:_FocusEvent()

	if #self._eventConfig.chasId > 0 then
		self._chaIndex = tabletool.indexOf(self._eventConfig.chasId, self._curCharacterId)
	end

	self:_showSwitchAnim(false)
end

function CommandStationCharacterEventView:_showEvent()
	self._timeId = self.viewParam.timeId
	self._eventId = self.viewParam.eventId
	self._chaIndex = self.viewParam.chaIndex or 1
	self._eventList = CommandStationConfig.instance:getCharacterEventList(self._timeId)

	self:_initEventData()
end

function CommandStationCharacterEventView:_initEventData(skipUpdateEventInfo)
	self._minIndex = 1
	self._maxIndex = #self._eventList
	self._curIndex = tabletool.indexOf(self._eventList, self._eventId)

	self:_updateEventData()

	if not skipUpdateEventInfo then
		self:_updateEventInfo()
	end

	self:_updateBtnState()
end

function CommandStationCharacterEventView:_updateEventData()
	local eventId = self._eventList[self._curIndex]

	self._eventConfig = lua_copost_character_event.configDict[eventId]

	self:_updateSwitchCharacterBtn()
end

function CommandStationCharacterEventView:_updateBtnState()
	local isTimelineCharacterMode = CommandStationMapModel.instance:isTimelineCharacterMode()
	local showButton = self._maxIndex ~= 1 and not isTimelineCharacterMode

	gohelper.setActive(self._btnLeft.gameObject, showButton)
	gohelper.setActive(self._btnRight.gameObject, showButton)
	gohelper.setActive(self._btnLeftDisable.gameObject, false)
	gohelper.setActive(self._btnRightDisable.gameObject, false)
end

function CommandStationCharacterEventView:_FocusEvent()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationCharacterEventView:_getCharacterId()
	if #self._eventConfig.chasId > 0 then
		return self._eventConfig.chasId[self._chaIndex] or self._eventConfig.chasId[1]
	end

	return self._eventConfig.chaId
end

function CommandStationCharacterEventView:_getCharIdList()
	self._charIdList = self._charIdList or {}

	tabletool.clear(self._charIdList)

	self._changeCharIdList = self._changeCharIdList or {}

	tabletool.clear(self._changeCharIdList)

	if #self._eventConfig.chasId > 0 then
		if not self._chaIndex then
			local chaIndex = 1

			for i = chaIndex, #self._eventConfig.chasId do
				table.insert(self._charIdList, self._eventConfig.chasId[i])
				table.insert(self._changeCharIdList, self._eventConfig.changeChasId[i])
			end

			for i = 1, chaIndex - 1 do
				table.insert(self._charIdList, self._eventConfig.chasId[i])
				table.insert(self._changeCharIdList, self._eventConfig.changeChasId[i])
			end
		end
	else
		table.insert(self._charIdList, self._eventConfig.chaId)
		table.insert(self._changeCharIdList, self._eventConfig.changeChaId)
	end

	return self._charIdList, self._changeCharIdList
end

function CommandStationCharacterEventView:_updateEventInfo()
	local charIdList, changeCharIdList = self:_getCharIdList()

	for i, v in ipairs(self._characterGoList) do
		local charId = charIdList[i]

		gohelper.setActive(v.go, charId ~= nil)

		if charId then
			if i == 1 then
				self._curCharacterId = charId
			end

			self:_updateOneCharInfo(v, charId, changeCharIdList[i])
		end
	end
end

function CommandStationCharacterEventView:_updateOneCharInfo(viewInfo, characterId, changeCharId)
	local showCharId = changeCharId and changeCharId > 0 and changeCharId or characterId
	local eventId = self._eventConfig.id
	local eventTextId = tonumber(self._eventConfig.eventTextId)
	local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

	viewInfo.txt_Descr.text = eventTxtConfig and eventTxtConfig.text

	local characterConfig = lua_copost_character.configDict[showCharId]

	viewInfo.txt_Name.text = characterConfig.chaName

	local timeGroup = CommandStationConfig.instance:getTimeGroupByCharacterEventId(eventId)

	if timeGroup then
		local timeConfig = lua_copost_time_point.configDict[timeGroup.id]

		viewInfo.txt_Time.text = timeConfig and timeConfig.time
	end

	if characterConfig then
		viewInfo.image_Icon:LoadImage(ResUrl.getHeadIconSmall(characterConfig.chaPicture), function()
			viewInfo.image_Icon:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end
end

function CommandStationCharacterEventView:onClose()
	CommandStationMapModel.instance:setCharacterId(nil)
	CommandStationMapModel.instance:setTimelineCharacterMode(nil)
	self:_moveTimeline()
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
	TaskDispatcher.cancelTask(self._showEvent, self)

	if self._clickRole then
		self._clickRole:RemoveClickListener()
	end
end

function CommandStationCharacterEventView:onDestroyView()
	return
end

return CommandStationCharacterEventView
