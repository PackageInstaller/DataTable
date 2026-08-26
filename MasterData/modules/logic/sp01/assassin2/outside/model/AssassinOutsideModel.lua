-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinOutsideModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinOutsideModel", package.seeall)

local AssassinOutsideModel = class("AssassinOutsideModel", BaseModel)

function AssassinOutsideModel:onInit()
	self:clear()
	self:clearData()
end

function AssassinOutsideModel:reInit()
	self:clearData()
end

function AssassinOutsideModel:clearData()
	if self._outsideMo then
		self._outsideMo:clearData()
	end

	self:setEnterFightQuest()
	self:updateIsNeedPlayGetCoin()

	self.playerCacheData = nil
end

function AssassinOutsideModel:updateAllInfo(buildingInfo, unlockMapIds, allQuestInfo, coin)
	self:updateIsNeedPlayGetCoin(coin)

	local outsideMo = self:getOutsideMo()

	outsideMo:updateAllInfo(buildingInfo, unlockMapIds, allQuestInfo, coin)
end

function AssassinOutsideModel:getAct195Id()
	return VersionActivity2_9Enum.ActivityId.Outside
end

function AssassinOutsideModel:isAct195Open(isToast)
	local result = true
	local toastId, toastParam

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.AssassinOutside) then
		toastId, toastParam = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.AssassinOutside)
		result = false
	else
		local actStatus
		local actId = self:getAct195Id()
		local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

		if actInfoMo then
			actStatus, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
		else
			toastId = ToastEnum.ActivityEnd
		end

		result = actStatus == ActivityEnum.ActivityStatus.Normal
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	return result
end

function AssassinOutsideModel:getOutsideMo()
	self._outsideMo = self._outsideMo or AssassinOutsideMO.New()

	return self._outsideMo
end

function AssassinOutsideModel:updateIsNeedPlayGetCoin(newCoin)
	local outsideMo = self:getOutsideMo()
	local curCoin = outsideMo and outsideMo:getCoinNum()

	self._needPlayGetCoin = newCoin and curCoin and curCoin < newCoin or nil
end

function AssassinOutsideModel:getIsNeedPlayGetCoin()
	return self._needPlayGetCoin
end

function AssassinOutsideModel:saveCacheData()
	if not self.playerCacheData then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.AssassinOutsideDataKey, cjson.encode(self.playerCacheData))
end

function AssassinOutsideModel:unlockMapList(newMapList)
	local outsideMo = self:getOutsideMo()

	if outsideMo then
		outsideMo:unlockQuestMapByList(newMapList)
	end
end

function AssassinOutsideModel:unlockQuestList(newQuestList)
	local outsideMo = self:getOutsideMo()

	if outsideMo then
		outsideMo:unlockQuestByList(newQuestList)
	end
end

function AssassinOutsideModel:finishQuest(questId)
	local outsideMo = self:getOutsideMo()

	if outsideMo then
		outsideMo:finishQuest(questId)
	end
end

function AssassinOutsideModel:setEnterFightQuest(questId)
	self._enterFightQuest = questId
end

function AssassinOutsideModel:getQuestMapStatus(mapId)
	local outsideMo = self:getOutsideMo()

	return outsideMo:getQuestMapStatus(mapId)
end

function AssassinOutsideModel:getQuestMapProgress(mapId)
	local outsideMo = self:getOutsideMo()
	local progress, strProgress = outsideMo:getQuestMapProgress(mapId)

	return progress, strProgress
end

function AssassinOutsideModel:getQuestTypeProgressStr(mapId, questType)
	local outsideMo = self:getOutsideMo()

	return outsideMo:getQuestTypeProgressStr(mapId, questType)
end

function AssassinOutsideModel:getMapUnlockQuestIdList(mapId)
	local outsideMo = self:getOutsideMo()

	return outsideMo:getMapUnlockQuestIdList(mapId)
end

function AssassinOutsideModel:getMapFinishQuestIdList(mapId)
	local outsideMo = self:getOutsideMo()

	return outsideMo:getMapFinishQuestIdList(mapId)
end

function AssassinOutsideModel:isUnlockQuest(questId)
	local outsideMo = self:getOutsideMo()

	return outsideMo:isUnlockQuest(questId)
end

function AssassinOutsideModel:isFinishQuest(questId)
	local outsideMo = self:getOutsideMo()

	return outsideMo:isFinishQuest(questId)
end

function AssassinOutsideModel:getPlayerCacheData()
	if not self.playerCacheData then
		local strCacheData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.AssassinOutsideDataKey, "")

		if not string.nilorempty(strCacheData) then
			self.playerCacheData = cjson.decode(strCacheData)
		end

		self.playerCacheData = self.playerCacheData or {}
	end

	return self.playerCacheData
end

function AssassinOutsideModel:getCacheKeyData(key)
	local result = false

	if key then
		local playerCacheData = self:getPlayerCacheData()

		result = playerCacheData and playerCacheData[key] or false
	end

	return result
end

function AssassinOutsideModel:getProcessingQuest()
	local outsideMo = self:getOutsideMo()

	return outsideMo:getProcessingQuest()
end

function AssassinOutsideModel:getEnterFightQuest()
	return self._enterFightQuest
end

function AssassinOutsideModel:getBuildingMapMo()
	local outsideMo = self:getOutsideMo()

	return outsideMo:getBuildingMap()
end

function AssassinOutsideModel:getBuildingMo(buildingType)
	local mapMo = self:getBuildingMapMo()

	return mapMo and mapMo:getBuildingMo(buildingType)
end

AssassinOutsideModel.instance = AssassinOutsideModel.New()

return AssassinOutsideModel
