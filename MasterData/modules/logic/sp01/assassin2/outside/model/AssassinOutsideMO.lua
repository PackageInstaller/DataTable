-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinOutsideMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinOutsideMO", package.seeall)

local AssassinOutsideMO = class("AssassinOutsideMO")

function AssassinOutsideMO:ctor()
	self:clearData()
end

function AssassinOutsideMO:clearData()
	if self._buildingMapMo then
		self._buildingMapMo:clearData()
	end

	self:clearAllQuestData()

	self.questMapDict = {}
	self._coin = nil
end

function AssassinOutsideMO:clearAllQuestData()
	if self.questMapDict then
		for _, mapMo in pairs(self.questMapDict) do
			mapMo:clearQuestData()
		end
	end

	self:setProcessingQuest()
end

function AssassinOutsideMO:updateAllInfo(buildingInfo, unlockMapIds, allQuestInfo, coin)
	self:clearData()

	local buildingMapMo = self:getBuildingMap()

	buildingMapMo:setInfo(buildingInfo)
	self:unlockQuestMapByList(unlockMapIds)
	self:updateAllQuestInfo(allQuestInfo)

	self._coin = coin
end

function AssassinOutsideMO:updateAllQuestInfo(allQuestInfo)
	self:clearAllQuestData()
	self:finishQuestByList(allQuestInfo.finishQuestIds)
	self:unlockQuestByList(allQuestInfo.currentQuestIds)
	self:setProcessingQuest(allQuestInfo.assassinQuestId)
end

function AssassinOutsideMO:getBuildingMap()
	self._buildingMapMo = self._buildingMapMo or AssassinBuildingMapMO.New()

	return self._buildingMapMo
end

function AssassinOutsideMO:unlockQuestMapByList(mapIdList)
	for _, unlockMapId in ipairs(mapIdList) do
		self:unlockQuestMap(unlockMapId)
	end
end

function AssassinOutsideMO:unlockQuestMap(mapId)
	local questMapMo = self.questMapDict[mapId]

	if questMapMo then
		return
	end

	questMapMo = AssassinQuestMapMO.New(mapId)
	self.questMapDict[mapId] = questMapMo
end

function AssassinOutsideMO:finishQuestByList(questList)
	for _, questId in ipairs(questList) do
		self:finishQuest(questId)
	end
end

function AssassinOutsideMO:finishQuest(questId)
	local mapId = AssassinConfig.instance:getQuestMapId(questId)
	local mapMo = mapId and self:getQuestMap(mapId)

	if not mapMo then
		logError(string.format("AssassinOutsideMO:finishQuest error, no mapMo, questId:%s", questId))

		return
	end

	mapMo:finishQuest(questId)
end

function AssassinOutsideMO:unlockQuestByList(questList)
	for _, questId in ipairs(questList) do
		self:unlockQuest(questId)
	end
end

function AssassinOutsideMO:unlockQuest(questId)
	local mapId = AssassinConfig.instance:getQuestMapId(questId)
	local mapMo = mapId and self:getQuestMap(mapId)

	if not mapMo then
		logError(string.format("AssassinOutsideMO:unlockQuest error, no mapMo, questId:%s", questId))

		return
	end

	mapMo:unlockQuest(questId)
end

function AssassinOutsideMO:updateCoinNum(coinNum)
	self._coin = coinNum
end

function AssassinOutsideMO:setProcessingQuest(questId)
	self._processingQuest = questId
end

function AssassinOutsideMO:getQuestMap(mapId)
	return self.questMapDict[mapId]
end

function AssassinOutsideMO:getQuestMapStatus(mapId)
	local mapMo = self:getQuestMap(mapId)

	return (mapMo or nil) and mapMo:getStatus()
end

function AssassinOutsideMO:getQuestMapProgress(mapId)
	local progress = 0
	local mapMo = self:getQuestMap(mapId)

	if mapMo then
		progress = mapMo:getProgress()
	end

	local strProgress = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), progress * 100)

	return progress, strProgress
end

function AssassinOutsideMO:getQuestTypeProgressStr(mapId, questType)
	local finishQuestCount, allQuestCount = 0, 0
	local mapMo = self:getQuestMap(mapId)

	if mapMo then
		finishQuestCount = mapMo:getFinishQuestCount(questType)

		local allQuestList = AssassinConfig.instance:getQuestListInMap(mapId, questType)

		allQuestCount = #allQuestList
	end

	return string.format("%s/%s", finishQuestCount, allQuestCount)
end

function AssassinOutsideMO:getMapUnlockQuestIdList(mapId)
	local mapMo = self:getQuestMap(mapId)

	return (mapMo or nil) and mapMo:getMapUnlockQuestIdList()
end

function AssassinOutsideMO:getMapFinishQuestIdList(mapId)
	local mapMo = self:getQuestMap(mapId)

	return (mapMo or nil) and mapMo:getMapFinishQuestIdList()
end

function AssassinOutsideMO:isUnlockQuest(questId)
	local mapId = AssassinConfig.instance:getQuestMapId(questId)
	local mapMo = self:getQuestMap(mapId)

	return (mapMo or nil) and mapMo:isUnlockQuest(questId)
end

function AssassinOutsideMO:isFinishQuest(questId)
	local mapId = AssassinConfig.instance:getQuestMapId(questId)
	local mapMo = self:getQuestMap(mapId)

	return (mapMo or nil) and mapMo:isFinishQuest(questId)
end

function AssassinOutsideMO:getCoinNum()
	return self._coin
end

function AssassinOutsideMO:getProcessingQuest()
	return self._processingQuest
end

return AssassinOutsideMO
