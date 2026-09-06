-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/model/IdleGameModel.lua

module("logic.extensions.idlegame.model.IdleGameModel", package.seeall)

local IdleGameModel = class("IdleGameModel", BaseModel)

function IdleGameModel:ctor()
	return
end

function IdleGameModel:onInit()
	self:onReset()
end

function IdleGameModel:onReset()
	self._rankData = {}
	self._rankData.infos = {}
	self.activityPrizes = nil
	self.activityId = nil
end

function IdleGameModel:onAddMoney(val)
	if self._moneyInfo ~= nil then
		self._moneyInfo.curMoney = self._moneyInfo.curMoney + val
		self._moneyInfo.totalMoney = self._moneyInfo.totalMoney + val
	end

	self:_logMoney()
end

function IdleGameModel:handlePM_XiaoNuoPlaceInfoRes(msg)
	self._moneyInfo = msg.moneyInfo
	self._members = msg.members
	self._prizes = msg.prizes

	self:_initBuyPriceMap(msg.prices)

	self._maxLevel = checknumber(msg.maxLevel)
	self.activityPrizes = msg.activityPrizes
	self.activityId = msg.activityId
end

function IdleGameModel:handlePM_XiaoNuoOnPlayerReconnectRes(msg)
	self._moneyInfo = msg.moneyInfo

	self:_logMoney()
end

function IdleGameModel:getIsNeedGuide()
	return self._maxLevel <= 1 and self:getMemberCount() <= 2
end

function IdleGameModel:handlePM_XiaoNuoBuyRes(msg, cost)
	if self._moneyInfo then
		self._moneyInfo.curMoney = self._moneyInfo.curMoney - cost

		local member = msg.member

		for _, v in ipairs(self._members) do
			if v.position == member.position then
				v.level = member.level
				self._prices[v.level] = checknumber(self._prices[v.level]) + 1
			end
		end

		self:_logMoney()
	end
end

function IdleGameModel:handlePM_XiaoNuoComposeRes(oldPos, msg)
	self._moneyInfo = msg.moneyInfo

	for _, v in ipairs(self._members) do
		if v.position == oldPos then
			v.level = 0
		end

		if v.position == msg.new_member.position then
			v.level = msg.new_member.level
		end
	end

	self._maxLevel = math.max(self._maxLevel, msg.new_member.level)

	self:_logMoney()
end

function IdleGameModel:handlePM_XiaoNuoOneKeyComposeRes(msg)
	self._moneyInfo = msg.moneyInfo
	self._members = msg.members

	for _, v in ipairs(self._members) do
		self._maxLevel = math.max(self._maxLevel, v.level)
	end
end

function IdleGameModel:handlePM_XiaoNuoOneKeyRes(oldPos, msg)
	for _, v in ipairs(self._members) do
		if v.position == oldPos then
			v.level = 0
		end

		if v.position == msg.position then
			v.level = msg.level
		end
	end

	self._maxLevel = math.max(self._maxLevel, msg.level)
end

function IdleGameModel:handlePM_XiaoNuoDiscardRes(discardPos, msg)
	self._moneyInfo = msg.moneyInfo

	for _, v in ipairs(self._members) do
		if v.position == discardPos then
			v.level = 0
		end
	end
end

function IdleGameModel:_initBuyPriceMap(prices)
	self._prices = {}

	for _, v in ipairs(prices) do
		self._prices[v.level] = v.times
	end
end

function IdleGameModel:getBuyTimes(level)
	if self._prices and self._prices[level] then
		return self._prices[level]
	else
		return 0
	end
end

function IdleGameModel:getBuyPrice(level)
	local cfg = IdleGameConfig.instance:getXiaoNuoPlaceCfg(level)

	if cfg ~= nil then
		local buyTimes = self:getBuyTimes(level)

		if buyTimes >= 1 then
			return checknumber(cfg.basePrice) + checknumber(cfg.priceChangeA) * buyTimes + checknumber(cfg.priceChangeB) * math.abs(buyTimes - 1)
		else
			return checknumber(cfg.basePrice)
		end
	else
		return 0
	end
end

function IdleGameModel:getCurMoney()
	if self._moneyInfo ~= nil then
		return checknumber(self._moneyInfo.curMoney)
	else
		return 0
	end
