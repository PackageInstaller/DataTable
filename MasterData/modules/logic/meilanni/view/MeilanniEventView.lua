-- chunkname: @modules/logic/meilanni/view/MeilanniEventView.lua

module("modules.logic.meilanni.view.MeilanniEventView", package.seeall)

local MeilanniEventView = class("MeilanniEventView", BaseView)

function MeilanniEventView:onInitView()
	self._goeventlist = gohelper.findChild(self.viewGO, "#go_eventlist")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniEventView:addEvents()
	return
end

function MeilanniEventView:removeEvents()
	return
end

function MeilanniEventView:_editableInitView()
	return
end

function MeilanniEventView:onUpdateParam()
	return
end

function MeilanniEventView:_episodeInfoUpdate()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local updateEpisode = episodeInfo ~= self._episodeInfo

	if updateEpisode then
		MeilanniAnimationController.instance:addDelayCall(self._updateElements, self, nil, MeilanniEnum.showElementTime, MeilanniAnimationController.showElementsLayer)
	else
		self:_updateElements()
	end
end

function MeilanniEventView:_updateElements()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local updateEpisode = episodeInfo ~= self._episodeInfo

	if episodeInfo.isFinish then
		self:_removeAllElements()

		return
	end

	if updateEpisode then
		self:_removeAllElements()
	end

	if not updateEpisode then
		self:_showElements(false)

		return
	end

	TaskDispatcher.cancelTask(self._delayShowElements, self)
	TaskDispatcher.runDelay(self._delayShowElements, self, 0.5)
end

function MeilanniEventView:_delayShowElements()
	self:_showElements(true)
end

function MeilanniEventView:_resetMap()
	self:_updateElements()
end

function MeilanniEventView:onOpen()
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, self._episodeInfoUpdate, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.setElementsVisible, self._setElementsVisible, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.getInfo, self._getInfo, self)

	self._mapId = self.viewParam.mapId
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)
	self._eventList = self:getUserDataTb_()

	self:_showElements(true)
end

function MeilanniEventView:_getInfo()
	if self._mapInfo.isFinish then
		self:_removeAllElements()
	end
end

function MeilanniEventView:mapIsFinish()
	if self._mapInfo.isFinish or self._mapInfo.score <= 0 then
		return true
	end
end

function MeilanniEventView:onOpenFinish()
	return
end

function MeilanniEventView:_openBattleElement()
	local id = MeilanniModel.instance:getBattleElementId()

	if not id then
		return
	end

	MeilanniModel.instance:setBattleElementId(nil)

	local eventItem = self._eventList[id]

	if not eventItem then
		return
	end

	local elementInfo = eventItem._info
	local type = elementInfo:getType()

	if type == MeilanniEnum.ElementType.Battle then
		return
	end

	eventItem:_onClick()
end

function MeilanniEventView:_removeAllElements()
	if not self._episodeInfo then
		return
	end

	for i, v in ipairs(self._episodeInfo.events) do
		self:_removeElement(v)
	end
end

function MeilanniEventView:_showElements(showAnim)
	if self:mapIsFinish() then
		return
	end

	local elementInProgress

	self._episodeInfo = self._mapInfo:getCurEpisodeInfo()

	for i, v in ipairs(self._episodeInfo.events) do
		if v.isFinish then
			self:_removeElement(v)
		else
			local eventItem = self:_addElement(v)

			if v.index > 0 then
				elementInProgress = eventItem
			end
		end
	end

	for eventId, v in pairs(self._eventList) do
		if not self._episodeInfo:getEventInfo(eventId) then
			self:_removeElementById(eventId)
		end
	end

	if elementInProgress then
		for k, v in pairs(self._eventList) do
			if v ~= elementInProgress then
				gohelper.setActive(v.viewGO, false)
			end
		end
	end

	if showAnim then
		self:_elementFadeIn()
	end

	self:_checkActPointStatus()
end

