-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameModel.lua

module("logic.extensions.orimatgame.model.OriMatGameModel", package.seeall)

local OriMatGameModel = class("OriMatGameModel", BaseModel)

function OriMatGameModel:onInit()
	self:onReset()
end

function OriMatGameModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._seasonWaveIds = {}
	self._seasonGainedPrizeIds = {}
end

function OriMatGameModel:handlePM_OriginMaterialGameAllSeasonRes(msg)
	for _, item in ipairs(msg.items) do
		local seasonId = item.seasonId

		self._seasonWaveIds[seasonId] = item.waveId
		self._seasonGainedPrizeIds[seasonId] = self._seasonGainedPrizeIds[seasonId] or {}

		for _, prizeId in ipairs(item.gainedPrizeIds) do
			self._seasonGainedPrizeIds[seasonId][prizeId] = true
		end
	end
end

function OriMatGameModel:handlePM_OriginMaterialGameGainPrizeRes(msg)
	local seasonId = msg.seasonId

	for _, prizeId in ipairs(msg.prizeIds) do
		self._seasonGainedPrizeIds[seasonId][prizeId] = true
	end
end

function OriMatGameModel:getSubMo(seasonId)
	if self._moPool[seasonId] == nil then
		self._moPool[seasonId] = OriMatGameSubMo.New(seasonId)
	end

	return self._moPool[seasonId]
end

function OriMatGameModel:isFinishSeason(seasonId)
	local cur = self:getWaveInSeason(seasonId)
	local max = self:getMaxWaveInSeason(seasonId)

	return max <= cur
end

function OriMatGameModel:getWaveInSeason(seasonId)
	return self._seasonWaveIds[seasonId] or 0
end

function OriMatGameModel:getMaxWaveInSeason(seasonId)
	local seasonData = OriMatGameConfig.instance:getSeasonData(seasonId)

	if seasonData then
		if not seasonData.prizePlanId then
			local prizePlanId = 0
			local prizeCfg = OriMatGameConfig.instance:getPrizeCfgs(prizePlanId)
			local prizeData = prizeCfg and prizeCfg[#prizeCfg]

			if prizeData then
				if not prizeData.totalWaveNum then
					return 0
				end
			end
		end
	end
end

function OriMatGameModel:isHasGainPrizeInSeason(seasonId, prizeId)
	local ids = self._seasonGainedPrizeIds[seasonId]

	return (ids or nil) and (ids[prizeId] or false)
end

function OriMatGameModel:isEnoughPrizeInSeason(seasonId, prizeId)
	local seasonData = OriMatGameConfig.instance:getSeasonData(seasonId)

	if seasonData then
		if not seasonData.prizePlanId then
			local prizePlanId = 0
			local data = OriMatGameConfig.instance:getPrizeCfg(prizePlanId, prizeId)

			if data then
				if not data.totalWaveNum then
					local need = 0
					local cur = self:getWaveInSeason(seasonId)

					return need <= cur
				end
			end
		end
	end
end

function OriMatGameModel:isCanGainPrizeInSeason(seasonId, prizeId)
	if self:isHasGainPrizeInSeason(seasonId, prizeId) or not self:isEnoughPrizeInSeason(seasonId, prizeId) then
		return false
	end

	return true
end

function OriMatGameModel:isCanGainPrizeOfSeason(seasonId)
	local seasonData = OriMatGameConfig.instance:getSeasonData(seasonId)

	if seasonData then
		if not seasonData.prizePlanId then
			local prizePlanId = 0
			local prizeCfgs = OriMatGameConfig.instance:getPrizeCfgs(prizePlanId)

			if prizeCfgs then
				for _, data in ipairs(prizeCfgs) do
					if self:isCanGainPrizeInSeason(seasonId, data.prizeId) then
						return true
					end
				end
			end

			return false
		end
	end
end

OriMatGameModel.instance = OriMatGameModel.New()

return OriMatGameModel
