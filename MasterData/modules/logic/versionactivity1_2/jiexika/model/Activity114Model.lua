-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114Model.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114Model", package.seeall)

local Activity114Model = class("Activity114Model", BaseModel)
local eventToFlow = {
	[Activity114Enum.EventType.Edu] = Activity114EduFlow,
	[Activity114Enum.EventType.Rest] = Activity114RestFlow,
	[Activity114Enum.EventType.Meet] = Activity114MeetingFlow,
	[Activity114Enum.EventType.Travel] = Activity114TravelFlow,
	[Activity114Enum.EventType.KeyDay] = Activity114KeyDayFlow
}

function Activity114Model:onInit()
	self.eduSelectAttr = nil
	self.id = 0
	self._isEnd = true
	self.serverData = nil
	self.unLockMeetingDict = {}
	self.unLockTravelDict = {}
	self.attrDict = {}
	self.featuresDict = {}
	self.unLockEventDict = {}
	self.unLockPhotoDict = {}
	self.changeEventList = {}
	self.newPhotos = {}
	self.newUnLockTravel = {}
	self.newUnLockMeeting = {}
	self.newUnLockFeature = {}
	self.attrChangeDict = nil
	self.waitStoryFinish = false
	self.preServerData = nil
	self._nextWeekInfo = nil
	self._flow = nil
	self._storyFlow = nil
	self.attrAddPermillage = {}

	for i = 1, Activity114Enum.Attr.End - 1 do
		self.attrAddPermillage[i] = 0
	end

	self.attentionAddPermillage = 0
	self.saveUnLockData = nil
	self.saveUnLockUserData = nil
	self.preEventType = nil
	self.preResult = nil
	self._statData = nil
	self.playedEduSuccessStory = nil
end

function Activity114Model:clearFlow()
	if self._flow then
		self._flow:onDestroyInternal()
	end

	if self._storyFlow then
		self._storyFlow:onDestroyInternal()
	end
end

function Activity114Model:reInit()
	self:onInit()
end

function Activity114Model:beginStoryFlow()
	if self._storyFlow then
		return
	end

	self._storyFlow = Activity114RoundBeginFlow.New()

	self._storyFlow:registerDoneListener(self.onStoryFlowDone, self)

	if not self._storyFlow:beginFlow() then
		self._storyFlow = nil
	end
end

function Activity114Model:onStoryFlowDone(isDone)
	self._storyFlow = nil

	if isDone then
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function Activity114Model:have114StoryFlow()
	return not not self._storyFlow
end

function Activity114Model:beginEvent(context)
	if self._flow then
		self._flow:onDestroy()
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	self._flow = eventToFlow[context.type].New()

	self._flow:registerDoneListener(self.onFlowDone, self)
	self._flow:initParams(context)
	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessStart)
end

function Activity114Model:buildFlowAndSkipWork(context)
	if self._flow then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		ViewMgr.instance:openView(ViewName.Activity114EmptyView, nil, true)
	end

	self._flow = eventToFlow[context.type].New()

	self._flow:registerDoneListener(self.onFlowDone, self)
	self._flow:initParams(context, true)
end

function Activity114Model:setEventParams(key, value)
	if not self._flow then
		return
	end

	local context = self._flow:getContext()

	context[key] = value
end

function Activity114Model:getEventParams(key)
	if not self._flow then
		return
	end

	local context = self._flow:getContext()

	return context[key]
end

function Activity114Model:canFinishStory()
	if not self._flow then
		return true
	end

	return self._flow:canFinishStory()
end

function Activity114Model:onFlowDone()
	if not self._flow then
		return
	end

	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	self._flow:unregisterDoneListener(self.onFlowDone, self)

	self._flow = nil

	if self.newPhotos[1] then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		ViewMgr.instance:openView(ViewName.Activity114GetPhotoView)
	else
		self:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function Activity114Model:_onCloseViewFinish(viewName)
	if viewName == ViewName.Activity114GetPhotoView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:_checkHaveNextWeekInfo()
		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventProcessEnd)
	end
end

function Activity114Model:_checkHaveNextWeekInfo()
	if not self._nextWeekInfo then
		return
	end

	self:onGetInfo(self.id, self._nextWeekInfo)

	for eventId in pairs(self.changeEventList) do
		Activity114Controller.instance:dispatchEvent(eventId)
	end

	self.changeEventList = {}
	self._nextWeekInfo = nil
end

