-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/config/GiftBoxConfig.lua

module("logic.extensions.giftbox.config.GiftBoxConfig", package.seeall)

local GiftBoxConfig = class("GiftBoxConfig", BaseConfig)

function GiftBoxConfig:onInit()
	GiftBoxConfig.super.onInit(self)
end

function GiftBoxConfig:getNames()
	return {
		"gift_box_activity",
		"gift_box_gain_luck_prize",
		"gift_box_gain_luck",
		"gift_box_pool",
		"gift_box_plan",
		"gift_box_normal_prize",
		"gift_box_type",
		"gift_box_super_prize",
		"gift_box_rate",
		"gift_box_score"
	}
end

function GiftBoxConfig:handleConfig(name, content)
	if name == "gift_box_activity" then
		self._gift_box_activity = content
	elseif name == "gift_box_gain_luck_prize" then
		self._gift_box_gain_luck_prize = content
	elseif name == "gift_box_gain_luck" then
		self._gift_box_gain_luck = content
	elseif name == "gift_box_pool" then
		self._gift_box_pool = content
	elseif name == "gift_box_plan" then
		self._gift_box_plan = content
	elseif name == "gift_box_normal_prize" then
		self._gift_box_normal_prize = content
	elseif name == "gift_box_type" then
		self._gift_box_type = content
	elseif name == "gift_box_super_prize" then
		self._gift_box_super_prize = content
	elseif name == "gift_box_rate" then
		self._gift_box_rate = content
	elseif name == "gift_box_score" then
		self._gift_box_score = content
	end
end

function GiftBoxConfig:getActCfgById(actId)
	return self._gift_box_activity[actId]
end

function GiftBoxConfig:getPoolCfgs(actId)
	return self._gift_box_pool[actId]
end

function GiftBoxConfig:getPoolCfg(actId, poolId)
	return self._gift_box_pool[actId][poolId]
end

function GiftBoxConfig:getBoxCfgs(boxPlanId)
	return self._gift_box_plan[boxPlanId]
end

function GiftBoxConfig:getGainLuckPrizeCfg(actId)
	return self._gift_box_gain_luck_prize[actId]
end

function GiftBoxConfig:handleBoxPlan()
	self._boxNormalPrizePlan = {}

	for i, v in ipairs(self._gift_box_plan.dataList) do
		self._boxNormalPrizePlan[v.boxType] = v.normalPrizePlanId
	end
end

function GiftBoxConfig:getBoxNormalPrizePlan(boxType)
	if not self._boxNormalPrizePlan then
		self:handleBoxPlan()
	end

	return self._boxNormalPrizePlan[boxType]
end

function GiftBoxConfig:getBoxTypeCfg(boxType)
	return self._gift_box_type[boxType]
end

function GiftBoxConfig:getBoxTypeCfgs(actId)
	self.boxTypeByActId = self.boxTypeByActId or {}

	if not self.boxTypeByActId[actId] then
		self.boxTypeByActId[actId] = {}

		local poolCfg = self:getPoolCfgs(actId)
		local boxTypeMap = {}

		for i, v in pairs(poolCfg) do
			local boxPlanCfg = self:getBoxCfgs(v.boxPlanId)

			for j, boxCfg in ipairs(boxPlanCfg) do
				boxTypeMap[boxCfg.boxType] = true
			end
		end

		for i, v in pairs(boxTypeMap) do
			if v == true then
				local cfg = self:getBoxTypeCfg(i)

				table.insert(self.boxTypeByActId[actId], cfg)
			end
		end

		table.sort(self.boxTypeByActId[actId], function(a, b)
			return a.boxType < b.boxType
		end)
	end

	return self.boxTypeByActId[actId]
end

function GiftBoxConfig:getNormalPrizeCfg(normalPrizePlanId)
	return self._gift_box_normal_prize[normalPrizePlanId]
end

function GiftBoxConfig:getSuperPrizeCfg(superPrizePlanId)
	return self._gift_box_super_prize[superPrizePlanId]
end

function GiftBoxConfig:getSuperPrizeRate(ratePlan)
	return self._gift_box_rate[ratePlan]
end

GiftBoxConfig.instance = GiftBoxConfig.New()

return GiftBoxConfig