function MeilanniEventView._oneElementFadeIn(params)
	local self, eventItem = params[1], params[2]

	if self._episodeInfo.isFinish and not self._episodeInfo.confirm then
		return
	end

	gohelper.setActive(eventItem.viewGO, true)
	eventItem:playAnim("appear")
	eventItem:setClickEnabled(false)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
end

function MeilanniEventView._oneElementFadeInFinish(params)
	local self = params[1]

	for i, eventItem in ipairs(self._fadeList) do
		eventItem:setClickEnabled(true)
	end

	self:_openBattleElement()
end

function MeilanniEventView:_elementFadeIn()
	local list = self:getUserDataTb_()

	for k, v in pairs(self._eventList) do
		if v.viewGO.activeSelf then
			gohelper.setActive(v.viewGO, false)
			table.insert(list, v)
		end
	end

	table.sort(list, MeilanniEventView._sort)
	self:_stopShowSequence()

	self._showSequence = FlowSequence.New()

	self._showSequence:addWork(TimerWork.New(0.5))

	for i, v in ipairs(list) do
		self._showSequence:addWork(FunctionWork.New(MeilanniEventView._oneElementFadeIn, {
			self,
			v
		}))

		if i ~= #list then
			self._showSequence:addWork(TimerWork.New(0.5))
		end
	end

	self._showSequence:addWork(TimerWork.New(0.8))
	self._showSequence:addWork(FunctionWork.New(MeilanniEventView._oneElementFadeInFinish, {
		self
	}))

	self._fadeList = list

	self._showSequence:registerDoneListener(self._stopShowSequence, self)
	self._showSequence:start()
end

function MeilanniEventView:_stopShowSequence()
	if self._showSequence then
		self._showSequence:destroy()

		self._showSequence = nil
	end
end

function MeilanniEventView._sort(a, b)
	return a._eventId < b._eventId
end

function MeilanniEventView:_addElement(eventInfo)
	local eventId = eventInfo.eventId
	local eventItem = self._eventList[eventId]

	if eventItem then
		eventItem:updateInfo(eventInfo)

		return eventItem
	end

	local itemPath = self.viewContainer:getSetting().otherRes[1]
	local itemGo = self:getResInst(itemPath, self._goeventlist, eventId)

	eventItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, MeilanniEventItem)
	self._eventList[eventId] = eventItem

	eventItem:updateInfo(eventInfo)

	return eventItem
end

function MeilanniEventView:_removeElement(eventInfo)
	local eventId = eventInfo.eventId

	self:_removeElementById(eventId)
end

function MeilanniEventView:_removeElementById(eventId)
	local eventItem = self._eventList[eventId]

	if not eventItem then
		return
	end

	self._eventList[eventId] = nil

	eventItem:dispose()
end

function MeilanniEventView:_setElementsVisible(show, eventItem)
	for k, v in pairs(self._eventList) do
		if v ~= eventItem then
			if not v.viewGO.activeSelf and show then
				gohelper.setActive(v.viewGO, true)
				v:playAnim("appear")
				v:setPhotoVisible(true)
			end

			if v:isSelected() then
				v:setSelected(false)
			else
				v:playAnim(show and "appear" or "disappear")
				v:setPhotoVisible(show)
			end
		end

		v:setClickEnabled(show)
	end
end

function MeilanniEventView:_checkActPointStatus()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local leftActPoint = episodeInfo.leftActPoint
	local normalNum = 0
	local specialNum = 0

	for k, v in pairs(self._eventList) do
		if v:isSpecialType() then
			specialNum = specialNum + 1
		else
			normalNum = normalNum + 1
		end
	end

	leftActPoint = leftActPoint - specialNum

	for k, v in pairs(self._eventList) do
		if not v:isSpecialType() then
			v:setGray(leftActPoint > 0)
		end
	end
end

function MeilanniEventView:onClose()
	self:_stopShowSequence()
	TaskDispatcher.cancelTask(self._delayShowElements, self)
end

function MeilanniEventView:onDestroyView()
	return
end

return MeilanniEventView