function Activity114Model:onGetInfo(id, info)
	if self.serverData and self.serverData.week ~= info.week and self._flow then
		self._nextWeekInfo = info

		return
	end

	local isWeekChange = false

	if not self.serverData then
		self.changeEventList[Activity114Event.OnAttentionUpdate] = true
		self.changeEventList[Activity114Event.OnCGUpdate] = true
		self.changeEventList[Activity114Event.OnAttrUpdate] = true
		self.changeEventList[Activity114Event.OnRoundUpdate] = true
		self.changeEventList[Activity114Event.OnNewFeature] = true
	else
		if info.week ~= self.serverData.week then
			self.playedEduSuccessStory = nil

			self:endStat(true)

			isWeekChange = true
		end

		if info.day ~= self.serverData.day or info.round ~= self.serverData.round or info.week ~= self.serverData.week then
			self.changeEventList[Activity114Event.OnRoundUpdate] = true
		end

		if #info.photos ~= #self.serverData.photos then
			for i = 1, #info.photos do
				if not self.unLockPhotoDict[info.photos[i]] then
					table.insert(self.newPhotos, info.photos[i])
				end
			end

			self.changeEventList[Activity114Event.OnCGUpdate] = true
		end

		local meetingIds, travelIds = Activity114Config.instance:getUnlockIds(id)

		if #info.meetings ~= #self.serverData.meetings then
			for i = 1, #info.meetings do
				local meetingId = info.meetings[i].meetingId

				if meetingIds[meetingId] and not self.unLockMeetingDict[meetingId] then
					table.insert(self.newUnLockMeeting, meetingId)
				end
			end
		end

		if #info.travels ~= #self.serverData.travels then
			for i = 1, #info.travels do
				local travelId = info.travels[i].travelId

				if not self.unLockTravelDict[travelId] and travelIds[travelId] then
					table.insert(self.newUnLockTravel, travelId)
				end
			end
		end

		if #info.features ~= #self.serverData.features then
			self.changeEventList[Activity114Event.OnNewFeature] = true

			for i = 1, #info.features do
				local feature = info.features[i]

				if not self.featuresDict[feature] then
					table.insert(self.newUnLockFeature, feature)
				end
			end
		end

		if info.attention ~= self.serverData.attention then
			self.changeEventList[Activity114Event.OnAttentionUpdate] = true
		end

		for i = 1, Activity114Enum.Attr.End - 1 do
			if info.attrs[i].value ~= self.serverData.attrs[i].value then
				self.changeEventList[Activity114Event.OnAttrUpdate] = true

				break
			end
		end
	end

	self.id = id
	self.serverData = info
	self._isEnd = false

	self:onMeetingChange(info.meetings)
	self:onTravelChange(info.travels)
	self:onAttrChange(info.attrs)
	self:onFeatureChange(info.features)
	self:onUnLockEventChange(info.unlockEventIds)
	self:onUnLockPhotoChange(info.photos)

	if isDebugBuild and not self._flow then
		TaskDispatcher.runDelay(function()
			if not self._flow then
				for eventId in pairs(self.changeEventList) do
					Activity114Controller.instance:dispatchEvent(eventId)
				end

				self.changeEventList = {}
			end
		end, nil, 0)
	end

	if isWeekChange then
		self:beginStat()
	end
end

function Activity114Model:onAttrChange(attrList)
	self.attrDict = {}

	for _, v in ipairs(attrList) do
		self.attrDict[v.attrId] = v.value
	end

	for i = 1, Activity114Enum.Attr.End - 1 do
		self.attrDict[i] = self.attrDict[i] or 0
	end
end

function Activity114Model:onFeatureChange(features)
	local attrAdd = {}
	local attentionAdd = 0

	self.featuresDict = {}

	for _, v in ipairs(features) do
		self.featuresDict[v] = true

		local featureCo = Activity114Config.instance:getFeatureCo(self.id, v)

		if featureCo then
			if featureCo.restEfficiency > 0 then
				attentionAdd = attentionAdd + featureCo.restEfficiency / 1000
			end

			if not string.nilorempty(featureCo.courseEfficiency) then
				local dayList = GameUtil.splitString2(featureCo.courseEfficiency, true, "|", "#")

				for _, data in ipairs(dayList) do
					attrAdd[data[1]] = (attrAdd[data[1]] or 0) + data[2] / 1000
				end
			end
		end
	end

	for k, v in pairs(self.attrAddPermillage) do
		self.attrAddPermillage[k] = attrAdd[k] or 0
	end

	self.attentionAddPermillage = attentionAdd
end

function Activity114Model:onUnLockEventChange(eventList)
	self.unLockEventDict = {}

	for _, v in ipairs(eventList) do
		self.unLockEventDict[v] = true
	end
end

function Activity114Model:onUnLockPhotoChange(photos)
	self.unLockPhotoDict = {}

	for _, v in ipairs(photos) do
		self.unLockPhotoDict[v] = true
	end
end

