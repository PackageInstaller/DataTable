-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/config/GlorybattleConfig.lua

module("logic.extensions.glorybattle.config.GlorybattleConfig", package.seeall)

local GlorybattleConfig = class("GlorybattleConfig", BaseConfig)

function GlorybattleConfig:onInit()
	return
end

function GlorybattleConfig:getNames()
	return {
		"glory_battle_continuous_win",
		"glory_battle_score_rank_prize",
		"glory_battle_pet_card",
		"glory_battle_genre",
		"glory_battle_score",
		"glory_battle_holy_stripe_suit",
		"glory_battle_cute_pet",
		"glory_battle_creeps",
		"glory_battle_pet",
		"glory_battle_attribute",
		"glory_battle_goods_pool_plan",
		"glory_battle_holy_stripe",
		"glory_battle_activity",
		"glory_battle_creeps_master",
		"glory_battle_gain_currency",
		"glory_battle_common",
		"glory_battle_goods",
		"glory_battle_shop_plan",
		"glory_battle_match_rule"
	}
end

function GlorybattleConfig:handleConfig(name, content)
	if name == "glory_battle_continuous_win" then
		self._glory_battle_continuous_win = content
	elseif name == "glory_battle_score_rank_prize" then
		self._glory_battle_score_rank_prize = content
	elseif name == "glory_battle_pet_card" then
		self._glory_battle_pet_card = content
	elseif name == "glory_battle_genre" then
		self._glory_battle_genre = content
	elseif name == "glory_battle_score" then
		self._glory_battle_score = content
	elseif name == "glory_battle_holy_stripe_suit" then
		self._glory_battle_holy_stripe_suit = content
	elseif name == "glory_battle_cute_pet" then
		self._glory_battle_cute_pet = content
	elseif name == "glory_battle_creeps" then
		self._glory_battle_creeps = content
	elseif name == "glory_battle_pet" then
		self._glory_battle_pet = content
	elseif name == "glory_battle_attribute" then
		self._glory_battle_attribute = content
	elseif name == "glory_battle_goods_pool_plan" then
		self._glory_battle_goods_pool_plan = content
	elseif name == "glory_battle_holy_stripe" then
		self._glory_battle_holy_stripe = content
	elseif name == "glory_battle_activity" then
		self._glory_battle_activity = content
	elseif name == "glory_battle_creeps_master" then
		self._glory_battle_creeps_master = content
	elseif name == "glory_battle_gain_currency" then
		self._glory_battle_gain_currency = content
	elseif name == "glory_battle_common" then
		self._glory_battle_common = content
	elseif name == "glory_battle_goods" then
		self._glory_battle_goods = content
	elseif name == "glory_battle_shop_plan" then
		self._glory_battle_shop_plan = content
	elseif name == "glory_battle_match_rule" then
		self._glory_battle_match_rule = content
	end
end

function GlorybattleConfig:getActCfg(activityId)
	return self._glory_battle_activity[activityId]
end

function GlorybattleConfig:getCommonValue(key, isToNumber)
	local value = self._glory_battle_common[key].value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function GlorybattleConfig:getGenreCfg(activityId, genreId)
	return self._glory_battle_genre[activityId][genreId]
end

function GlorybattleConfig:getShopLv(activityId, genreId, round)
	local cfg = self:getGenreCfg(activityId, genreId)
	local planCfgs = self:getShopPlanCfgs(cfg.shopPlan)

	for i, v in ipairs(planCfgs) do
		if round <= v.round then
			return v.level
		end
	end

	return 1
end

function GlorybattleConfig:getShopPlanCfgs(shopPlan)
	return self._glory_battle_shop_plan[shopPlan]
end

function GlorybattleConfig:getBattleGoodsCfg(goodsId)
	return self._glory_battle_goods[goodsId]
end

function GlorybattleConfig:getMasterCfg(creepsMasterId)
	return self._glory_battle_creeps_master[creepsMasterId]
end

function GlorybattleConfig:getCreepsCfgs(creepsMasterId)
	return self._glory_battle_creeps[creepsMasterId]
end

function GlorybattleConfig:getCreepsCfg(creepsMasterId, creepsId)
	return self._glory_battle_creeps[creepsMasterId][creepsId]
end

function GlorybattleConfig:getBattlePetCfg(activityId, creepsId)
	local actCfg = self:getActCfg(activityId)

	return self._glory_battle_pet[actCfg.battlePetPlan][creepsId]
end

function GlorybattleConfig:getCutePetCfgs(cutePetId)
	return self._glory_battle_cute_pet[cutePetId]
end

function GlorybattleConfig:getCutePetCfg(cutePetId, level)
	return self._glory_battle_cute_pet[cutePetId][level]
end

function GlorybattleConfig:getCutePetRaceId(cutePetId)
	return self._glory_battle_cute_pet[cutePetId][0].raceId
end

function GlorybattleConfig:getPetCardCfg(activityId, petCardId)
	return self._glory_battle_pet_card[activityId][petCardId]
end

function GlorybattleConfig:getHolyStripeSuitCfg(suitId)
	return self._glory_battle_holy_stripe_suit[suitId]
end

function GlorybattleConfig:getHolyStripeCfg(holyStripeId)
	return self._glory_battle_holy_stripe[holyStripeId]
end

function GlorybattleConfig:getCutePetLevel(cutePetId, exp)
	local cfgs = self:getCutePetCfgs(cutePetId)

	for i = 0, #cfgs - 1 do
		exp = exp - cfgs[i].upgradeNeedExperience

		if exp == 0 then
			return cfgs[i + 1].level
		elseif exp < 0 then
			return cfgs[i].level
		end
	end

	return 0
end

function GlorybattleConfig:getScore(winNum)
	local dataList = self._glory_battle_score.dataList

	for i, v in ipairs(dataList) do
		if winNum <= v.winNum then
			return v.score
		end
	end

	return dataList[#dataList].score
end

function GlorybattleConfig:getRankPrizeCfg(activityId, rank)
	for i, v in pairs(self._glory_battle_score_rank_prize[activityId]) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end
end

function GlorybattleConfig:getRoundGainNum(round)
	for i, v in ipairs(self._glory_battle_gain_currency.dataList) do
		if v.round == round then
			return v.gainCurrency
		end
	end

	return 0
end

function GlorybattleConfig:getAttributeCfg(id)
	return self._glory_battle_attribute[id]
end

GlorybattleConfig.instance = GlorybattleConfig.New()

return GlorybattleConfig
