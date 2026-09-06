-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/config/RichmanxplanConfig.lua

module("logic.extensions.richmanxplan.config.RichmanxplanConfig", package.seeall)

local RichmanxplanConfig = class("RichmanxplanConfig", BaseConfig)

function RichmanxplanConfig:onInit()
	return
end

function RichmanxplanConfig:getNames()
	return {
		"rich_man_x_plan_activity",
		"rich_man_x_plan_zone",
		"rich_man_x_plan_grid",
		"rich_man_x_plan_dice",
		"rich_man_x_plan_land_event",
		"rich_man_x_plan_shop_event",
		"rich_man_x_plan_shop_event_item",
		"rich_man_x_plan_gambling_event",
		"rich_man_x_plan_gambling_item_event",
		"rich_man_x_plan_draw_event",
		"rich_man_x_plan_draw_item_event",
		"rich_man_x_plan_tarot_event",
		"rich_man_x_plan_tarot_item_event",
		"rich_man_x_plan_recruit_event",
		"rich_man_x_plan_recruit_event_item",
		"rich_man_x_plan_prize_event",
		"rich_man_x_plan_prize_event_item",
		"rich_man_x_plan_rush_event",
		"rich_man_x_plan_lottery_event",
		"rich_man_x_plan_lottery_item_event",
		"rich_man_x_plan_buff",
		"rich_man_x_plan_work",
		"rich_man_x_plan_work_pet",
		"rich_man_x_plan_work_star",
		"rich_man_x_plan_event_define",
		"rich_man_x_plan_tarot_item_icon"
	}
end

function RichmanxplanConfig:handleConfig(name, content)
	if name == "rich_man_x_plan_activity" then
		self._rich_man_x_plan_activity = content
	elseif name == "rich_man_x_plan_zone" then
		self._rich_man_x_plan_zone = content
	elseif name == "rich_man_x_plan_grid" then
		self._rich_man_x_plan_grid = content
	elseif name == "rich_man_x_plan_dice" then
		self._rich_man_x_plan_dice = content
	elseif name == "rich_man_x_plan_land_event" then
		self._rich_man_x_plan_land_event = content
	elseif name == "rich_man_x_plan_shop_event" then
		self._rich_man_x_plan_shop_event = content
	elseif name == "rich_man_x_plan_shop_event_item" then
		self._rich_man_x_plan_shop_event_item = content
	elseif name == "rich_man_x_plan_gambling_event" then
		self._rich_man_x_plan_gambling_event = content
	elseif name == "rich_man_x_plan_gambling_item_event" then
		self._rich_man_x_plan_gambling_item_event = content
	elseif name == "rich_man_x_plan_draw_event" then
		self._rich_man_x_plan_draw_event = content
	elseif name == "rich_man_x_plan_draw_item_event" then
		self._rich_man_x_plan_draw_item_event = content
	elseif name == "rich_man_x_plan_tarot_event" then
		self._rich_man_x_plan_tarot_event = content
	elseif name == "rich_man_x_plan_tarot_item_event" then
		self._rich_man_x_plan_tarot_item_event = content
	elseif name == "rich_man_x_plan_recruit_event" then
		self._rich_man_x_plan_recruit_event = content
	elseif name == "rich_man_x_plan_recruit_event_item" then
		self._rich_man_x_plan_recruit_event_item = content
	elseif name == "rich_man_x_plan_prize_event" then
		self._rich_man_x_plan_prize_event = content
	elseif name == "rich_man_x_plan_prize_event_item" then
		self._rich_man_x_plan_prize_event_item = content
	elseif name == "rich_man_x_plan_rush_event" then
		self._rich_man_x_plan_rush_event = content
	elseif name == "rich_man_x_plan_lottery_event" then
		self._rich_man_x_plan_lottery_event = content
	elseif name == "rich_man_x_plan_lottery_item_event" then
		self._rich_man_x_plan_lottery_item_event = content
	elseif name == "rich_man_x_plan_buff" then
		self._rich_man_x_plan_buff = content
	elseif name == "rich_man_x_plan_work" then
		self._rich_man_x_plan_work = content
	elseif name == "rich_man_x_plan_work_pet" then
		self._rich_man_x_plan_work_pet = content
	elseif name == "rich_man_x_plan_work_star" then
		self._rich_man_x_plan_work_star = content
	elseif name == "rich_man_x_plan_event_define" then
		self._rich_man_x_plan_event_define = content
	elseif name == "rich_man_x_plan_tarot_item_icon" then
		self._rich_man_x_plan_tarot_item_icon = content
	end
end

function RichmanxplanConfig:getGridCfgs(activityId, zoneId)
	return self._rich_man_x_plan_grid[activityId][zoneId]
end

function RichmanxplanConfig:getGridCfg(activityId, zoneId, gridId)
	return self._rich_man_x_plan_grid[activityId][zoneId][gridId]
end

function RichmanxplanConfig:getDiceCfgs(activityId)
	return self._rich_man_x_plan_dice[activityId]
end

function RichmanxplanConfig:getDiceCfg(activityId, diceId)
	return self._rich_man_x_plan_dice[activityId][diceId]
end

function RichmanxplanConfig:getLandEventCfg(activityId, eventId)
	return self._rich_man_x_plan_land_event[activityId][eventId]
