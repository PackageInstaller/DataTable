-- chunkname: @modules/logic/summon/model/SummonLuckyBagModel.lua

module("modules.logic.summon.model.SummonLuckyBagModel", package.seeall)

local SummonLuckyBagModel = class("SummonLuckyBagModel", BaseModel)

function SummonLuckyBagModel:isLuckyBagOpened(poolId, luckyBagId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.luckyBagMO then
		return summonServerMO.luckyBagMO:isOpened(luckyBagId)
	end

	return false
end

function SummonLuckyBagModel:getGachaRemainTimes(poolId)
	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)
	local times = SummonConfig.getSummonSSRTimes(poolCo)
	local luckyBagList = SummonConfig.instance:getSummonLuckyBag(poolId)

	if luckyBagList and next(luckyBagList) then
		if summonServerMO and summonServerMO.luckyBagMO then
			local totalCount = #luckyBagList
			local remainBagCount = math.max(0, totalCount - summonServerMO.luckyBagMO.getTimes)
			local remainCount = remainBagCount * times - summonServerMO.luckyBagMO.notSSRCount

			return math.max(0, remainCount)
		else
			return 0
		end
	else
		return 0
	end
end

function SummonLuckyBagModel:isLuckyBagGot(poolId, luckyBagId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.luckyBagMO then
		return summonServerMO.luckyBagMO:isGot(luckyBagId)
	end

	return false
end

function SummonLuckyBagModel:getLuckyGodCount(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.luckyBagMO then
		return summonServerMO.luckyBagMO.getTimes
	end

	return 0
end

function SummonLuckyBagModel:needAutoPopup(poolId, luckyBagId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if not playerInfo or playerInfo.userId == 0 then
		return nil
	end

	local localKey = string.format("LuckyBagAutoPopup_%s_%s_%s", playerInfo.userId, poolId, luckyBagId)

	if string.nilorempty(PlayerPrefsHelper.getString(localKey, "")) then
		return true
	end

	return false
end

function SummonLuckyBagModel:recordAutoPopup(poolId, luckyBagId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if not playerInfo or playerInfo.userId == 0 then
		return nil
	end

	local localKey = string.format("LuckyBagAutoPopup_%s_%s_%s", playerInfo.userId, poolId, luckyBagId)

	PlayerPrefsHelper.setString(localKey, "1")
end

SummonLuckyBagModel.instance = SummonLuckyBagModel.New()

return SummonLuckyBagModel
