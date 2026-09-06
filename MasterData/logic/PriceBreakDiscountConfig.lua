-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/config/PriceBreakDiscountConfig.lua

module("logic.extensions.pricebreakdiscount.config.PriceBreakDiscountConfig", package.seeall)

local PriceBreakDiscountConfig = class("PriceBreakDiscountConfig", BaseConfig)

function PriceBreakDiscountConfig:onInit()
	PriceBreakDiscountConfig.super.onInit(self)

	self._commonCfgs = nil
	self._itemByTab = {}
end

function PriceBreakDiscountConfig:getNames()
	return {
		"price_break_discount_activity",
		"price_break_discount_item",
		"price_break_discount_plan",
		"price_break_discount_tab"
	}
end

function PriceBreakDiscountConfig:handleConfig(name, content)
	if name == "price_break_discount_activity" then
		self._price_break_discount_activity = content
	elseif name == "price_break_discount_item" then
		self._price_break_discount_item = content

		self:handleItem()
	elseif name == "price_break_discount_plan" then
		self._price_break_discount_plan = content

		self:handleDiscounPlan()
	elseif name == "price_break_discount_tab" then
		self._price_break_discount_tab = content
	end
end

function PriceBreakDiscountConfig:getActivityCfg(activityId)
	return self._price_break_discount_activity[activityId]
end

function PriceBreakDiscountConfig:getActivityCfgByIndex(index)
	return self._price_break_discount_activity.dataList[index]
end

function PriceBreakDiscountConfig:getItemsCfg(itemPlan)
	return self._price_break_discount_item[itemPlan]
end

function PriceBreakDiscountConfig:getItemCfg(itemPlan, itemId)
	return self._price_break_discount_item[itemPlan][itemId]
end

function PriceBreakDiscountConfig:getItemByTab(itemPlanm, tabType)
	if self._itemByTab[itemPlanm] and self._itemByTab[itemPlanm][tabType] then
		return self._itemByTab[itemPlanm][tabType]
	else
		return {}
	end
end

function PriceBreakDiscountConfig:getDiscPlan(discPlan)
	return self._price_break_discount_plan[discPlan]
end

function PriceBreakDiscountConfig:getDiscountList(discPlan)
	return self._discountList[discPlan]
end

function PriceBreakDiscountConfig:getTabCfg(itemPlanm)
	return self._price_break_discount_tab[itemPlanm]
end

function PriceBreakDiscountConfig:handleDiscounPlan()
	self._discountList = {}

	for i, planList in ipairs(self._price_break_discount_plan) do
		self._discountList[i] = self._discountList[i] or {}

		for j, priceCfg in pairs(planList) do
			table.insert(self._discountList[i], priceCfg)
		end

		table.sort(self._discountList[i], function(a, b)
			return a.fullPrice < b.fullPrice
		end)
	end
end

function PriceBreakDiscountConfig:handleItem()
	self._itemByTab = {}

	for i, v in ipairs(self._price_break_discount_item) do
		for j, cfg in ipairs(v) do
			self._itemByTab[cfg.itemPlan] = self._itemByTab[cfg.itemPlan] or {}

			if cfg.tabType and not cfg.isHide then
				self._itemByTab[cfg.itemPlan][cfg.tabType] = self._itemByTab[cfg.itemPlan][cfg.tabType] or {}

				table.insert(self._itemByTab[cfg.itemPlan][cfg.tabType], cfg)
			end
		end
	end
end

PriceBreakDiscountConfig.instance = PriceBreakDiscountConfig.New()

return PriceBreakDiscountConfig
