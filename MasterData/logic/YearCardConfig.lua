-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/config/YearCardConfig.lua

module("logic.extensions.yearcard.config.YearCardConfig", package.seeall)

local YearCardConfig = class("YearCardConfig", BaseConfig)

function YearCardConfig:onInit()
	YearCardConfig.super.onInit(self)

	self.scope_consume_month_prize = nil
	self.month_reward_show = nil
	self.yearcard_preheat_date_cfg = nil
	self.yearcard_preheat_Hud_cfg = nil
	self.mainViewCfg = nil
	self.progressPrizeCfg = nil
	self.giftCfgs = nil
	self.totalGiftCfg = nil
end

function YearCardConfig:getNames()
	return {
		"scope_consume_month_prize",
		"month_reward_show",
		"year_card_preheat_date",
		"year_card_preheat_Hud",
		"year_card_main_view",
		"annuity_progress_prize",
		"annuity_gift",
		"annuity_space_progress_prize",
		"annuity_new_gift",
		"year_card_common",
		"annuity_exchange"
	}
end

function YearCardConfig:handleConfig(name, content)
	if name == "scope_consume_month_prize" then
		self.scope_consume_month_prize = content
	elseif name == "month_reward_show" then
		self.month_reward_show = content
	elseif name == "year_card_preheat_date" then
		self.yearcard_preheat_date_cfg = content
	elseif name == "year_card_preheat_Hud" then
		self.yearcard_preheat_Hud_cfg = content
	elseif name == "year_card_main_view" then
		self.mainViewCfg = content
	elseif name == "annuity_progress_prize" then
		self.progressPrizeCfg = content
	elseif name == "annuity_gift" then
		self.giftCfgs = {}
		self.totalGiftCfg = {}

		for k, v in ipairs(content.dataList) do
			if not checkbool(v.isInstallment) and not self.totalGiftCfg[v.activityId] then
				self.totalGiftCfg[v.activityId] = v
			end

			self.giftCfgs[v.activityId] = self.giftCfgs[v.activityId] or {}
			self.giftCfgs[v.activityId][v.giftId] = v
		end
	elseif name == "annuity_new_gift" then
		self._annuity_new_gift = content
		self.newtotalGiftCfg = {}

		for k, v in ipairs(content.dataList) do
			if not checkbool(v.isInstallment) and not self.newtotalGiftCfg[v.activityId] then
				self.newtotalGiftCfg[v.activityId] = v
			end
		end
	elseif name == "annuity_space_progress_prize" then
		self.spaceProgressPrizeCfg = content
	elseif name == "year_card_common" then
		self._year_card_common = content
	elseif name == "annuity_exchange" then
		self._annuity_exchange = content
	end
end

function YearCardConfig:getMonthRewardCfgs(activityId)
	return self.scope_consume_month_prize[activityId]
end

function YearCardConfig:getMonthRewardCfgById(activityId, prizeId)
	if self.scope_consume_month_prize[activityId] then
		return self.scope_consume_month_prize[activityId][prizeId]
	end
end

function YearCardConfig:getRewardShowCfgs(activityId)
	return self.month_reward_show[activityId]
end

function YearCardConfig:getRewardShowCfgById(activityId, id)
	if self.month_reward_show[activityId] then
		return self.month_reward_show[activityId][id]
	end
end

function YearCardConfig:getPreheatCfgs(activityId)
	return self.yearcard_preheat_date_cfg[activityId]
end

function YearCardConfig:getpreheatviewCfgById(perheatId, id)
	if self.yearcard_preheat_Hud_cfg[perheatId] then
		if id then
			return self.yearcard_preheat_Hud_cfg[perheatId][id]
		else
			return self.yearcard_preheat_Hud_cfg[perheatId]
		end
	end
end

function YearCardConfig:getMainViewCfg(actId)
	if self.mainViewCfg[actId] then
		return self.mainViewCfg[actId]
	end
end

function YearCardConfig:getMainViewRootLeafByJumpInTag(jumpInTag)
	for i, v in ipairs(self.mainViewCfg.dataList) do
		if v.jumpInTag == jumpInTag then
			return v.root, v.leaf
		end
	end

	return 0, 0
end

function YearCardConfig:getProgressCfgList(actId)
	return self.progressPrizeCfg[actId] or {}
end

function YearCardConfig:getProgressCfg(actId, id)
	if self.progressPrizeCfg[actId] then
		if id then
			return self.progressPrizeCfg[actId][id]
		else
			return self.progressPrizeCfg[actId]
		end
	end
end

function YearCardConfig:getGiftCfg(actId, id)
	if self.giftCfgs[actId] then
		if id then
			return self.giftCfgs[actId][id]
		else
			return self.giftCfgs[actId]
		end
	end
end

function YearCardConfig:getTotalGiftCfg(actId)
	if self.totalGiftCfg[actId] then
		return self.totalGiftCfg[actId]
	end
end

function YearCardConfig:getNewGiftCfg(actId, id)
	if id then
		return self._annuity_new_gift[actId][id]
	else
		return self._annuity_new_gift[actId]
	end
end

function YearCardConfig:getNewTotalGiftCfg(actId)
	if self.newtotalGiftCfg[actId] then
		return self.newtotalGiftCfg[actId]
	end
end

function YearCardConfig:getNewGiftCfgs(activityId)
	return self._annuity_new_gift[activityId]
end

function YearCardConfig:getSpaceProgressPrizeCfgs(actId)
	return self.spaceProgressPrizeCfg[actId]
end

function YearCardConfig:getSpaceProgressPrizeCfg(actId, prizeId)
	return self.spaceProgressPrizeCfg[actId][prizeId]
end

function YearCardConfig:getYearcardCommonValue(key, checkNumber)
	local v = self._year_card_common[key]

	if checkNumber then
		return checknumber(v.value)
	else
		return v.value
	end
end

function YearCardConfig:GetAnnuityExchangeCfgs(actId)
	return self._annuity_exchange[actId]
end

function YearCardConfig:GetAnnuityExchangeCfg(actId, giftId)
	return self._annuity_exchange[actId][giftId]
end

function YearCardConfig:getCurrActId()
	return self:getYearcardCommonValue("CurActId", true)
end

function YearCardConfig:getNextActId()
	return self:getYearcardCommonValue("NextActId", true)
end

YearCardConfig.instance = YearCardConfig.New()

return YearCardConfig
