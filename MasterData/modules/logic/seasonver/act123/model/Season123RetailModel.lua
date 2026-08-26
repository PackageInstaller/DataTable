-- chunkname: @modules/logic/seasonver/act123/model/Season123RetailModel.lua

module("modules.logic.seasonver.act123.model.Season123RetailModel", package.seeall)

local Season123RetailModel = class("Season123RetailModel", BaseModel)

function Season123RetailModel:release()
	self.lastSendEpisodeCfg = nil
	self.rewardIconCfgs = nil
end

function Season123RetailModel:init(actId)
	self.activityId = actId

	self:initDatas()
	self:initRewards()
end

function Season123RetailModel:initDatas()
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return
	end

	self.retailId = seasonMO.retailId

	if not self.retailId then
		return
	end

	self.retailCO = Season123Config.instance:getRetailCO(self.activityId, self.retailId)

	if not self.retailCO then
		return
	end

	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.retailCO.episodeId)
end

function Season123RetailModel:initRewards()
	self.rewardIcons = {}
	self.rewardIconCfgs = {}

	if not self.retailCO then
		return
	end

	local bonusList = GameUtil.splitString2(self.retailCO.bonus, true, "|", "#")

	for i, bonusKV in ipairs(bonusList) do
		local bonusType = bonusKV[1]
		local bonusId = bonusKV[2]
		local itemCO, iconStr = ItemModel.instance:getItemConfigAndIcon(bonusType, bonusId)

		table.insert(self.rewardIconCfgs, bonusKV)
		table.insert(self.rewardIcons, iconStr)
	end
end

function Season123RetailModel:getRecommentLevel()
	if not self.episodeCO then
		return nil
	end

	local episodeId = self.episodeCO.id
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local recommendLevel = FightHelper.getBattleRecommendLevel(episodeConfig.battleId)

	if recommendLevel >= 0 then
		return recommendLevel
	else
		return nil
	end
end

function Season123RetailModel:getEpisodeId()
	if not self.episodeCO then
		return nil
	end

	return self.episodeCO.id
end

function Season123RetailModel:getRewards()
	local rsList = {}

	if not self.episodeCO then
		return rsList
	end
end

function Season123RetailModel:getUTTUTicketNum()
	local actId = self.activityId
	local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)

	if ticketId then
		local currencyMO = CurrencyModel.instance:getCurrency(ticketId)

		return (currencyMO or nil) and (currencyMO.quantity or 0)
	end

	return 0
end

Season123RetailModel.instance = Season123RetailModel.New()

return Season123RetailModel
