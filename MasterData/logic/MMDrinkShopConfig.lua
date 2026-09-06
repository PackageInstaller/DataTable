-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/config/MMDrinkShopConfig.lua

module("logic.extensions.mmdrinkshop.config.MMDrinkShopConfig", package.seeall)

local MMDrinkShopConfig = class("MMDrinkShopConfig", BaseConfig)

function MMDrinkShopConfig:onInit()
	MMDrinkShopConfig.super.onInit(self)
end

function MMDrinkShopConfig:getNames()
	return {
		"mm_drink_shop_toppings_plan",
		"mm_drink_shop_activity",
		"mm_drink_shop_day_slot",
		"mm_drink_shop_drink",
		"mm_drink_shop_prize",
		"mm_drink_shop_toppings"
	}
end

function MMDrinkShopConfig:handleConfig(name, content)
	if name == "mm_drink_shop_toppings_plan" then
		self._mm_drink_shop_toppings_plan = content
	elseif name == "mm_drink_shop_activity" then
		self._mm_drink_shop_activity = content
	elseif name == "mm_drink_shop_day_slot" then
		self._mm_drink_shop_day_slot = content
	elseif name == "mm_drink_shop_drink" then
		self._mm_drink_shop_drink = content
	elseif name == "mm_drink_shop_prize" then
		self._mm_drink_shop_prize = content
	elseif name == "mm_drink_shop_toppings" then
		self._mm_drink_shop_toppings = content

		self:_handleToppingsCfg(content)
	end
end

function MMDrinkShopConfig:getActivityCfgByActivityId(activityId)
	return self._mm_drink_shop_activity[activityId]
end

function MMDrinkShopConfig:getToppingsCfgByToppingsId(activityId, toppingsId)
	if self._mm_drink_shop_toppings[activityId] then
		return self._mm_drink_shop_toppings[activityId][toppingsId]
	end
end

function MMDrinkShopConfig:_handleToppingsCfg(content)
	self._mm_drink_shop_toppings_group = {}

	for _, v in ipairs(content.dataList) do
		local activityId = v.activityId
		local toppingsType = v.toppingsType

		if not self._mm_drink_shop_toppings_group[activityId] then
			if not self._mm_drink_shop_toppings_group[activityId][toppingsType] then
				local typeCfgs = {}

				table.insert(typeCfgs, v)

				self._mm_drink_shop_toppings_group[activityId][toppingsType] = typeCfgs
				self._mm_drink_shop_toppings_group[activityId] = self._mm_drink_shop_toppings_group[activityId]
			end
		end
	end
end

function MMDrinkShopConfig:getToppingsCfgByGroup(activityId)
	return self._mm_drink_shop_toppings_group[activityId] or {}
end

function MMDrinkShopConfig:getToppingsCfgByType(activityId, toppingsType)
	if self._mm_drink_shop_toppings_group[activityId] then
		return self._mm_drink_shop_toppings_group[activityId][toppingsType] or {}
	end

	return {}
end

function MMDrinkShopConfig:getToppingsPlanCfgByPlanId(toppingsPlanId)
	return self._mm_drink_shop_toppings_plan[toppingsPlanId]
end

function MMDrinkShopConfig:getSlotLoopDayCount(activityId)
	local cfgs = self._mm_drink_shop_day_slot[activityId]

	if cfgs then
		return #cfgs
	end

	return 0
end

function MMDrinkShopConfig:getDaySlotCfgByDayIndex(activityId, dayIndex)
	if self._mm_drink_shop_day_slot[activityId] then
		return self._mm_drink_shop_day_slot[activityId][dayIndex]
	end
end

function MMDrinkShopConfig:getDrinkCfgByDrinkId(activityId, drinkId)
	if self._mm_drink_shop_drink[activityId] then
		return self._mm_drink_shop_drink[activityId][drinkId]
	end
end

function MMDrinkShopConfig:getAllPrizeCfgByActivityId(activityId)
	return self._mm_drink_shop_prize[activityId] or {}
end

function MMDrinkShopConfig:getPrizeCfgByPrizeId(activityId, prizeId)
	if self._mm_drink_shop_prize[activityId] then
		return self._mm_drink_shop_prize[activityId][prizeId]
	end
end

MMDrinkShopConfig.instance = MMDrinkShopConfig.New()

return MMDrinkShopConfig
