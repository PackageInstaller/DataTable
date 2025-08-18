-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveMixin.lua

local ResAchieve = require("ClientData/ResAchieve")
local ClientAchieveMixin = require("Avatar/AvatarMixins/ClientAchieves/ClientAchieveMixin")
local AchieveUpperSystemMixin = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemMixin")
local EventConst = require("EventConst")
local AchieveMixin = {}

function AchieveMixin:initAchieveMixin(baseData, syncData)
	return
end

function AchieveMixin:postinitAchieveMixin(baseData, syncData)
	local serverAchieveData = syncData.other.achieve

	self:initAchieveData(serverAchieveData)
	self:initUpperSystemData(serverAchieveData)
end

function AchieveMixin:initCheckAchieveMixin()
	AchieveUpperSystemMixin:initCheckRedDot()
end

function AchieveMixin:destroyAchieveMixin()
	return
end

function AchieveMixin:initAchieveData(svrAchieveData)
	self.achieveProgressData = {}
	self.achieveAwardGot = {}
	self.achieveQualify = {}
	self.actionTypeDict = {}

	ClientAchieveMixin:initClientAchieveMixin(self.achieveProgressData, self.achieveAwardGot, self.achieveQualify)

	local progressList = svrAchieveData.progress

	for actionTypeId, progress in ipairs(progressList) do
		self.achieveProgressData[actionTypeId] = progress.value
	end

	local awardGotBytes = svrAchieveData.awarded.bits
	local bitsList = ClientUtils.getBitsListFromByteString(awardGotBytes)

	for i, achieveId in ipairs(bitsList) do
		self.achieveAwardGot[achieveId] = true
		self.achieveQualify[achieveId] = true
	end

	for achieveId, achieveInfo in pairs(ResAchieve) do
		local achieveType = achieveInfo.action_type
		local achieveValue = achieveInfo.action_param
		local achieveExtraValue = achieveInfo.extra_param

		if not self.actionTypeDict[achieveType] then
			self.actionTypeDict[achieveType] = {}
		end

		table.insert(self.actionTypeDict[achieveType], achieveId)

		if ClientAchieveMixin:isClientAcheve(achieveType) then
			ClientAchieveMixin:initChientAchieveData(achieveType, achieveId, achieveValue, achieveExtraValue)
		else
			self:_initServerAchieveData(achieveId, achieveType, achieveValue)
		end
	end

	for achieveId, isQualify in pairs(self.achieveQualify) do
		if isQualify and not self.achieveAwardGot[achieveId] then
			self:_autoGetWhenAchieveQualify(achieveId)
		end
	end

	self:refreshAchieveRelateRed()
end

function AchieveMixin:_initServerAchieveData(achieveId, achieveType, achieveParam)
	local actionProcess = self.achieveProgressData[achieveType] or 0
	local isQualify = achieveParam <= actionProcess

	self.achieveQualify[achieveId] = isQualify
end

function AchieveMixin:onAchieveActionProgressNotify(action, progress)
	self.achieveProgressData[action] = progress

	self:_achieveProgressTrigger(action)
end

function AchieveMixin:onAchieveQualifyNotify(achieve_id)
	self:_achieveQualifyTrigger(achieve_id)
end

function AchieveMixin:onAchieveGetAwardResp(achieve_id)
	self.lastGetAchieveAwardTick = nil
	self.achieveAwardGot[achieve_id] = true

	self:_achieveGotTrigger(achieve_id)
end

function AchieveMixin:refreshAchieveRelateRed()
	self:refreshRearHouseRed()
	self:refreshSecondRecharge()
	self:refreshFirstRechargePanel()
end

function AchieveMixin:_achieveQualifyTrigger(achieveId)
	if not self.achieveQualify[achieveId] then
		self:_showTipsWhenAchieveQualify(achieveId)
		self:_autoGetWhenAchieveQualify(achieveId)
		ConditionLimitManager.triggerAchieveUnlock(achieveId, Const.CONDITION_TASK_QUALIFY_UNLOCK)
	end

	self.achieveQualify[achieveId] = true

	self:onUpperSystemAchieveQualify(achieveId)
	self:checkPlotRewindRedHint()
	self:refreshAchieveRelateRed()
end

function AchieveMixin:_achieveGotTrigger(achieveId)
	ConditionLimitManager.triggerAchieveUnlock(achieveId, Const.CONDITION_TASK_GOT_UNLOCK)
	self:onUpperSystemAchieveGot(achieveId)
	self:refreshAchieveRelateRed()
	EventCenter.sendEvent(EventConst.ACHIEVE_GET_AWARD, achieveId)
end

function AchieveMixin:_achieveProgressTrigger(actionTypeId)
	local achieveList = self.actionTypeDict[actionTypeId]

	if achieveList then
		local achieveInfo, achieveParam, isQualify, actionProcess

		for i, achieveId in ipairs(achieveList) do
			achieveInfo = ResAchieve[achieveId]

			if achieveInfo then
				achieveParam = achieveInfo.action_param
				actionProcess = self.achieveProgressData[actionTypeId] or 0
				isQualify = achieveParam <= actionProcess

				if isQualify and not self.achieveQualify[achieveId] then
					self:_achieveQualifyTrigger(achieveId)
				else
					self:onUpperSystemAchieveProgressChange(achieveId)
				end
			end
		end
	end

	self:updateAdvanceTaskStatus(actionTypeId)