end

function RichmanxplanConfig:getZoneCfg(activityId, zoneId)
	return self._rich_man_x_plan_zone[activityId][zoneId]
end

function RichmanxplanConfig:getZoneCfgs(activityId)
	return self._rich_man_x_plan_zone[activityId]
end

function RichmanxplanConfig:getBuffCfg(activityId, buffId)
	return self._rich_man_x_plan_buff[activityId][buffId]
end

function RichmanxplanConfig:getWorkCfgs(activityId)
	return self._rich_man_x_plan_work[activityId]
end

function RichmanxplanConfig:getWorkCfg(activityId, posId)
	return self._rich_man_x_plan_work[activityId][posId]
end

function RichmanxplanConfig:getPetCfgs(activityId)
	return self._rich_man_x_plan_work_pet[activityId]
end

function RichmanxplanConfig:getPetCfg(activityId, raceId)
	return self._rich_man_x_plan_work_pet[activityId][raceId]
end

function RichmanxplanConfig:getRecruitEventItemCfg(activityId, eventId, raceId)
	return self._rich_man_x_plan_recruit_event_item[activityId][eventId][raceId]
end

function RichmanxplanConfig:getWorkStorage(activityId)
	return self._rich_man_x_plan_activity[activityId].workStorage
end

function RichmanxplanConfig:getPetWorkEfficiency(activityId, starLevel, isExclusive)
	local cfg = self._rich_man_x_plan_work_star[activityId][starLevel]

	if isExclusive then
		return cfg.exclusiveEfficiency
	else
		return cfg.efficiency
	end
end

function RichmanxplanConfig:checkIsExclusive(activityId, posId, raceId)
	local t = self._rich_man_x_plan_work[activityId][posId].exclusiveRaceId

	return table.indexof(t, raceId)
end

function RichmanxplanConfig:getEventDefineCfgs()
	return self._rich_man_x_plan_event_define.dataList
end

function RichmanxplanConfig:getShopEventCfg(activityId, eventId)
	return self._rich_man_x_plan_shop_event[activityId][eventId]
end

function RichmanxplanConfig:getShopItemCfg(activityId, eventId, itemId)
	return self._rich_man_x_plan_shop_event_item[activityId][eventId][itemId]
end

function RichmanxplanConfig:getBoyiEventCfg(activityId, eventId)
	return self._rich_man_x_plan_gambling_event[activityId][eventId]
end

function RichmanxplanConfig:getBoyiItemCfgs(activityId, eventId)
	return self._rich_man_x_plan_gambling_item_event[activityId][eventId]
end

function RichmanxplanConfig:getBoyiItemCfg(activityId, eventId, itemId)
	return self._rich_man_x_plan_gambling_item_event[activityId][eventId][itemId]
end

function RichmanxplanConfig:getRushEventCfg(activityId, eventId)
	return self._rich_man_x_plan_rush_event[activityId][eventId]
end

function RichmanxplanConfig:getCaipiaoEventCfg(activityId, eventId)
	return self._rich_man_x_plan_lottery_event[activityId][eventId]
end

function RichmanxplanConfig:getPrizeItemCfg(activityId, eventId, prizeId)
	return self._rich_man_x_plan_prize_event_item[activityId][eventId][prizeId]
end

function RichmanxplanConfig:getPrizeEventCfg(activityId, eventId)
	return self._rich_man_x_plan_prize_event[activityId][eventId]
end

function RichmanxplanConfig:getDrawEventCfg(activityId, eventId)
	return self._rich_man_x_plan_draw_event[activityId][eventId]
end

function RichmanxplanConfig:getDrawItemCfg(activityId, eventId, digit)
	return self._rich_man_x_plan_draw_item_event[activityId][eventId][digit]
end

function RichmanxplanConfig:getZhanbuEventCfg(activityId, eventId)
	return self._rich_man_x_plan_tarot_event[activityId][eventId]
end

function RichmanxplanConfig:getZhanbuItemCfgs(activityId, eventId)
	return self._rich_man_x_plan_tarot_item_event[activityId][eventId]
end

function RichmanxplanConfig:getZhanbuItemCfg(activityId, eventId, itemId)
	return self._rich_man_x_plan_tarot_item_event[activityId][eventId][itemId]
end

function RichmanxplanConfig:getPetMaxStarLevel(activityId)
	return #self._rich_man_x_plan_work_star[activityId]
end

function RichmanxplanConfig:getPetStarLevelCfg(activityId, starLevel)
	return self._rich_man_x_plan_work_star[activityId][starLevel]
end

function RichmanxplanConfig:getPetLevelUpUseNumber(activityId)
	return self._rich_man_x_plan_activity[activityId].levelUpUseNumber
end

function RichmanxplanConfig:getRuleKey(activityId, key)
	return self._rich_man_x_plan_activity[activityId][key]
end

function RichmanxplanConfig:getActCfg(activityId)
	return self._rich_man_x_plan_activity[activityId]
end

function RichmanxplanConfig:getZhanbuIconCfg(activityId)
	return self._rich_man_x_plan_tarot_item_icon[activityId]
end

RichmanxplanConfig.instance = RichmanxplanConfig.New()

return RichmanxplanConfig
