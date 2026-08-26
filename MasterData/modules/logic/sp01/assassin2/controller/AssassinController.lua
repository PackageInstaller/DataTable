-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinController.lua

module("modules.logic.sp01.assassin2.controller.AssassinController", package.seeall)

local AssassinController = class("AssassinController", BaseController)

function AssassinController:getAssassinOutsideInfo(cb, cbObj, isToast)
	local isOpen = AssassinOutsideModel.instance:isAct195Open(isToast)

	if not isOpen then
		return
	end

	local actId = AssassinOutsideModel.instance:getAct195Id()

	AssassinOutSideRpc.instance:sendGetAssassinOutSideInfoRequest(actId, cb, cbObj)
end

function AssassinController:onGetAssassinOutSideInfo(info)
	AssassinOutsideModel.instance:updateAllInfo(info.buildingInfo, info.unlockMapIds, info.questInfo, info.coin)
	AssassinItemModel.instance:updateAllInfo(info.items)
	AssassinHeroModel.instance:updateAllInfo(info.heroInfo)
	self:dispatchEvent(AssassinEvent.OnAllAssassinOutSideInfoUpdate)
end

function AssassinController:onUnlockQuestContent(newMapIdList, newItemList, newHeroList, newQuestIdList)
	AssassinOutsideModel.instance:unlockMapList(newMapIdList)
	AssassinOutsideModel.instance:unlockQuestList(newQuestIdList)
	AssassinHeroModel.instance:updateAssassinHeroInfoByList(newHeroList)
	AssassinItemModel.instance:unlockNewItems(newItemList)

	if newItemList then
		for _, assassinItem in ipairs(newItemList) do
			local itemId = assassinItem.itemId
			local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, itemId)

			self:setIsNewItem(cacheKey, true)
		end
	end

	self:dispatchEvent(AssassinEvent.OnUnlockQuestContent)
end

function AssassinController:openAssassinMapView(param, needLoginView)
	self._tmpOpenAssassinMapParam = param or {}
	self._tmpOpenAssassinMapParam.needLoginView = needLoginView

	self.getAssassinOutsideInfo(self, self._openAssassinMapViewAfterGetInfo, self, true)
end

function AssassinController:_openAssassinMapViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if self._tmpOpenAssassinMapParam then
		local needLoginView = self._tmpOpenAssassinMapParam.needLoginView

		if needLoginView then
			ViewMgr.instance:openView(ViewName.AssassinLoginView, self._tmpOpenAssassinMapParam)
		else
			self:realOpenAssassinMapView(self._tmpOpenAssassinMapParam)
		end

		self._tmpOpenAssassinMapParam = nil
	end
end

function AssassinController:realOpenAssassinMapView(param)
	ViewMgr.instance:openView(ViewName.AssassinMapView, param)
	ViewMgr.instance:closeView(ViewName.AssassinLoginView, true)
end

function AssassinController:openAssassinQuestMapView(params)
	ViewMgr.instance:openView(ViewName.AssassinQuestMapView, params)
end

function AssassinController:clickQuestItem(questId, fightReturn, isTween)
	local isFinished = AssassinOutsideModel.instance:isFinishQuest(questId)

	if isFinished then
		return
	end

	self:dispatchEvent(AssassinEvent.OnClickQuestItem, questId, fightReturn, isTween)
end

function AssassinController:startQuest(questId, params)
	local isUnlock = AssassinOutsideModel.instance:isUnlockQuest(questId)

	if not isUnlock then
		return
	end

	local funcMap = {
		[AssassinEnum.QuestType.Fight] = self._enterHeroPick,
		[AssassinEnum.QuestType.Dialog] = self._enterDialog,
		[AssassinEnum.QuestType.Stealth] = self._enterHeroPick
	}
	local questType = AssassinConfig.instance:getQuestType(questId)
	local handleFunc = funcMap[questType]

	if not handleFunc then
		logError(string.format("AssassinController:startQuest error, no handle func, questId:%s", questId))

		return
	end

	handleFunc(self, questId, params)
end

