-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/config/GoddessShopConfig.lua

module("logic.extensions.goddessshop.config.GoddessShopConfig", package.seeall)

local GoddessShopConfig = class("GoddessShopConfig", BaseConfig)

function GoddessShopConfig:onInit()
	GoddessShopConfig.super.onInit(self)
end

function GoddessShopConfig:getNames()
	return {
		"surround_by_dream_girl_activity",
		"surround_by_dream_girl_money_progress_prize",
		"surround_by_dream_girl_girl",
		"surround_by_dream_girl_invest_plan",
		"surround_by_dream_girl_feel",
		"surround_by_dream_girl_gift",
		"surround_by_dream_girl_dialogue",
		"surround_by_dream_girl_npc"
	}
end

function GoddessShopConfig:handleConfig(name, content)
	if name == "surround_by_dream_girl_activity" then
		self._surround_by_dream_girl_activity = content
	elseif name == "surround_by_dream_girl_money_progress_prize" then
		self._surround_by_dream_girl_money_progress_prize = content
	elseif name == "surround_by_dream_girl_girl" then
		self._surround_by_dream_girl_girl = content
	elseif name == "surround_by_dream_girl_invest_plan" then
		self._surround_by_dream_girl_invest_plan = content
	elseif name == "surround_by_dream_girl_feel" then
		self._surround_by_dream_girl_feel = content
	elseif name == "surround_by_dream_girl_gift" then
		self._surround_by_dream_girl_gift = content
	elseif name == "surround_by_dream_girl_dialogue" then
		self._surround_by_dream_girl_dialogue = content
	elseif name == "surround_by_dream_girl_npc" then
		self._surround_by_dream_girl_npc = content
	end
end

function GoddessShopConfig:getActData(activityId)
	return self._surround_by_dream_girl_activity[activityId]
end

function GoddessShopConfig:getMoneyProgressCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.moneyPrizePlanId then
			local moneyPrizePlanId = 0

			return self._surround_by_dream_girl_money_progress_prize[moneyPrizePlanId]
		end
	end
end

function GoddessShopConfig:getMoneyProgressData(activityId, level)
	local cfg = self:getMoneyProgressCfg(activityId)

	if cfg then
		return cfg[level]
	end
end

function GoddessShopConfig:getMoneyProgressDataByMoney(activityId, money)
	local result
	local cfg = self:getMoneyProgressCfg(activityId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if money >= cfg[mid].progress then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function GoddessShopConfig:getLevelByMoney(activityId, money)
	local data = self:getMoneyProgressDataByMoney(activityId, money)

	return (data or nil) and (data.level or 0)
end

function GoddessShopConfig:getMaxLevelInProgress(activityId)
	local cfg = self:getMoneyProgressCfg(activityId)

	return (cfg or nil) and (cfg[#cfg].level or 0)
end

function GoddessShopConfig:getGirlCfg(activityId)
	return self._surround_by_dream_girl_girl[activityId]
end

function GoddessShopConfig:getGirlData(activityId, dreamGirlId)
	if self._surround_by_dream_girl_girl[activityId] then
		return self._surround_by_dream_girl_girl[activityId][dreamGirlId]
	end
end

function GoddessShopConfig:getDialoguePlanId(activityId, girlId)
	local data = self:getGirlData(activityId, girlId)

	return (data or nil) and (data.dialoguePlanId or 0)
end

function GoddessShopConfig:getGirlInvestCfg(activityId, dreamGirlId)
	local girlData = self:getGirlData(activityId, dreamGirlId)

	if girlData then
		if not girlData.investPlanId then
			local investPlanId = 0

			return self._surround_by_dream_girl_invest_plan[investPlanId]
		end
	end
end

function GoddessShopConfig:getGirlInvestData(activityId, dreamGirlId, level)
	local cfg = self:getGirlInvestCfg(activityId, dreamGirlId)

	if cfg then
		return cfg[level]
	end
end

function GoddessShopConfig:getGirlInvestMaxLevel(activityId, dreamGirlId)
	local cfg = self:getGirlInvestCfg(activityId, dreamGirlId)

	return (cfg or nil) and (#cfg or 0)
end

function GoddessShopConfig:getFeelCfg(activityId, dreamGirlId)
	local data = self:getGirlData(activityId, dreamGirlId)

	if data then
		if not data.feelPlanId then
			local feelPlanId = 0

			return self._surround_by_dream_girl_feel[feelPlanId]
		end
	end
end

function GoddessShopConfig:getFeelData(activityId, dreamGirlId, value)
	local result
	local cfg = self:getFeelCfg(activityId, dreamGirlId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if value >= cfg[mid].value then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function GoddessShopConfig:getFeelDataById(activityId, dreamGirlId, feelId)
	local cfg = self:getFeelCfg(activityId, dreamGirlId)

	return cfg and cfg[feelId]
end

function GoddessShopConfig:getGiftCfg(activityId)
	return self._surround_by_dream_girl_gift[activityId]
end

function GoddessShopConfig:getGiftData(activityId, giftId)
	if self._surround_by_dream_girl_gift[activityId] then
		return self._surround_by_dream_girl_gift[activityId][giftId]
	end
end

function GoddessShopConfig:getDialogueCfgs(dialoguePlanId)
	return self._surround_by_dream_girl_dialogue[dialoguePlanId]
end

function GoddessShopConfig:getDialogueCfg(dialoguePlanId, dialogueId)
	if self._surround_by_dream_girl_dialogue[dialoguePlanId] then
		return self._surround_by_dream_girl_dialogue[dialoguePlanId][dialogueId]
	end
end

function GoddessShopConfig:getDialogueData(dialoguePlanId, dialogueId, id)
	if self._surround_by_dream_girl_dialogue[dialoguePlanId] and self._surround_by_dream_girl_dialogue[dialoguePlanId][dialogueId] then
		return self._surround_by_dream_girl_dialogue[dialoguePlanId][dialogueId][id]
	end
end

function GoddessShopConfig:getNpcData(npcId)
	return self._surround_by_dream_girl_npc[npcId]
end

GoddessShopConfig.instance = GoddessShopConfig.New()

return GoddessShopConfig
