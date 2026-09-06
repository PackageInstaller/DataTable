-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/data/IslandStationMo.lua

module("logic.extensions.islandstation.data.IslandStationMo", package.seeall)

local IslandStationMo = class("IslandStationMo")

function IslandStationMo:ctor(activityId)
	self._activityId = activityId
	self._gainPrizeIds = {}
	self._shopInfos = {}
	self._chatMgr = GoddessShopChatMgr.New(self._activityId)
end

function IslandStationMo:dispose()
	if self._chatMgr then
		self._chatMgr:dispose()

		self._chatMgr = nil
	end
end

function IslandStationMo:handlePM_SurroundByDreamGirlInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)

	table.clear(self._shopInfos)

	for i, v in ipairs(msg.shopInfo) do
		self._shopInfos[v.girlId] = v
	end
end

function IslandStationMo:handlePM_SurroundByDreamGirlChatRes(msg)
	local times = self:getTodayChatTimesInShop(msg.girlId)

	self:_updateValueInShop(msg.girlId, "todayChatTimes", Mathf.Max(times + 1, 0))
end

function IslandStationMo:handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	if type(msg) ~= "table" then
		msg = GameUtil.pbToTable(msg)
	end

	if msg.changeInfo then
		local girlId = msg.changeInfo.girlIdAndFetter.left
		local fetter = msg.changeInfo.girlIdAndFetter.right

		self:_updateValueInShop(girlId, "fetter", fetter)
	end
end

function IslandStationMo:getTodayChatTimesInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.todayChatTimes or 0)
end

function IslandStationMo:getMaxChatTimesInShop(girlId)
	local data = GoddessShopConfig.instance:getGirlData(self._activityId, girlId)

	return (data or nil) and (data.dailyChatTimes or 0)
end

function IslandStationMo:getLeftChatTimesInShop(girlId)
	local cur = self:getTodayChatTimesInShop(girlId)
	local max = self:getMaxChatTimesInShop(girlId)

	return Mathf.Max(max - cur, 0)
end

function IslandStationMo:getFetterInShop(girlId)
	local info = self:getShopInfo(girlId)

	return (info or nil) and (info.fetter or 0)
end

function IslandStationMo:getShopInfo(girlId)
	return self._shopInfos[girlId]
end

function IslandStationMo:_updateValueInShop(girlId, field, value)
	self._shopInfos[girlId] = self._shopInfos[girlId] or {}
	self._shopInfos[girlId][field] = value

	if field == "investLv" then
		-- block empty
	elseif field == "fetter" then
		-- block empty
	end
end

function IslandStationMo:getNewestLvInProgress()
	local result = 1

	for i, v in ipairs(self._gainPrizeIds) do
		result = Mathf.Max(result, v)
	end

	return result
end

function IslandStationMo:isHasGainPrizeInProgress(prizeId)
	return table.indexof(self._gainPrizeIds, prizeId) ~= false
end

function IslandStationMo:getChatMgr()
	return self._chatMgr
end

return IslandStationMo
