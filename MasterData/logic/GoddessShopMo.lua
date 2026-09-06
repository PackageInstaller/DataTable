-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/GoddessShopMo.lua

module("logic.extensions.goddessshop.data.GoddessShopMo", package.seeall)

local GoddessShopMo = class("GoddessShopMo")

function GoddessShopMo:ctor(activityId)
	self._activityId = activityId
	self._money = 0
	self._clientMoney = 0
	self._gainPrizeIds = {}
	self._shopInfos = {}
	self._totalMoneyAddSpeed = 0
	self._chatMgr = GoddessShopChatMgr.New(self._activityId)
end

function GoddessShopMo:dispose()
	if self._chatMgr then
		self._chatMgr:dispose()

		self._chatMgr = nil
	end
end

function GoddessShopMo:handlePM_SurroundByDreamGirlInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)

	self._money = msg.money
	self._clientMoney = msg.money
	self._gainPrizeIds = msg.gainPrizeIds or {}

	table.clear(self._shopInfos)

	for i, v in ipairs(msg.shopInfo) do
		self._shopInfos[v.girlId] = v
	end

	self:_onUpdateMoneyAddSpeedData()
end

function GoddessShopMo:handlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes(msg)
	table.insert(self._gainPrizeIds, msg.prizeId)
end

function GoddessShopMo:handlePM_SurroundByDreamGirlInvestRes(msg)
	self._money = msg.money
	self._clientMoney = msg.money

	self:_updateValueInShop(msg.girlId, "investLv", msg.investLv)
end

function GoddessShopMo:handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(msg)
	return
end

function GoddessShopMo:handlePM_SurroundByDreamGirlChatRes(msg)
	local times = self:getTodayChatTimesInShop(msg.girlId)

	self:_updateValueInShop(msg.girlId, "todayChatTimes", Mathf.Max(times + 1, 0))
end

function GoddessShopMo:handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	if type(msg) ~= "table" then
		msg = GameUtil.pbToTable(msg)
	end

	if msg.changeInfo then
		local girlId = msg.changeInfo.girlIdAndFetter.left
		local fetter = msg.changeInfo.girlIdAndFetter.right

		self._money = msg.changeInfo.money

		self:_updateValueInShop(girlId, "fetter", fetter)
	end
end

function GoddessShopMo:handlePM_SurroundByDreamGirlPresentGiftRes(msg)
	self:_updateValueInShop(msg.girlId, "fetter", msg.fetter)
end

function GoddessShopMo:getMoney()
	return self._money
end

function GoddessShopMo:getClientMoney()
	return self._clientMoney
end

function GoddessShopMo:updateClientMoney(money)
	self._clientMoney = money
end

function GoddessShopMo:getInvestLvInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.investLv or 0)
end

function GoddessShopMo:isCanInvestLvInShop(girlId)
	local cfg = GoddessShopConfig.instance:getGirlInvestCfg(self._activityId, girlId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanInvestLvInShopLevel(girlId, data.level) then
				return true
			end
		end
	end

	return false
end

function GoddessShopMo:isCanInvestLvInShopLevel(girlId, level)
	return not self:isHasReachInvestLvInShop(girlId, level) and self:isEnoughInvestLvInShop(girlId, level) and self:isHasReachInvestLvInShop(girlId, level - 1)
end

function GoddessShopMo:isHasReachInvestLvInShop(girlId, level)
	local cur = self:getInvestLvInShop(girlId)

	return level <= cur
end

function GoddessShopMo:isEnoughInvestLvInShop(girlId, level)
	return self:isEnoughFetterInvestLvInShop(girlId, level) and self:isEnoughCostInvestLvInShop(girlId, level)
end

function GoddessShopMo:isEnoughFetterInvestLvInShop(girlId, level)
	local data = GoddessShopConfig.instance:getGirlInvestData(self._activityId, girlId, level)

	if data then
		if not data.fetterLimit then
			local fetterLimit = 0
			local cur = self:getFetterInShop(girlId)

			return fetterLimit <= cur
		end
	end
end

function GoddessShopMo:isEnoughCostInvestLvInShop(girlId, level)
	local data = GoddessShopConfig.instance:getGirlInvestData(self._activityId, girlId, level)

	if data then
		if not data.cost then
			local cost = 0
			local cur = self:getClientMoney()

			return cost <= cur
		end
	end
end

function GoddessShopMo:getTodayChatTimesInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.todayChatTimes or 0)
end

function GoddessShopMo:getMaxChatTimesInShop(girlId)
	local data = GoddessShopConfig.instance:getGirlData(self._activityId, girlId)

	return (data or nil) and (data.dailyChatTimes or 0)
end

function GoddessShopMo:getLeftChatTimesInShop(girlId)
	local cur = self:getTodayChatTimesInShop(girlId)
	local max = self:getMaxChatTimesInShop(girlId)

	return Mathf.Max(max - cur, 0)
end

function GoddessShopMo:getFetterInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.fetter or 0)
end

function GoddessShopMo:getInvestValueInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.investLv or 0)
end

function GoddessShopMo:getShopInfo(girlId)
	return self._shopInfos[girlId]
end

function GoddessShopMo:_updateValueInShop(girlId, field, value)
	self._shopInfos[girlId] = self._shopInfos[girlId] or {}
	self._shopInfos[girlId][field] = value

	if field == "investLv" then
		self:_onUpdateMoneyAddSpeedData()
	elseif field == "fetter" then
		-- block empty
	end
end

function GoddessShopMo:_onUpdateMoneyAddSpeedData()
	self._totalMoneyAddSpeed = 0

	local cfg = GoddessShopConfig.instance:getGirlCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		local value = self:getMoneyAddSpeed(data.dreamGirlId)

		self._totalMoneyAddSpeed = self._totalMoneyAddSpeed + value
	end
end

function GoddessShopMo:getMoneyAddSpeed(girlId)
	local level = self:getInvestLvInShop(girlId)
	local investData = GoddessShopConfig.instance:getGirlInvestData(self._activityId, girlId, level)

	return (investData or nil) and (investData.moneyAddSpeed or 0)
end

function GoddessShopMo:getTotalMoneyAddSpeed()
	return self._totalMoneyAddSpeed
end

function GoddessShopMo:getNewestLvInProgress()
	local result = 1

	for i, v in ipairs(self._gainPrizeIds) do
		result = Mathf.Max(result, v)
	end

	return result
end

function GoddessShopMo:isHasGainPrizeInProgress(prizeId)
	return table.indexof(self._gainPrizeIds, prizeId) ~= false
end

function GoddessShopMo:isEnoughGetPrizeInProgress(prizeId, money)
	local data = GoddessShopConfig.instance:getMoneyProgressData(self._activityId, prizeId)

	if string.nilorempty(data.prize) then
		return false
	else
		return data and money >= data.progress or false
	end
end

function GoddessShopMo:isCanGetPrizeInProgress(prizeId, money)
	return not self:isHasGainPrizeInProgress(prizeId) and self:isEnoughGetPrizeInProgress(prizeId, money)
end

function GoddessShopMo:getChatMgr()
	return self._chatMgr
end

return GoddessShopMo