function AssassinController:_enterDialog(questId)
	local libraryId = tonumber(AssassinConfig.instance:getQuestParam(questId))
	local libraryCo = AssassinConfig.instance:getLibrarConfig(libraryId)

	if not libraryCo then
		return
	end

	local dialogId = libraryCo.talk

	if dialogId and dialogId ~= 0 then
		DialogueController.instance:enterDialogue(dialogId, self._onCloseDialog, self, questId)
	else
		self:finishQuest(questId)
		self:openAssassinLibraryDetailView(libraryId)
	end
end

function AssassinController:_onCloseDialog(questId, isFinishDialog)
	if not isFinishDialog then
		return
	end

	self:finishQuest(questId)

	local libraryId = tonumber(AssassinConfig.instance:getQuestParam(questId))

	self:openAssassinLibraryDetailView(libraryId)
end

function AssassinController:_enterHeroPick(questId)
	if not questId then
		return
	end

	self:openAssassinHeroView(questId)
end

function AssassinController:finishQuest(questId)
	AssassinOutSideRpc.instance:sendInteractiveRequest(questId, self._onFinishQuestInteractiveCb, self)
end

function AssassinController:_onFinishQuestInteractiveCb(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:updateCoinNum(msg.coin)
	self:onFinishQuest(msg.questId)
end

function AssassinController:onFinishQuest(questId)
	AssassinOutsideModel.instance:finishQuest(questId)
	self:dispatchEvent(AssassinEvent.OnFinishQuest)
end

function AssassinController:setHasPlayedAnimation(key)
	local playerCacheData = AssassinOutsideModel.instance:getPlayerCacheData()

	if not playerCacheData then
		return
	end

	playerCacheData[key] = true

	AssassinOutsideModel.instance:saveCacheData()
end

function AssassinController:setIsNewItem(key, isNew)
	local playerCacheData = AssassinOutsideModel.instance:getPlayerCacheData()

	if not playerCacheData then
		return
	end

	playerCacheData[key] = isNew and true or nil

	AssassinOutsideModel.instance:saveCacheData()
end

function AssassinController:enterQuestFight(questId)
	if questId then
		::label_18_0::

		local questType = AssassinConfig.instance:getQuestType(questId)

		if questType ~= AssassinEnum.QuestType.Fight then
			return
		end

		local strEpisodeId = AssassinConfig.instance:getQuestParam(questId)
		local episodeId = tonumber(strEpisodeId)
		local episodeCO = lua_episode.configDict[episodeId]
		local battleId = episodeCO and episodeCO.battleId
		local battleCO = lua_battle.configDict[battleId]

		if not battleCO then
			logError(string.format("AssassinController:enterQuestFight error, not battleCfg, questId:%s, episodeId:%s, battleId:%s", questId, episodeId, battleId))

			return
		end

		AssassinOutsideModel.instance:setEnterFightQuest(questId)
		DungeonModel.instance:SetSendChapterEpisodeId(nil, episodeId)
		FightController.instance:setFightParamByEpisodeId(episodeId, false, 1)

		local fightParam = FightModel.instance:getFightParam()

		if not fightParam then
			return false
		end

		local mainUidList = {}
		local subUidList = {}
		local equipList = {}
		local trialIdList = {}
		local maxHeroCount = battleCO.roleNum
		local emptyUid = tostring(0)
		local assassinHeroList = AssassinStealthGameModel.instance:getPickHeroList()

		for i = 1, maxHeroCount do
			local assassinHeroId = assassinHeroList[i]
			local heroMo

			if assassinHeroId then
				heroMo = AssassinHeroModel.instance:getHeroMo(assassinHeroId)
			end

			local heroUid = emptyUid

			if heroMo then
				heroUid = heroMo.uid
				trialIdList[#trialIdList + 1] = heroMo.trialCo.id
			end

			mainUidList[i] = heroUid

			local fightEquipMo = FightEquipMO.New()

			fightEquipMo.heroUid = heroUid
			fightEquipMo.equipUid = {
				emptyUid
			}

			table.insert(equipList, fightEquipMo)
		end

		HeroGroupTrialModel.instance:setTrailByTrialIdList(trialIdList)
		fightParam:setMySide(0, mainUidList, subUidList, equipList)
		DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, fightParam.multiplication)
	end
end

function AssassinController:openAssassinHeroView(questId)
	ViewMgr.instance:openView(ViewName.AssassinHeroView, {
		questId = questId
	})
end

function AssassinController:openHeroStatsView(params)
	ViewMgr.instance:openView(ViewName.AssassinStatsView, params)
end

function AssassinController:openAssassinBackpackView(params)
	AssassinBackpackListModel.instance:setAssassinBackpackList()

	local list = AssassinBackpackListModel.instance:getList()

	if not list or #list <= 0 then
		GameFacade.showToast(ToastEnum.AssassinStealthNoItem)

		return
	end

	ViewMgr.instance:openView(ViewName.AssassinBackpackView, params)
end

function AssassinController:openAssassinEquipView(params)
	ViewMgr.instance:openView(ViewName.AssassinEquipView, params)
end

function AssassinController:changeCareerEquip(assassinHeroId, newCareerId)
	if not assassinHeroId or not newCareerId then
		return
	end

	local isCanChange = AssassinConfig.instance:isAssassinHeroCanChangeToCareer(assassinHeroId, newCareerId)

	if not isCanChange then
		return
	end

	local curCareerId = AssassinHeroModel.instance:getAssassinCareerId(assassinHeroId)

	if curCareerId == newCareerId then
		return
	end

	AssassinOutSideRpc.instance:sendHeroTransferCareerRequest(assassinHeroId, newCareerId, self._changeCareerEquipFinish, self)
end

function AssassinController:_changeCareerEquipFinish(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinHeroModel.instance:updateAssassinHeroInfo(msg.hero)
	self:dispatchEvent(AssassinEvent.OnChangeAssassinHeroCareer)
end

function AssassinController:backpackSelectItem(index, isPlaySwitch)
	AssassinBackpackListModel.instance:selectCell(index, true)

	local assassinItemId = AssassinBackpackListModel.instance:getSelectedItemId()
	local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, assassinItemId)

	self:setIsNewItem(cacheKey, false)
	self:dispatchEvent(AssassinEvent.OnSelectBackpackItem, isPlaySwitch)
end

function AssassinController:changeEquippedItem(assassinHeroId)
	local assassinItemId = AssassinBackpackListModel.instance:getSelectedItemId()

	if not assassinHeroId or not assassinItemId then
		logError("AssassinController:changeEquippedItem error, has nil args, assassinHeroId:%s,assassinItemId:%s", assassinHeroId, assassinItemId)

		return
	end

	local itemType = AssassinEnum.Const.EmptyAssassinItemType
	local carryIndex = AssassinHeroModel.instance:getItemCarryIndex(assassinHeroId, assassinItemId)

	if not carryIndex then
		carryIndex = AssassinHeroModel.instance:findEmptyItemGridIndex(assassinHeroId)

		if not carryIndex then
			return
		end

		itemType = AssassinConfig.instance:getAssassinItemType(assassinItemId)
	end

	AssassinOutSideRpc.instance:sendEquipHeroItemRequest(assassinHeroId, carryIndex, itemType, self._changeEquippedItemFinish, self)
end

function AssassinController:_changeEquippedItemFinish(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinHeroModel.instance:updateAssassinHeroInfo(msg.hero)
	self:dispatchEvent(AssassinEvent.OnChangeEquippedItem)
end

function AssassinController:openAssassinQuestDetailView(questId, fightReturn, questItemWorldPos)
	local processingQuestId = AssassinOutsideModel.instance:getProcessingQuest()
	local hasProcessingQuest = processingQuestId and processingQuestId ~= 0

	if fightReturn and hasProcessingQuest then
		AssassinStealthGameController.instance:returnAssassinStealthGame(processingQuestId, fightReturn)
	else
		ViewMgr.instance:openView(ViewName.AssassinQuestDetailView, {
			questId = questId,
			worldPos = questItemWorldPos
		})
	end
end

function AssassinController:openAssassinStealthGameOverView(questId)
	if not questId then
		local mapId = AssassinStealthGameModel.instance:getMapId()

		if not mapId then
			logError("AssassinController:openAssassinStealthGameOverView error, questId and gameMapId is nil")

			return
		end
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameOverView, {
		questId = questId
	})
end

function AssassinController:openAssassinStealthGameGetItemView(itemList)
	if not itemList or not next(itemList) then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameGetItemView, itemList)
