-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/config/PetCardLotteryConfig.lua

module("logic.extensions.petcardlottery.config.PetCardLotteryConfig", package.seeall)

local PetCardLotteryConfig = class("PetCardLotteryConfig", BaseConfig)

function PetCardLotteryConfig:onInit()
	PetCardLotteryConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PetCardLotteryConfig:getNames()
	return {
		"pet_card_lottery",
		"pet_card_lottery_card",
		"pet_card_lottery_period",
		"pet_card_lottery_prize"
	}
end

function PetCardLotteryConfig:handleConfig(name, content)
	if name == "pet_card_lottery" then
		self._pcLotteryCfg = content
	elseif name == "pet_card_lottery_card" then
		self._pcLotteryCardCfg = content
	elseif name == "pet_card_lottery_period" then
		self._pcLotteryPeriodCfg = content
	elseif name == "pet_card_lottery_prize" then
		self._pcLotteryPrizeCfg = content
	end
end

function PetCardLotteryConfig:getCfgById(actId)
	return self._pcLotteryCfg[actId]
end

function PetCardLotteryConfig:getCardCfg(actId)
	return self._pcLotteryCardCfg[actId]
end

function PetCardLotteryConfig:getCardIcon(actId, id)
	return self._pcLotteryCardCfg[actId][id]
end

function PetCardLotteryConfig:getPeriodCfg(actId)
	return self._pcLotteryPeriodCfg[actId]
end

function PetCardLotteryConfig:getPrizeCfg(actId)
	return self._pcLotteryPrizeCfg[actId]
end

function PetCardLotteryConfig:getPrizeCfgById(actId, id)
	if self._pcLotteryPrizeCfg[actId] then
		return self._pcLotteryPrizeCfg[actId][id]
	end
end

function PetCardLotteryConfig:getLotteryPeriodCfg(actId, wday)
	local cfg = self:getPeriodCfg(actId)

	if cfg then
		for _, data in pairs(cfg) do
			for _, day in pairs(data.daysOfWeek) do
				if day == wday then
					return data
				end
			end
		end
	end
end

function PetCardLotteryConfig:getTypeName(actId, wday)
	return self:getLotteryPeriodCfg(actId, wday).name
end

function PetCardLotteryConfig:getDaysOfWeek(actId, wday)
	return self:getLotteryPeriodCfg(actId, wday).daysOfWeek
end

function PetCardLotteryConfig:getCardId(actId)
	local cardIds = {}

	for _, v in pairs(self:getCardCfg(actId)) do
		table.insert(cardIds, v.id)
	end

	return cardIds
end

PetCardLotteryConfig.instance = PetCardLotteryConfig.New()

return PetCardLotteryConfig
