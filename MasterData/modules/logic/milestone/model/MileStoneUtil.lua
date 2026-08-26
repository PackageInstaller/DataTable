-- chunkname: @modules/logic/milestone/model/MileStoneUtil.lua

module("modules.logic.milestone.model.MileStoneUtil", package.seeall)

local MileStoneUtil = {}

function MileStoneUtil.getBonusState(mileStoneId, bonusId)
	if MileStoneUtil.isBonusHasGet(mileStoneId, bonusId) then
		return MileStoneEnum.BonusState.HasGet
	end

	if MileStoneUtil.isBonusCanGet(mileStoneId, bonusId) then
		return MileStoneEnum.BonusState.CanGet
	end

	return MileStoneEnum.BonusState.CanNotGet
end

function MileStoneUtil.isBonusHasGet(mileStoneId, bonusId)
	local data = MileStoneModel.instance:getById(mileStoneId)

	if not data then
		return
	end

	return data:isBonusHasGet(bonusId)
end

function MileStoneUtil.isBonusCanGet(mileStoneId, bonusId)
	local data = MileStoneModel.instance:getById(mileStoneId)

	if not data then
		return
	end

	if MileStoneUtil.isBonusHasGet(mileStoneId, bonusId) then
		return false
	end

	local curProgress = MileStoneUtil.getMileStoneProgress(mileStoneId)
	local config = MileStoneConfig.instance:getBonusConfig(mileStoneId, bonusId)

	return curProgress >= config.needProgress
end

function MileStoneUtil.getMileStoneProgress(mileStoneId)
	local config = MileStoneConfig.instance:getMileStoneConfig(mileStoneId)

	if not config then
		return
	end

	return MileStoneUtil.getMileStoneProgressByType(config.type)
end

function MileStoneUtil.getMileStoneProgressByType(type)
	if type == MileStoneEnum.MileStoneType.SP02OutSide then
		return MileStoneUtil.getMileStoneProgress_SP02OutSide()
	end

	if type == MileStoneEnum.MileStoneType.V3a9Racing then
		return MileStoneUtil.getMileStoneProgress_V3a9Racing()
	end

	if type == MileStoneEnum.MileStoneType.V3a9BossRush then
		return MileStoneUtil.getMileStoneProgress_V3a9BossRush()
	end

	return 0
end

function MileStoneUtil.getMileStoneProgress_SP02OutSide()
	return AtomicDungeonModel.instance:getPolygonProgress()
end

function MileStoneUtil.getMileStoneProgress_V3a9Racing()
	return V3a9RacingCarEpisodeModel.instance:getTotalStar()
end

function MileStoneUtil.getMileStoneProgress_V3a9BossRush()
	return V3a9_BossRushModel.instance:getBonusProgress()
end

return MileStoneUtil