end

function IdleGameModel:getTotalMoney(toString)
	return (self._moneyInfo ~= nil or nil) and checknumber(self._moneyInfo.totalMoney)
end

function IdleGameModel:getCapacity()
	return 12
end

function IdleGameModel:getMemberCount()
	if self._members ~= nil then
		local count = 0

		for _, v in ipairs(self._members) do
			if v.level > 0 then
				count = count + 1
			end
		end

		return count
	else
		return 0
	end
end

function IdleGameModel:getPrizeReceived(id)
	if self._prizes ~= nil then
		return GameUtil.isBitOpenByDigit(self._prizes, id)
	else
		return false
	end
end

function IdleGameModel:setPrizeReceived(id)
	if self._prizes ~= nil then
		self._prizes = GameUtil.setBitByDigit(self._prizes, id, true)
	end
end

function IdleGameModel:getActPrizeReceived(id)
	if self.activityPrizes ~= nil then
		return GameUtil.isBitOpenByDigit(self.activityPrizes, id)
	else
		return false
	end
end

function IdleGameModel:setActPrizeReceived(id)
	if self.activityPrizes ~= nil then
		self.activityPrizes = GameUtil.setBitByDigit(self.activityPrizes, id, true)
	end
end

function IdleGameModel:getHasPrizeNotReceive()
	local t = IdleGameConfig.instance:getProgressPrizes()
	local totalMoney = self:getTotalMoney()

	for i = 1, #t do
		if not self:getPrizeReceived(t[i].id) and StringUtil.CompareTwoNumber(totalMoney, t[i].target) then
			return true
		end
	end

	return false
end

function IdleGameModel:getMoneyAddPerSec()
	if self._members ~= nil then
		local sum = 0

		for _, v in ipairs(self._members) do
			local cfg = IdleGameConfig.instance:getXiaoNuoPlaceCfg(v.level)

			if cfg ~= nil then
				sum = sum + checknumber(cfg.addMoePerSeconds)
			end
		end

		return sum
	else
		return 0
	end
end

function IdleGameModel:getMaxNuoLevel()
	return checknumber(self._maxLevel)
end

function IdleGameModel:getMaxBuyLevel()
	local maxLevel = self:getMaxNuoLevel()
	local cfg = IdleGameConfig.instance:getXiaoNuoPlaceCfg(maxLevel)

	if cfg ~= nil then
		return checknumber(cfg.canBuyMaxLevel)
	else
		return 0
	end
end

function IdleGameModel:getMaxBuyPrice()
	local maxBuyLevel = self:getMaxBuyLevel()

	return self:getBuyPrice(maxBuyLevel)
end

function IdleGameModel:getMembers()
	return self._members
end

function IdleGameModel:getNextProgressCfg()
	local t = IdleGameConfig.instance:getProgressPrizes()
	local totalMoney = self:getTotalMoney()
	local i = 1

	while i <= #t and StringUtil.CompareTwoNumber(totalMoney, t[i].target) do
		i = i + 1
	end

	if i > #t then
		return nil
	else
		return t[i]
	end
end

function IdleGameModel:getNextProgressNeedMoney()
	local cfg = self:getNextProgressCfg()

	if cfg ~= nil then
		return checknumber(cfg.target)
	else
		return 0
	end
end

function IdleGameModel:getIsGameOpen()
	return true
end

function IdleGameModel:_logMoney()
	if self:getCurMoney() <= 0 and self._moneyInfo ~= nil then
		self._moneyInfo.curMoney = 0
	end
end

function IdleGameModel:setRankData(msg)
	self._rankData.infos = {}

	for k, v in pairs(msg.info) do
		local single = {}

		single.headInfo = v.headInfo
		single.familyName = v.familyName
		single.rank = v.rank
		single.totalMoney = v.totalMoney

		table.insert(self._rankData.infos, single)

		if #self._rankData.infos >= msg.rankSize then
			break
		end
	end

	self._rankData.rank = msg.rank
	self._rankData.rankSize = msg.rankSize
end

function IdleGameModel:getRankData()
	return self._rankData
end

IdleGameModel.instance = IdleGameModel.New()

return IdleGameModel
