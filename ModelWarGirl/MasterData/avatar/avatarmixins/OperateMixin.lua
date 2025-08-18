-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OperateMixin.lua

local VersionUtils = require("System/VersionUtils")
local WebView = require("SDK/Plugin/WebView")
local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = require("SDK/ChannelUtil")
local LuaToolkit = Framework.Tools.LuaToolkit
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local OperateMixin = {}

function OperateMixin:initOperateMixin()
	self._questionEventData = {}

	local checkDelay = 3

	if LuaToolkit.IsEditor() then
		checkDelay = 10
	end

	self._delayCheckTimer = Timer(Slot(self.checkSurveyReward, self), checkDelay, -1)
	self._slotWebViewClose = Slot(self._onWebViewClose, self)
end

local EVENTTYPE_QUESTIONNAIRE = 1
local EVENTTYPE_ADVERTISE = 2

function OperateMixin:onOperateEventNotify(notify)
	for i, operateEventData in ipairs(notify) do
		local eventType = operateEventData.type
		local eventID = operateEventData.id
		local eventParam = operateEventData.param

		if eventType == EVENTTYPE_QUESTIONNAIRE then
			self._questionEventData[eventID] = eventParam
		end
	end

	self:refreshSurveyData()
end

function OperateMixin:onOperateEventCompleteNotify(eventID)
	if self._questionEventData then
		self._questionEventData[eventID] = nil

		self:refreshSurveyData()
	end
end

function OperateMixin:getQuestionData()
	if self._questionEventData then
		local eventID, surveyID

		for id, _ in pairs(self._questionEventData) do
			if not eventID then
				eventID = id
			else
				eventID = math.max(eventID, id)
			end
		end

		if eventID ~= nil then
			surveyID = self._questionEventData[eventID]
		end

		return eventID, surveyID
	end
end

local UID_PREFIX = IS_PUBLISH_VERSION and "pub_" or "dev_"

function OperateMixin:openSurvey()
	local url = SvrListManager.getSurvey()

	if RegionUtils.isCurrentRegion(RegionConst.REGION_CN) then
		local eventID, surveyID = self.curOperateEventID, self.curSurveyID

		if eventID == nil or surveyID == nil then
			return
		end

		local uid = CurAvatar and CurAvatar.uid

		if uid == nil then
			return
		end

		local append = string.format("%s.html?platform=%s&uid=%s", surveyID, string.lower(DeviceHelper.runtimePlatform), UID_PREFIX .. uid)

		url:SetUrlAppend(append)

		url = url:Get()

		self:_onOpenSurvey(eventID, surveyID)
	elseif RegionUtils.isCurrentRegion(RegionConst.REGION_JP) or RegionUtils.isCurrentRegion(RegionConst.REGION_TW) then
		url = self:getSurveyUrl_JP()
	end

	SDKAgent.questionnaire(url, self._slotWebViewClose)
end

function OperateMixin:setSurveyUrl_JP(url)
	self.questionnaireUrl = url
end

function OperateMixin:getSurveyUrl_JP()
	return self.questionnaireUrl or ""
end

function OperateMixin:refreshSurveyData()
	self.curOperateEventID, self.curSurveyID = self:getQuestionData()

	local active = self.curSurveyID ~= nil

	RedDotManager.setKeyState(UIConst.RD_HINT_SURVEY, active)
end

function OperateMixin:checkSurveyReward()
	if not self._hasCheckdSurveyReward then
		self._hasCheckdSurveyReward = true

		RPC.surveyFinish()
	end

	self._delayCheckTimer:Stop()
end

function OperateMixin:_onOpenSurvey(eventID, surveyID)
	self._hasCheckdSurveyReward = false

	if LuaToolkit.IsEditor() then
		self._delayCheckTimer:Restart()
	end
end

function OperateMixin:_onWebViewClose()
	self._delayCheckTimer:Restart()
end

return OperateMixin