function Activity114Model:onMeetingChange(meetingList)
	self.unLockMeetingDict = {}

	for _, v in ipairs(meetingList) do
		self.unLockMeetingDict[v.meetingId] = v
	end
end

function Activity114Model:onTravelChange(travelList)
	self.unLockTravelDict = {}

	for _, v in ipairs(travelList) do
		self.unLockTravelDict[v.travelId] = v
	end
end

function Activity114Model:haveUnLockMeeting()
	for _, v in pairs(self.unLockMeetingDict) do
		if not self:getIsPlayUnLock(Activity114Enum.EventType.Meet, v.meetingId) then
			return true
		end
	end

	return false
end

function Activity114Model:haveUnLockTravel()
	for _, v in pairs(self.unLockTravelDict) do
		if not self:getIsPlayUnLock(Activity114Enum.EventType.Travel, v.travelId) then
			return true
		end
	end

	return false
end

function Activity114Model:getIsPlayUnLock(type, id)
	if not self.saveUnLockData then
		local playerId = tostring(PlayerModel.instance:getMyUserId())
		local str = PlayerPrefsHelper.getString(PlayerPrefsKey.JieXiKaUnLock, "")

		if not string.nilorempty(str) then
			self.saveUnLockData = cjson.decode(str)
			self.saveUnLockUserData = self.saveUnLockData[playerId]

			if self.saveUnLockData.activityId ~= self.id then
				self.saveUnLockData = nil
				self.saveUnLockUserData = nil
			end
		end

		if not self.saveUnLockData then
			self.saveUnLockData = {}
			self.saveUnLockData.activityId = self.id
		end

		if not self.saveUnLockUserData then
			self.saveUnLockUserData = {}
			self.saveUnLockData[playerId] = self.saveUnLockUserData
		end
	end

	if not self.saveUnLockUserData[type] or self.saveUnLockUserData[type] == cjson.null then
		return false
	end

	return self.saveUnLockUserData[type][id] == 1
end

function Activity114Model:setIsPlayUnLock(type, id)
	if self:getIsPlayUnLock(type, id) then
		return
	end

	if not self.saveUnLockUserData[type] or self.saveUnLockUserData[type] == cjson.null then
		self.saveUnLockUserData[type] = {}
	end

	self.saveUnLockUserData[type][id] = 1

	PlayerPrefsHelper.setString(PlayerPrefsKey.JieXiKaUnLock, cjson.encode(self.saveUnLockData))
	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
end

function Activity114Model:setEnd()
	self._isEnd = true

	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	if self._storyFlow then
		self._storyFlow:destroy()

		self._storyFlow = nil
	end
end

function Activity114Model:isEnd()
	return self._isEnd
end

function Activity114Model:beginStat()
	self._statData = {}
	self._statData.time = ServerTime.now()
	self._statData.beginRound = Activity114Config.instance:getRoundCount(self.id, self.serverData.day, self.serverData.round)
end

function Activity114Model:setResetRound()
	if not self._statData then
		return
	end

	self._statData.resetRound = Activity114Config.instance:getRoundCount(self.id, self.serverData.day, self.serverData.round)
end

function Activity114Model:endStat(isWeekEnd, isReset)
	if not self._statData then
		return
	end

	local result = "中断"

	if isWeekEnd then
		local _, _, _, totalScore = Activity114Helper.getWeekEndScore()

		result = totalScore >= Activity114Config.instance:getConstValue(self.id, Activity114Enum.ConstId.ScoreA) and "A" or totalScore >= Activity114Config.instance:getConstValue(self.id, Activity114Enum.ConstId.ScoreB) and "B" or totalScore >= Activity114Config.instance:getConstValue(self.id, Activity114Enum.ConstId.ScoreC) and "C" or "E"
	end

	local allPhotos = {}

	for i = 1, #self.serverData.photos do
		allPhotos[i] = self.serverData.photos[i]
	end

	local nowRound = Activity114Config.instance:getRoundCount(self.id, self.serverData.day, self.serverData.round)
	local increment = math.max(0, nowRound - self._statData.beginRound)

	if isReset then
		increment = 0
		nowRound = self._statData.resetRound or nowRound
	end

	StatController.instance:track(StatEnum.EventName.Act114Exit, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self._statData.time,
		[StatEnum.EventProperties.Act114Week] = self.serverData.week,
		[StatEnum.EventProperties.RoundNum] = nowRound,
		[StatEnum.EventProperties.IncrementRoundNum] = increment,
		[StatEnum.EventProperties.Act114AllPhoto] = allPhotos,
		[StatEnum.EventProperties.Result] = (isReset or nil) and "重置"
	})
end

Activity114Model.instance = Activity114Model.New()

return Activity114Model
