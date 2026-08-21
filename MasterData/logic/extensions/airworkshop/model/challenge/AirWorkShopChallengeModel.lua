-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/challenge/AirWorkShopChallengeModel.lua

module("logic.extensions.airworkshop.model.challenge.AirWorkShopChallengeModel", package.seeall)

local M = class("AirWorkShopChallengeModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._playerRodeoInfo = nil

	self:clearRankList()
	self:setWeeklyReward(nil)
	self:setRodeoSettle(nil)
end

function M:updateRodeoInfoFromServer(msg)
	local infoMo = self:getPlayerInfoMo()

	if not infoMo then
		self._playerRodeoInfo = AirWorkShopChallengeMo.New()
		infoMo = self._playerRodeoInfo
	end

	infoMo:updateFromServer(msg)

	if infoMo:getHadOff() then
		AirWorkShopRecordModel.instance:setDataDirty(true)
	end
end

function M:getPlayerInfoMo()
	return self._playerRodeoInfo
end

function M:getCurLvGradeStr()
	local str
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		str = AirWorkShopUtil.getRodeoLvGradeName(infoMo:getLv())
	end

	return str
end

function M:getMaxOfWeek()
	local maxOfWeek = 0
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		maxOfWeek = infoMo:getMaxOfWeek()
	end

	return maxOfWeek
end

function M:getLastSettleWeek()
	local week = 0
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		week = infoMo:getWeek()
	end

	return week
end

function M:getLvState()
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		return infoMo:getState()
	end

	return nil
end

function M:getIsChallengeNumMax()
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		return infoMo:getChallengeNumIsFull()
	else
		return true
	end
end

function M:getCurChallengeNum()
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		return infoMo:getChallengeNum()
	else
		return 0
	end
end

function M:getLastChallengeNumRecoverTime()
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		return infoMo:getLastChallengeNumRecoverTime()
	else
		return 0
	end
end

function M:getContinueWinRewardLst(lv)
	local rewardWinCount = {
		2,
		3,
		5
	}
	local rewardLstTotal = {}
	local lvCfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirAtkPoint, lv)
	local rewardIds = lvCfg and lvCfg.contWinReward or {}

	if #rewardWinCount ~= #rewardIds then
		printError(string.format("空气工坊-竞技模式,等级[%s]连胜奖励长度不匹配", lv))
	end

	for index, _rewardId in ipairs(rewardIds or {}) do
		local rewardList = {}
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(_rewardId)

		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			if not v.pool then
				table.insert(rewardList, v)
			end
		end

		if #rewardList > 0 and rewardWinCount[index] then
			local itemDataShow = ItemUtil.createItemData({
				itemId = rewardList[1].code,
				count = rewardList[1].num
			})

			table.insert(rewardLstTotal, {
				winCount = rewardWinCount[index],
				itemDataShow = itemDataShow
			})
		end
	end

	return rewardLstTotal
end

function M:setWeeklyReward(GainItemsData)
	self._weekRewardGainItemsData = GainItemsData
end

function M:getWeeklyRewardItem()
	if self._weekRewardGainItemsData then
		return self._weekRewardGainItemsData.addItemsBeforeConvert
	end

	return {}
end

function M:tryPopWeeklyRewardItemConvertView()
	local GainItemsData = self._weekRewardGainItemsData

	if GainItemsData and #GainItemsData.firstRepeatUseItems ~= 0 then
		ItemConvertController.instance:setOptType(GainItemsData.originPushInfo.optType)
		ItemConvertController.instance:setCacheSourceMOList(GainItemsData.firstRepeatUseItems)
		ItemConvertController.instance:setCacheItemMOList(GainItemsData.repeatAddItems)
	end

	self:setWeeklyReward(nil)
end

function M:setRodeoSettle(isSettle)
	self._isRodeoSettle = isSettle
end

function M:getRodeoSettle()
	return self._isRodeoSettle
end

function M:isFirstRewardReceive(lv)
	local infoMo = self:getPlayerInfoMo()

	if infoMo then
		return infoMo:isFirstRewardReceive(lv)
	else
		return false
	end
end

function M:clearRankList()
	self._rodeoRankList = {}
end

function M:updateRankFromServer(rankReqInfo)
	local week = rankReqInfo.week
	local part = rankReqInfo.part

	if not self._rodeoRankList[week] then
		self._rodeoRankList[week] = {}
	end

	if not self._rodeoRankList[week][part] then
		self._rodeoRankList[week][part] = AirWorkShopRodeoRankPartMo.New()
	end

	self._rodeoRankList[week][part]:updateFromServer(rankReqInfo)
	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_RANK_CHANGE)
end

function M:getRodeoRankPartMo(week, part)
	if self._rodeoRankList and self._rodeoRankList[week] and self._rodeoRankList[week][part] then
		return self._rodeoRankList[week][part]
	end

	if enableLog then
		printWarn(string.format("没有week[%s]part[%s]的排行榜数据", week, part))
	end

	return nil
end

function M:clearRodeoRankPartMo(week, part)
	if not self._rodeoRankList then
		return
	end

	if part then
		if self._rodeoRankList[week] then
			self._rodeoRankList[week][part] = nil
		end
	else
		self._rodeoRankList[week] = nil
	end
end

function M:getRankListCount(week, part)
	local partMo = self:getRodeoRankPartMo(week, part)
	local count = partMo and partMo:getRankListCount() or 0
	local maxCount = partMo and partMo:getMaxShowRankCount() or AirWorkShopEnum.DefaultMaxRankShow
	local isMax = maxCount <= count

	return count, isMax
end

function M:getMaxShowRankCount(week, part)
	local partMo = self:getRodeoRankPartMo(week, part)
	local maxCount = partMo and partMo:getMaxShowRankCount() or AirWorkShopEnum.DefaultMaxRankShow

	return maxCount
end

function M:canReqNewRankDataFromServer(week, part)
	local partMo = self:getRodeoRankPartMo(week, part)

	if not partMo then
		return true
	end

	return partMo:canReqNewRankDataFromServer()
end

M.instance = M.New()

return M