end

function AchieveMixin:_showTipsWhenAchieveQualify(achieveId)
	return
end

function AchieveMixin:_autoGetWhenAchieveQualify(achieveId)
	local achieveData = ResAchieve[achieveId]

	if achieveData and achieveData.auto_get then
		RPC.achieveGetAward(achieveId)
	end
end

function AchieveMixin:initUpperSystemData(svrAchieveData)
	AchieveUpperSystemMixin:initUpperSystemMixin(svrAchieveData)
end

function AchieveMixin:onUpperSystemAchieveQualify(achieveId)
	AchieveUpperSystemMixin:upperSystemAchieveQualify(achieveId)
end

function AchieveMixin:onUpperSystemAchieveGot(achieveId)
	AchieveUpperSystemMixin:upperSystemAchieveGot(achieveId)
end

function AchieveMixin:onUpperSystemAchieveProgressChange(achieveId)
	AchieveUpperSystemMixin:upperSystemAchieveProgressChange(achieveId)
end

function AchieveMixin:getUpperSystemData(upperSystemType)
	return AchieveUpperSystemMixin.upperSystemDict[upperSystemType]
end

function AchieveMixin:getAchieveList(upperSystemType)
	return AchieveUpperSystemMixin:getAchieveListByType(upperSystemType)
end

function AchieveMixin:getAchieveDict(upperSystemType)
	return AchieveUpperSystemMixin:getAchieveDictByType(upperSystemType)
end

function AchieveMixin:allAchieveGot(upperSystemType)
	local achieveDict = AchieveUpperSystemMixin:getAchieveDictByType(upperSystemType)

	if achieveDict then
		for achieveId, _ in pairs(achieveDict) do
			if not self.achieveAwardGot[achieveId] then
				return false
			end
		end

		return true
	else
		return true
	end
end

function AchieveMixin:getAchieveProcess(achieveId)
	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo then
		return 0, 1
	end

	local nowProcess, totalProcess
	local actionType = achieveInfo.action_type
	local needFixType = self:_achieveTypeNeedFix(actionType) or achieveInfo.special_show and achieveInfo.special_show == 1
	local isQualify = self.achieveQualify[achieveId] == true

	if needFixType then
		totalProcess = 1

		if isQualify then
			nowProcess = 1
		else
			nowProcess = 0
		end
	else
		totalProcess = achieveInfo.action_param

		if isQualify then
			nowProcess = totalProcess
		else
			nowProcess = self.achieveProgressData[actionType] or 0
		end

		local displayOffset = achieveInfo.display_offset

		if displayOffset and displayOffset > 0 then
			totalProcess = math.max(totalProcess - displayOffset, 0)
			nowProcess = math.max(nowProcess - displayOffset, 0)
		end
	end

	return nowProcess, totalProcess
end

function AchieveMixin:getAchieveStatus(achieveId)
	local isQualify = self.achieveQualify[achieveId]
	local isGot = self.achieveAwardGot[achieveId]

	if not isQualify then
		return Const.ACHIEVE_STATUS.IN_PROCESS
	elseif not isGot then
		return Const.ACHIEVE_STATUS.COMPLETE
	else
		return Const.ACHIEVE_STATUS.AWARD_GOT
	end
end

function AchieveMixin:_achieveTypeNeedFix(actionType)
	if actionType == Const.ACTION_TYPE_STAGE_NUM or actionType == Const.ACTION_TYPE_OPACT_TOWER_GREATEST_RANK or actionType == Const.ACTION_TYPE_WORLD_BOSS_GREATEST_RANK or actionType == Const.ACTION_TYPE_CLAN_BATTLE_GREATEST_RANK or actionType == Const.ACTION_TYPE_ARENA_TOP_LEAGUE_GREATEST_RANK then
		return true
	else
		return false
	end
end

local ACHIEVE_AWARD_CD = 5

function AchieveMixin:getAchieveAward(achieveId)
	if self.lastGetAchieveAwardTick ~= nil and Time.time - self.lastGetAchieveAwardTick < ACHIEVE_AWARD_CD then
		return
	end

	RPC.achieveGetAward(achieveId)

	self.lastGetAchieveAwardTick = Time.time
end

function AchieveMixin:getAchieveProcessByType(achieveType)
	local actionProcess = self.achieveProgressData[achieveType] or 0

	return actionProcess
end

function AchieveMixin:updateClientAchieveProgress(achieveType, progress)
	RPC.achieveProgressUpdateClient(achieveType, progress)
end

function AchieveMixin:isShareAchieve(achieveId)
	local achieveInfo = ResAchieve[achieveId]

	if achieveInfo then
		local achieveType = achieveInfo.action_type

		return achieveType == Const.ACHIEVE_TYPE_SHARE_STANDARDDRAW or achieveType == Const.ACHIEVE_TYPE_SHARE_LIGHTDRAW or achieveType == Const.ACHIEVE_TYPE_SHARE_NEWSKIN
	end

	return false
end

return AchieveMixin