end

function AssassinController:openAssassinStealthGamePauseView()
	local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

	if not isPlayerTurn then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGamePauseView)
end

function AssassinController:openAssassinStealthGameResultView()
	ViewMgr.instance:openView(ViewName.AssassinStealthGameResultView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameGetItemView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameOverView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameEventView)
end

function AssassinController:openAssassinStealthGameEventView()
	ViewMgr.instance:openView(ViewName.AssassinStealthGameEventView)
end

function AssassinController:openAssassinStealthTechniqueView(mapId)
	ViewMgr.instance:openView(ViewName.AssassinTechniqueView, {
		viewParam = mapId
	})
end

function AssassinController:openAssassinLibraryView(actId, libraryType)
	AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity2_9Enum.ActivityId.Outside, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		if libraryType then
			if not AssassinEnum.LibraryType2TabViewId[libraryType] then
				local tabId = 1
				local defaultTabIds = {
					[AssassinEnum.LibraryInfoViewTabId] = tabId
				}
				local params = {
					actId = actId,
					libraryType = libraryType,
					defaultTabIds = defaultTabIds
				}

				ViewMgr.instance:openView(ViewName.AssassinLibraryView, params)
			end
		end
	end)
end

function AssassinController:openAssassinLibraryDetailView(libraryId)
	local libraryCo = AssassinConfig.instance:getLibrarConfig(libraryId)
	local type = libraryCo and libraryCo.type

	if type == AssassinEnum.LibraryType.Video then
		local storyIdList = string.splitToNumber(libraryCo.storyId, "#")

		StoryController.instance:playStories(storyIdList)
		AssassinLibraryModel.instance:readLibrary(libraryId)
	else
		ViewMgr.instance:openView(ViewName.AssassinLibraryDetailView, {
			libraryId = libraryId
		})
	end
