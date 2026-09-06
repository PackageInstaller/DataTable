-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/config/NumberGameConfig.lua

module("logic.extensions.numberbomb.config.NumberGameConfig", package.seeall)

local NumberGameConfig = class("NumberGameConfig", BaseConfig)

function NumberGameConfig:onInit()
	NumberGameConfig.super.onInit(self)

	self._activityAllCfgs = nil
	self._progressAllCfgs = nil
	self._scoreAllCfgs = nil
	self._rankAllCfgs = nil
	self._settleAllCfgs = nil
	self._chatAllCfgs = nil
	self._commonInfo = nil
end

function NumberGameConfig:getNames()
	return {
		"number_game_activity",
		"number_game_progress_prize",
		"number_game_score_prize",
		"number_game_rank",
		"number_game_settle",
		"number_game_chat",
		"number_game_common"
	}
end

function NumberGameConfig:handleConfig(name, content)
	if name == "number_game_activity" then
		self._activityAllCfgs = content
	elseif name == "number_game_progress_prize" then
		self._progressAllCfgs = content
	elseif name == "number_game_score_prize" then
		self._scoreAllCfgs = content
	elseif name == "number_game_rank" then
		self._rankAllCfgs = content
	elseif name == "number_game_settle" then
		self._settleAllCfgs = content
	elseif name == "number_game_chat" then
		self._chatAllCfgs = content
	elseif name == "number_game_common" then
		self._commonInfo = {}

		if content.OPEN_TIME then
			self._commonInfo.openTimes = string.split(content.OPEN_TIME.value, ",")
		end

		if content.DAILY_COIN_ITEM_LIMIT then
			self._commonInfo.daibiMax = checknumber(content.DAILY_COIN_ITEM_LIMIT.value)
		end

		if content.MATCH_TIME then
			self._commonInfo.matchTime = checknumber(content.MATCH_TIME.value)
		end

		if content.OPERATE_TIME then
			self._commonInfo.operateTime = checknumber(content.OPERATE_TIME.value)
		end

		if content.CHAT_CD then
			self._commonInfo.chatCD = checknumber(content.CHAT_CD.value)
		end

		if content.BUBBLE_TIME then
			self._commonInfo.bubbleTime = checknumber(content.BUBBLE_TIME.value)
		end

		if content.INIT_NUMBER_RANGE then
			self._commonInfo.rangeNums = string.split(content.INIT_NUMBER_RANGE.value, ",")
		end

		if content.SHOP_ACTIVITYTYPE then
			self._commonInfo.actiType = checknumber(content.SHOP_ACTIVITYTYPE.value)
		end

		if content.OPEN_TIME_TIPS then
			self._commonInfo.opentimeTips = content.OPEN_TIME_TIPS.value
		end

		if content.SHOP_EXPLICIT_ID then
			self._commonInfo.explicitId = string.split(content.SHOP_EXPLICIT_ID.value, ":")
		end
	end
end

function NumberGameConfig:getActivityCfg(actiId)
	if self._activityAllCfgs == nil or self._activityAllCfgs[actiId] == nil then
		return
	end

	return self._activityAllCfgs[actiId]
end

function NumberGameConfig:getNumberProgressCfgs(actiId)
	if self._progressAllCfgs == nil or self._progressAllCfgs[actiId] == nil then
		return
	end

	return self._progressAllCfgs[actiId]
end

function NumberGameConfig:getScorePrizeCfg(planId, prizeId)
	planId = checknumber(planId)

	if self._scoreAllCfgs == nil or self._scoreAllCfgs[planId] == nil then
		return
	end

	local list = self._scoreAllCfgs[planId]

	prizeId = checknumber(prizeId)

	if prizeId <= 0 or list[prizeId] == nil then
		return list
	end

	return list[prizeId]
end

function NumberGameConfig:getAllRankCfgs(planId)
	planId = checknumber(planId)

	if self._rankAllCfgs == nil or self._rankAllCfgs[planId] == nil then
		return
	end

	return self._rankAllCfgs[planId]
end

function NumberGameConfig:getSettleCfg(noId)
	noId = checknumber(noId)

	if self._settleAllCfgs == nil or self._settleAllCfgs[noId] == nil then
		return
	end

	return self._settleAllCfgs[noId]
end

function NumberGameConfig:getAllChatCfgs()
	return self._chatAllCfgs or {}
end

function NumberGameConfig:getCommonInfo()
	return self._commonInfo or {}
end

function NumberGameConfig:getNumberShopsCfg()
	local actiId = self:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		return
	end

	local actiType = self._commonInfo.actiType

	if checknumber(actiType) <= 0 then
		actiType = 54
	end

	local allCfgs = ActivityshopConfig.instance:getActivityShopCfgWithPage(actiType, actiId)

	if allCfgs == nil or allCfgs[1] == nil then
		return
	end

	local name = ActivityshopConfig.instance:getActShopTitleName(actiType, actiId)
	local cfg = ActivityshopConfig.instance:getActivityShopPageCfg(actiType, actiId, 1)

	return allCfgs[1], cfg, name
end

function NumberGameConfig:getOpenActivityId()
	if self._activityAllCfgs == nil then
		return -1
	end

	self._commonInfo = self._commonInfo or {}

	local actiType = self._commonInfo.actiType

	if checknumber(actiType) <= 0 then
		actiType = 54
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(actiType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			self._commonInfo.lastActiId = item.activityId

			return item.activityId
		end
	end

	return -3
end

NumberGameConfig.instance = NumberGameConfig.New()

return NumberGameConfig
