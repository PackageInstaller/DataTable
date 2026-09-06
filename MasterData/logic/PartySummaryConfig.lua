-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/config/PartySummaryConfig.lua

module("logic.extensions.partysummary.config.PartySummaryConfig", package.seeall)

local PartySummaryConfig = class("PartySummaryConfig", BaseConfig)

function PartySummaryConfig:onInit()
	PartySummaryConfig.super.onInit(self)

	self._foodActivityCfgs = nil
	self._foodTypeCfgs = nil
	self._foodTermCfgs = nil
	self._foodPrizeCfgs = nil
	self._foodNpcCfgs = nil
	self._giftPrizeCfgs = nil
end

function PartySummaryConfig:getNames()
	return {
		"potluck_dinner_activity",
		"potluck_dinner_food",
		"potluck_dinner_term",
		"potluck_dinner_food_prize",
		"potluck_dinner_npc",
		"party_gift",
		"party_gift_bg",
		"code_word",
		"code_word_group"
	}
end

function PartySummaryConfig:handleConfig(name, content)
	if name == "potluck_dinner_activity" then
		self._foodActivityCfgs = content
	elseif name == "potluck_dinner_food" then
		self._foodTypeCfgs = content
	elseif name == "potluck_dinner_term" then
		self._foodTermCfgs = content
	elseif name == "potluck_dinner_food_prize" then
		self._foodPrizeCfgs = content
	elseif name == "potluck_dinner_npc" then
		self._foodNpcCfgs = content
	elseif name == "party_gift" then
		self._giftPrizeCfgs = content
	elseif name == "party_gift_bg" then
		self._giftPrizeBgCfgs = content
	elseif name == "code_word" then
		self.code_word = content
	elseif name == "code_word_group" then
		self.code_word_group = content
	end
end

function PartySummaryConfig:getPartyFoodActivityId()
	return self:_getActivityIdByActivityType(GameEnum.ActivityType.PartyFood)
end

function PartySummaryConfig:getFoodActivityCfg(actId)
	actId = checknumber(actId)

	if self._foodActivityCfgs == nil or self._foodActivityCfgs[actId] == nil then
		return
	end

	return self._foodActivityCfgs[actId]
end

function PartySummaryConfig:getFoodTypeCfgs(actId, foodType)
	actId = checknumber(actId)

	if self._foodTypeCfgs == nil or self._foodTypeCfgs[actId] == nil then
		return
	end

	local list = self._foodTypeCfgs[actId]

	if foodType == nil or list[foodType] == nil then
		return list
	end

	return list[foodType]
end

function PartySummaryConfig:getFoodTermCfgs(actId, termId)
	actId = checknumber(actId)

	if self._foodTermCfgs == nil or self._foodTermCfgs[actId] == nil then
		return
	end

	local list = self._foodTermCfgs[actId]

	if termId == nil or list[termId] == nil then
		return list
	end

	return list[termId]
end

function PartySummaryConfig:_checkFoodTermStarEndTime(data)
	for _, cfg in pairs(data or {}) do
		if cfg and GameUtil.string2time(cfg.startTime) >= GameUtil.string2time(cfg.endTime) then
			printError(string.format("sr---派对食会   @@@@淇雯   结束时间小于开始时间        活动=%s, 轮次=%s, 开始时间=%s, 结束时间=%s", cfg.activityId, cfg.termId, cfg.startTime, cfg.endTime))
		end
	end
end

function PartySummaryConfig:getFoodPrizeCfgs(planId, foodType)
	planId = checknumber(planId)

	if self._foodPrizeCfgs == nil or self._foodPrizeCfgs[planId] == nil then
		return
	end

	local list = self._foodPrizeCfgs[planId]

	if foodType == nil or list[foodType] == nil then
		return list
	end

	return list[foodType]
end

function PartySummaryConfig:getFoodNpcCfgs(actId, npcId)
	actId = checknumber(actId)

	if self._foodNpcCfgs == nil or self._foodNpcCfgs[actId] == nil then
		return
	end

	local list = self._foodNpcCfgs[actId]

	if npcId == nil or list[npcId] == nil then
		return list
	end

	return list[npcId]
end

function PartySummaryConfig:getPartyGiftActivityId()
	return self:_getActivityIdByActivityType(GameEnum.ActivityType.PartyGift)
end

function PartySummaryConfig:getGiftPrizeCfgs(actId, id)
	actId = checknumber(actId)

	if self._giftPrizeCfgs == nil or self._giftPrizeCfgs[actId] == nil then
		return
	end

	local list = self._giftPrizeCfgs[actId]

	if id == nil or list[id] == nil then
		return list
	end

	return list[id]
end

function PartySummaryConfig:getGiftPrizeBgCfgs(actId)
	return self._giftPrizeBgCfgs[actId]
end

function PartySummaryConfig:_getActivityIdByActivityType(acType)
	if acType == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(acType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

function PartySummaryConfig:getCodeWordData(groupId, id)
	return self.code_word[groupId] and self.code_word[groupId][id]
end

function PartySummaryConfig:getCodeWordGroupData(groupId)
	return self.code_word_group[groupId]
end

function PartySummaryConfig:getTitleAndDesc(groupId, id)
	local groupCfg = self.code_word_group[groupId]

	if groupCfg.type == "normal" then
		id = 1
	end

	if self.code_word_group[groupId] then
		local title = self.code_word_group[groupId].text
		local codeWordData = self:getCodeWordData(groupId, id)
		local desc = codeWordData and codeWordData.text

		return title, desc
	end
end

function PartySummaryConfig:getRewardData(groupId)
	if self.code_word_group[groupId] then
		local rewards = self.code_word_group[groupId].prize

		if rewards and rewards ~= "" then
			return (string.split(rewards, "#"))
		end

		return nil
	end
end

function PartySummaryConfig:getStartAndEndTime(groupId)
	if self.code_word_group[groupId] then
		if self.code_word_group[groupId] then
			local endTime = self.code_word_group[groupId].endTime

			return self.code_word_group[groupId], endTime
		end
	end
end

function PartySummaryConfig:getTotalPrizeTimes(groupId)
	if self.code_word_group[groupId] then
		return self.code_word_group[groupId] or 0
	end
end

PartySummaryConfig.instance = PartySummaryConfig.New()

return PartySummaryConfig
