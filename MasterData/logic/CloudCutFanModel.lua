-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/model/CloudCutFanModel.lua

module("logic.extensions.cloudcutfan.model.CloudCutFanModel", package.seeall)

local CloudCutFanModel = class("CloudCutFanModel", BaseModel)

function CloudCutFanModel:onInit()
	self:onReset()
end

function CloudCutFanModel:onReset()
	self._infoMap = {}
end

function CloudCutFanModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local unLockFanMap = {}
	local gainedPrizeIdMap = {}

	if data.gainedPrizeIds then
		for _, prizeId in ipairs(data.gainedPrizeIds) do
			gainedPrizeIdMap[prizeId] = true
		end

		data.gainedPrizeIdMap = gainedPrizeIdMap
	end

	if data.unLockFan then
		for _, fanId in ipairs(data.unLockFan) do
			unLockFanMap[fanId] = true
		end
	end

	data.unLockFanMap = unLockFanMap
	self._infoMap[activityId] = data
end

function CloudCutFanModel:onMakeFan(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not data.fanId then
			if data.fanId == -1 then
				return
			end

			if not info.unLockFanMap then
				local unLockFanMap = {}
				local isNew = unLockFanMap[data.fanId] ~= true

				unLockFanMap[data.fanId] = true
				info.unLockFanMap = unLockFanMap

				if isNew then
					info.todayCraftUsedCount = (info.todayCraftUsedCount or 0) + 1
				end
			end
		end
	end
end

function CloudCutFanModel:onUnLockFace(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.todayRepairedFace = true
		info.unLockFace = (info.unLockFace or 0) + 1
	end
end

function CloudCutFanModel:onGetRewardPrize(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		local gainedPrizeIdMap = {}

		if data.gainedPrizeIds then
			for _, prizeId in ipairs(data.gainedPrizeIds) do
				gainedPrizeIdMap[prizeId] = true
			end
		end

		info.gainedPrizeIds = data.gainedPrizeIds or {}
		info.gainedPrizeIdMap = gainedPrizeIdMap
	end
end

function CloudCutFanModel:onNotifyBossClg(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.lastClgResult = data

		if not data.isPreview then
			info.todayUsedChallengeCount = (info.todayUsedChallengeCount or 0) + 1

			local oldMaxDamage = checknumber(info.todayMaxDamage)
			local newDamage = checknumber(data.damage)

			if oldMaxDamage < newDamage then
				info.todayMaxDamage = newDamage
			end
		end
	end
end

function CloudCutFanModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function CloudCutFanModel:isFanUnlocked(activityId, fanId)
	local info = self._infoMap[activityId]

	if info and info.unLockFanMap then
		return info.unLockFanMap[fanId] == true
	end

	return false
end

function CloudCutFanModel:isRewardPrizeGained(activityId, prizeId)
	local info = self._infoMap[activityId]

	if info and info.gainedPrizeIdMap then
		return info.gainedPrizeIdMap[prizeId] == true
	end

	return false
end

function CloudCutFanModel:getUnLockFaceId(activityId)
	local info = self._infoMap[activityId]

	if info then
		return checknumber(info.unLockFace)
	end

	return 0
end

function CloudCutFanModel:getTotalUnlockCount(activityId)
	local count = 0
	local info = self._infoMap[activityId]

	if info then
		count = checknumber(info.unLockFace) + count

		if not info.unLockFanMap then
			for _, isUnlocked in pairs(info.unLockFanMap) do
				if isUnlocked then
					count = count + 1
				end
			end
		end
	end

	return count
end

function CloudCutFanModel:getLastClgResult(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.lastClgResult
	end
end

CloudCutFanModel.instance = CloudCutFanModel.New()

return CloudCutFanModel
