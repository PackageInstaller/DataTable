-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/data/OriMatGameSubMo.lua

module("logic.extensions.orimatgame.data.OriMatGameSubMo", package.seeall)

local OriMatGameSubMo = class("OriMatGameSubMo")

function OriMatGameSubMo:ctor(seasonId)
	self._seasonId = seasonId

	local seasonData = OriMatGameConfig.instance:getSeasonData(seasonId)

	if seasonData then
		self._prizePlanId = seasonData.prizePlanId or 0
	end

	if seasonData then
		self._stagePlanId = seasonData.stagePlanId or 0
	end

	self._oldWeaponIds = {}

	local seasonDataList = OriMatGameConfig.instance:getSeasonDataList()

	for seasonId = 1, self._seasonId - 1 do
		local data = OriMatGameConfig.instance:getSeasonData(seasonId)

		if data then
			if not data.weaponPlanId then
				local weaponPlanId = 0
				local weaponCfgs = OriMatGameConfig.instance:getWeaponPlanCfg(weaponPlanId)

				if weaponCfgs then
					if not weaponCfgs.weaponIdList then
						local weaponIdList = {}

						for i, v in ipairs(weaponIdList) do
							self._oldWeaponIds[v] = v
						end
					end
				end
			end
		end
	end

	self:_resetData()
end

function OriMatGameSubMo:_resetData()
	self._stageWaves = {}
	self._unlockTalentIds = {}
	self._curClientKey = nil
	self._curServerKey = nil
	self._gainedPrizeIds = {}
	self._reOpenSeasonIds = {}
end

function OriMatGameSubMo:dispose()
	self:_resetData()
end

function OriMatGameSubMo:handlePM_OriginMaterialGameInfoRes(msg)
	self._stageWaves = {}

	for i, v in ipairs(msg.stages) do
		self._stageWaves[v.stageId] = v.waveId
	end

	self._unlockTalentIds = {}

	for _, v in ipairs(msg.unlockTalentIds) do
		self._unlockTalentIds[v] = v
	end

	self._gainedPrizeIds = {}

	for i, v in ipairs(msg.gainedPrizeIds) do
		self._gainedPrizeIds[v] = v
	end

	self._reOpenSeasonIds = {}

	for i, v in ipairs(msg.reOpenSeasonIds) do
		self._reOpenSeasonIds[v] = v
	end

	self._leftReOpenTimes = msg.leftReOpenTimes
	self._totalReOpenTimes = msg.totalReOpenTimes
end

function OriMatGameSubMo:handlePM_OriginMaterialGameStartRes(msg)
	self._curServerKey = msg.serverKey
end

function OriMatGameSubMo:handlePM_OriginMaterialGameEndRes(msg)
	self._curClientKey = nil
	self._curServerKey = nil

	if msg.isPass then
		local stageId = msg.stageId
		local waveId = msg.waveId

		self._stageWaves[stageId] = self._stageWaves[stageId] or Mathf.Max(self._stageWaves[stageId], waveId)
	end
end

function OriMatGameSubMo:handlePM_OriginMaterialGameGainPrizeRes(msg)
	for _, prizeId in ipairs(msg.prizeIds) do
		self._gainedPrizeIds[prizeId] = prizeId
	end
end

function OriMatGameSubMo:handlePM_OriginMaterialGameUnlockTalentRes(msg)
	local talentId = msg.talentId

	self._unlockTalentIds[talentId] = talentId
end

function OriMatGameSubMo:handlePM_OriginMaterialGameReOpenSeasonRes(msg)
	local reOpenSeasonId = msg.reOpenSeasonId

	self._reOpenSeasonIds[reOpenSeasonId] = reOpenSeasonId
	self._leftReOpenTimes = msg.leftReOpenTimes
	self._totalReOpenTimes = msg.totalReOpenTimes
end

function OriMatGameSubMo:getStageWaves()
	return self._stageWaves
end

function OriMatGameSubMo:getStageWaveById(stageId)
	return self._stageWaves[stageId] or 0
end

function OriMatGameSubMo:getTotalWaveNum()
	local num = 0

	for k, v in pairs(self._stageWaves) do
		num = num + v
	end

	return num
end

function OriMatGameSubMo:getUnlockTalentIds()
	return self._unlockTalentIds
end

function OriMatGameSubMo:isUnlockTalent(talentId)
	return self._unlockTalentIds[talentId] ~= nil
end

function OriMatGameSubMo:isInTimeOfStage(stageId)
	local data = OriMatGameConfig.instance:getStageCfgByStageId(self._stagePlanId, stageId)
	local startTime = data and data.startTime

	return GameUtil.getTimePeriod(startTime, nil) == GameUtil.inTimePeriod
end

function OriMatGameSubMo:generateClientKey()
	self._curClientKey = MmUtil.createClientKey()

	return self._curClientKey
end

function OriMatGameSubMo:getClientKey()
	return self._curClientKey
end

function OriMatGameSubMo:getEncryptedKey(isPass, secParam)
	local temPass = isPass and 1 or 0

	return (GameUtil.getClientEncryptedKey(self._curClientKey, self._curServerKey, {
		temPass,
		secParam
	}))
end

function OriMatGameSubMo:isCanGetPrizeInSeason()
	local result = false
	local cfg = OriMatGameConfig.instance:getPrizeCfgs(self._prizePlanId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrize(data.prizeId) then
				result = true

				break
			end
		end
	end

	return result
end

function OriMatGameSubMo:getPrizeState(prizeId)
	if self:isHasGainPrize(prizeId) then
		return GameEnum.PrizeState.IsHasGain
	elseif not self:isEnoughPrize(prizeId) then
		return GameEnum.PrizeState.IsNotEnough
	else
		return GameEnum.PrizeState.IsCanGet
	end
end

function OriMatGameSubMo:isHasGainPrize(prizeId)
	return self._gainedPrizeIds[prizeId] ~= nil
end

function OriMatGameSubMo:isEnoughPrize(prizeId)
	local data = OriMatGameConfig.instance:getPrizeCfg(self._prizePlanId, prizeId)

	if data then
		if not data.totalWaveNum then
			local need = 0
			local cur = self:getTotalWaveNum()

			return need <= cur
		end
	end
end

function OriMatGameSubMo:isCanGetPrize(prizeId)
	local state = self:getPrizeState(prizeId)

	return state == GameEnum.PrizeState.IsCanGet
end

function OriMatGameSubMo:isNewWeapon(weaponId)
	if self._seasonId <= 1 then
		return false
	end

	return self._oldWeaponIds[weaponId] == nil
end

function OriMatGameSubMo:getReOpenSeasonIds()
	return self._reOpenSeasonIds
end

function OriMatGameSubMo:getReOpenNum()
	return table.nums(self._reOpenSeasonIds)
end

function OriMatGameSubMo:isReOpenSeason(seasonId)
	return self._reOpenSeasonIds[seasonId] ~= nil
end

function OriMatGameSubMo:getLeftReOpenTimes()
	return self._leftReOpenTimes
end

function OriMatGameSubMo:getTotalReOpenTimes()
	return self._totalReOpenTimes
end

return OriMatGameSubMo
