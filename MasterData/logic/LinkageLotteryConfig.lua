-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/config/LinkageLotteryConfig.lua

module("logic.extensions.linkagelottery.config.LinkageLotteryConfig", package.seeall)

local LinkageLotteryConfig = class("LinkageLotteryConfig", BaseConfig)

function LinkageLotteryConfig:onInit()
	LinkageLotteryConfig.super.onInit(self)

	self.linkage_lottery = nil
	self.linkage_lottery_rand = nil
	self.linkage_lottery_buy = nil
end

function LinkageLotteryConfig:getNames()
	return {
		"linkage_lottery",
		"linkage_lottery_rand",
		"linkage_lottery_buy"
	}
end

function LinkageLotteryConfig:handleConfig(name, content)
	if name == "linkage_lottery" then
		self.linkage_lottery = content
	elseif name == "linkage_lottery_rand" then
		self.linkage_lottery_rand = content
	elseif name == "linkage_lottery_buy" then
		self.linkage_lottery_buy = content
	end
end

function LinkageLotteryConfig:getActivityCfg(activityId)
	return self.linkage_lottery[activityId]
end

function LinkageLotteryConfig:getLotteryCfgList(lotteryPlanId)
	return self.linkage_lottery_rand[lotteryPlanId]
end

function LinkageLotteryConfig:getLotteryCfg(lotteryPlanId, lotteryId)
	if self.linkage_lottery_rand[lotteryPlanId] then
		return self.linkage_lottery_rand[lotteryPlanId][lotteryId]
	end
end

function LinkageLotteryConfig:getBuyPlanCfgList(buyPlanId)
	local dataList = self.linkage_lottery_buy.dataList
	local list = {}

	for i, v in ipairs(dataList) do
		if v.buyPlanId == buyPlanId then
			table.insert(list, v)
		end
	end

	return list
end

function LinkageLotteryConfig:getBuyPlanCfg(buyPlanId, hasBuyTime)
	if self.linkage_lottery_buy[buyPlanId] then
		return self.linkage_lottery_buy[buyPlanId][hasBuyTime]
	end
end

LinkageLotteryConfig.instance = LinkageLotteryConfig.New()

return LinkageLotteryConfig
