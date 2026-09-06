-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/model/LiYangKingModel.lua

module("logic.extensions.liyangking.model.LiYangKingModel", package.seeall)

local LiYangKingModel = class("LiYangKingModel", BaseModel)

function LiYangKingModel:onInit()
	self:onReset()
end

function LiYangKingModel:onReset()
	self._infos = {}
	self._chapter3InfoMap = {}
	self._changeSetIdList = {}
	self._saveBottleMoney = 0
	self._playLevelUpEffBuildId = nil
end

function LiYangKingModel:clearLevelUpEffBuildId()
	self._playLevelUpEffBuildId = nil
end

function LiYangKingModel:getLevelUpEffBuildId()
	return self._playLevelUpEffBuildId
end

function LiYangKingModel:setLevelUpEffBuildId(buildId)
	self._playLevelUpEffBuildId = buildId
end

function LiYangKingModel:getInfo(activityId)
	return self._infos[activityId]
end

function LiYangKingModel:getClgInfo(activityId)
	return self._chapter3InfoMap[activityId]
end

function LiYangKingModel:getSaveBottleMoneyMap()
	return self._saveBottleMoney
end

function LiYangKingModel:setSaveBottleMoneyMap(saveBottleMoney)
	self._saveBottleMoney = saveBottleMoney
end

function LiYangKingModel:pushChangeSetId(changeSetId)
	table.insert(self._changeSetIdList, changeSetId)
end

function LiYangKingModel:popChangeSetId()
	if #self._changeSetIdList > 0 then
		local length = #self._changeSetIdList
		local changeSetId = self._changeSetIdList[length]

		table.remove(self._changeSetIdList, length)

		return changeSetId
	end
end

function LiYangKingModel:handlePM_PrinceLiyangInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.buildingsMap = {}

	for i, buildInfo in ipairs(msg.hanging.buildings) do
		info.buildingsMap[buildInfo.buildingId] = buildInfo
	end

	info.attributesMap = {}

	for i, attrInfo in ipairs(msg.hanging.attributes) do
		info.attributesMap[attrInfo.id] = attrInfo
	end
end

function LiYangKingModel:handlePM_PrinceLiyangUnlockBuildingRes(msg)
	local info = self._infos[msg.activityId]

	for i, buildInfo in ipairs(msg.hanging.buildings) do
		info.buildingsMap[buildInfo.buildingId] = buildInfo
	end

	for i, attrInfo in ipairs(msg.hanging.attributes) do
		info.attributesMap[attrInfo.id] = attrInfo
	end
end

function LiYangKingModel:handlePM_PrinceLiyangUpgradeBuildingRes(msg)
	local info = self._infos[msg.activityId]

	info.hanging = msg.hanging

	for i, buildInfo in ipairs(msg.hanging.buildings) do
		info.buildingsMap[buildInfo.buildingId] = buildInfo
	end

	for i, attrInfo in ipairs(msg.hanging.attributes) do
		info.attributesMap[attrInfo.id] = attrInfo
	end

	self:setLevelUpEffBuildId(msg.buildingId)
end

function LiYangKingModel:handlePM_NotifyPrinceLiyangChangeRes(msg)
	local info = self._infos[msg.activityId]

	if info then
		info.curScore = msg.curScore
		info.hanging = msg.hanging

		for i, buildInfo in ipairs(msg.hanging.buildings) do
			info.buildingsMap[buildInfo.buildingId] = buildInfo
		end

		for i, attrInfo in ipairs(msg.hanging.attributes) do
			info.attributesMap[attrInfo.id] = attrInfo
		end
	end
end

function LiYangKingModel:handlePM_PrinceLiyangHandleEventRes(msg)
	local info = self._infos[msg.activityId]
	local idx = table.indexof(info.eventIds, msg.eventId)

	table.remove(info.eventIds, idx)
end

function LiYangKingModel:handlePM_PrinceLiyangOneKeyGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainedPrizeIds = nil
end

function LiYangKingModel:handlePM_PrinceLiyangClgInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	self._chapter3InfoMap[info.activityId] = info
end

LiYangKingModel.instance = LiYangKingModel.New()

return LiYangKingModel