end

function AssassinController:openAssassinBuildingMapView(params)
	ViewMgr.instance:openView(ViewName.AssassinBuildingMapView, params)
end

function AssassinController:openAssassinBuildingLevelUpView(buildingType)
	local params = {
		buildingType = buildingType
	}

	ViewMgr.instance:openView(ViewName.AssassinBuildingLevelUpView, params)
end

function AssassinController:updateBuildingInfo(buildingInfo)
	local mapMo = AssassinOutsideModel.instance:getBuildingMapMo()

	if not mapMo then
		return
	end

	mapMo:updateBuildingInfo(buildingInfo)
	AssassinController.instance:dispatchEvent(AssassinEvent.UpdateBuildingInfo, buildingInfo.type)
end

function AssassinController:onGetBuildingUnlockInfo(unlockBuildIds)
	local mapMo = AssassinOutsideModel.instance:getBuildingMapMo()

	if not mapMo or not unlockBuildIds or #unlockBuildIds <= 0 then
		return
	end

	mapMo:updateUnlockBuildIds(unlockBuildIds)
	AssassinController.instance:dispatchEvent(AssassinEvent.UnlockBuildings, unlockBuildIds)
end

function AssassinController:openAssassinTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AssassinOutside
	}, function()
		ViewMgr.instance:openView(ViewName.AssassinTaskView)
	end)
end

function AssassinController:getCoinNum()
	local outsideMo = AssassinOutsideModel.instance:getOutsideMo()

	return outsideMo and outsideMo:getCoinNum() or 0
end

function AssassinController:updateCoinNum(coin)
	local outsideMo = AssassinOutsideModel.instance:getOutsideMo()

	if not outsideMo then
		return
	end

	AssassinOutsideModel.instance:updateIsNeedPlayGetCoin(coin)
	outsideMo:updateCoinNum(coin)
	self:dispatchEvent(AssassinEvent.UpdateCoinNum, coin)
end

AssassinController.instance = AssassinController.New()

return AssassinController
