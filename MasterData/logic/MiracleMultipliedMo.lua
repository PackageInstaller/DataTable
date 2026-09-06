-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/data/MiracleMultipliedMo.lua

module("logic.extensions.miraclemultiplied.data.MiracleMultipliedMo", package.seeall)

local MiracleMultipliedMo = class("MiracleMultipliedMo")

function MiracleMultipliedMo:ctor(activityId)
	self._activityId = activityId
	self._raceCfg = MiracleMultipliedConfig.instance:getRaceCfg(self._activityId)
	self._collectCfg = MiracleMultipliedConfig.instance:getCollectCfg(self._activityId)
	self._raceIdList = {}

	for _, data in pairs(self._raceCfg) do
		table.insert(self._raceIdList, data.raceId)
	end

	self._collectInfoDic = {}
end

function MiracleMultipliedMo:getActivityId()
	return self._activityId
end

function MiracleMultipliedMo:handlePM_MiracleMultipliedGetInfoRes(msg)
	table.clear(self._collectInfoDic)

	for i, v in ipairs(msg.collectInfoList) do
		self._collectInfoDic[v.collectId] = v
	end
end

function MiracleMultipliedMo:handlePM_MiracleMultipliedUnlockRes(msg)
	local collectInfo = msg.collectInfo

	self._collectInfoDic[collectInfo.collectId] = collectInfo
end

function MiracleMultipliedMo:handlePM_MiracleMultipliedGainPrizeRes(msg)
	local collectInfo = msg.collectInfo

	self._collectInfoDic[collectInfo.collectId] = collectInfo
end

function MiracleMultipliedMo:getCollectInfo(collectId)
	return self._collectInfoDic[collectId]
end

function MiracleMultipliedMo:isUnlockInCollect(collectId)
	local info = self:getCollectInfo(collectId)

	return (info or nil) and (info.isUnlock or false)
end

function MiracleMultipliedMo:getPrizeInCollect(collectId)
	local info = self:getCollectInfo(collectId)

	return (info or nil) and (info.prize or "")
end

function MiracleMultipliedMo:getPrizeArrInCollect(collectId)
	local str = self:getPrizeInCollect(collectId)

	if not string.nilorempty(str) then
		return string.split(str, "#")
	else
		return {}
	end
end

function MiracleMultipliedMo:getUnlockCountInCollect()
	local count = 0

	for _, data in ipairs(self._collectCfg) do
		if self:isUnlockInCollect(data.collectId) then
			count = count + 1
		end
	end

	return count
end

function MiracleMultipliedMo:isEnoughTimesToUnlockInCollect()
	local raceActCount = self:getRaceActCount()
	local unlockCount = self:getUnlockCountInCollect()

	return unlockCount < raceActCount
end

function MiracleMultipliedMo:getRaceIdList()
	return self._raceIdList
end

function MiracleMultipliedMo:getRaceCount()
	return #self._raceIdList
end

function MiracleMultipliedMo:getRaceActCount()
	local count = 0

	for _, raceId in ipairs(self._raceIdList) do
		if self:isHasPet(raceId) then
			count = count + 1
		end
	end

	return count
end

function MiracleMultipliedMo:isHasPet(raceId)
	return HandbookModel.instance:isHasPet(raceId)
end

return MiracleMultipliedMo
