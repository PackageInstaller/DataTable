-- chunkname: @modules/logic/sp02/dungeonmap/controller/AtomicDungeonController.lua

module("modules.logic.sp02.dungeonmap.controller.AtomicDungeonController", package.seeall)

local AtomicDungeonController = class("AtomicDungeonController", BaseController)

function AtomicDungeonController:onInit()
	return
end

function AtomicDungeonController:onInitFinish()
	return
end

function AtomicDungeonController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self.dungeonEndPush, self)
	PopupController.instance:registerCallback(PopupEvent.OnMaterialChangePush, self.onMaterialChangePush, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.onSetTaskList, self)
end

function AtomicDungeonController:reInit()
	return
end

function AtomicDungeonController:openDungeonView(viewParam)
	local isUnlock, tips = self:isUnlockDungeon(true)

	if not isUnlock then
		ToastController.instance:showToastWithString(tips)

		return
	end

	self.dungeonViewParam = viewParam

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AtomicDungeon
	}, function(_, infoCode, _)
		if infoCode == 0 then
			AtomicRpc.instance:sendAtomicGetInfoRequest(self._openDungeonView, self)
		end
	end)
end

function AtomicDungeonController:_openDungeonView()
	ViewMgr.instance:openView(ViewName.AtomicDungeonMainView, self.dungeonViewParam)
end

function AtomicDungeonController:openDungeonInteractView(elementComp)
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if not isInPolygonState then
		self:dispatchEvent(AtomicDungeonEvent.OnOpenInteractView, elementComp.config.id)
	end

	AtomicDungeonModel.instance:setCurInElementId(elementComp.config.id)

	if isInPolygonState then
		ViewMgr.instance:openView(ViewName.AtomicDungeonPolygonInteractView, elementComp)
	else
		ViewMgr.instance:openView(ViewName.AtomicDungeonInteractView, elementComp)
	end
end

function AtomicDungeonController:openAtomicDungeonPolygonSelectView(param)
	ViewMgr.instance:openView(ViewName.AtomicDungeonPolygonSelectView, param)
end

function AtomicDungeonController:openAtomicDungeonHardFightResultView(param)
	ViewMgr.instance:openView(ViewName.AtomicDungeonHardFightResultView, param)
end

function AtomicDungeonController:openAtomicDungeonFightSuccView(param)
	ViewMgr.instance:openView(ViewName.AtomicDungeonFightSuccView, param)
end

function AtomicDungeonController:openAtomicDungeonPolygonSuccView(param)
	AtomicDungeonStatHelper.instance:sendDungeonResultInfo("成功")
	ViewMgr.instance:openView(ViewName.AtomicDungeonPolygonSuccView, param)
end

function AtomicDungeonController:openDungeonTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AtomicDungeon
	}, function()
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
		ViewMgr.instance:openView(ViewName.AtomicDungeonTaskView)
	end)
end

function AtomicDungeonController:onUpdateTaskList(msg)
	local isChange = AtomicDungeonTaskModel.instance:updateTaskInfo(msg.taskInfo)

	if isChange then
		AtomicDungeonTaskModel.instance:refreshList()
	end

	self:dispatchEvent(AtomicDungeonEvent.AtomicDungeonTaskUpdated)
end

function AtomicDungeonController:onSetTaskList()
	local atomicTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.AtomicDungeon) or {}

	AtomicDungeonTaskModel.instance:setTaskInfoList(atomicTasks)
	AtomicDungeonTaskModel.instance:refreshList()
	self:dispatchEvent(AtomicDungeonEvent.AtomicDungeonTaskUpdated)
end

function AtomicDungeonController:jumpView(param)
	local jumpType = param.jumpType
	local jumpMapId = param.jumpMapId

	if jumpType == AtomicDungeonEnum.JumpType.DungeonMap then
		local mapId = AtomicDungeonModel.instance:getMapIdByArenaMapId(jumpMapId)
		local isPolygonMap = AtomicDungeonModel.instance:checkArenaMapIsPolygon(jumpMapId)
		local targetMapId = isPolygonMap and jumpMapId or mapId
		local mapInfo = AtomicDungeonModel.instance:getMapInfo(targetMapId)

		if mapInfo then
			self:dispatchEvent(AtomicDungeonEvent.JumpToMap, jumpMapId)
		end
	elseif jumpType == AtomicDungeonEnum.JumpType.Talent then
		AtomicController.instance:openTalentView()
	end
end

function AtomicDungeonController:checkCanShowElementTipToast()
	local newAddElement = AtomicDungeonModel.instance:getNewElementList()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if #newAddElement > 0 and not isInPolygonState then
		return true
	end

	local arenaInfoData = AtomicDungeonModel.instance:getCurArenaInfoData()
	local oldAlarmLevel = AtomicDungeonModel.instance:getOldAlarmLevel()
	local curAlamrLevel = AtomicDungeonModel.instance:getCurAlarmLevel()

	if arenaInfoData.currentAlarm and curAlamrLevel ~= oldAlarmLevel then
		return true
	end

	return false
end

function AtomicDungeonController:onMaterialChangePush(params)
	if params then
		::label_19_0::

		local var_19_0 = params.msg

		if params.msg then
			local needPopup = params.msg.getApproach == MaterialEnum.GetApproach.AtomicDungeon

			AtomicDungeonModel.instance:setNeedPopupCommonProState(needPopup)
		end
	end
end

function AtomicDungeonController:showTipToast(msg)
	if not ViewMgr.instance:isOpen(ViewName.AtomicDungeonMainView) then
		table.insert(AtomicDungeonModel.instance.showTipToastList, msg)
	elseif ViewMgr.instance:isOpening(ViewName.AtomicDungeonMainView) then
		table.insert(AtomicDungeonModel.instance.showTipToastList, msg)
	else
		self:dispatchEvent(AtomicDungeonEvent.ShowTipToast, msg)
	end
end

function AtomicDungeonController:showElementTipToast()
	local newAddElement = AtomicDungeonModel.instance:getNewElementList()
	local hasNormalElement = false
	local hasEmergencyElement = false

	if #newAddElement > 0 then
		for _, elementCo in ipairs(newAddElement) do
			local isHasShow = AtomicDungeonModel.instance:checkTipToastElementHasShow(elementCo.id)

			if not isHasShow then
				if elementCo.isEmergency == 1 then
					hasEmergencyElement = true
				else
					hasNormalElement = true
				end

				AtomicDungeonModel.instance:setShowTipToastElementId(elementCo.id)
			end
		end
	end

	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if hasNormalElement and not isInPolygonState then
		self:showTipToast(AtomicDungeonEnum.TipToastType.UnlockElement)
	end

	if hasEmergencyElement then
		self:showTipToast(AtomicDungeonEnum.TipToastType.EmergencyShow)
	end

	if not hasNormalElement and not hasEmergencyElement then
		self:dispatchEvent(AtomicDungeonEvent.ShowTipToastFinish)
	end
end

function AtomicDungeonController:showAlarmTipToast()
	local arenaInfoData = AtomicDungeonModel.instance:getCurArenaInfoData()
	local oldAlarmLevel = AtomicDungeonModel.instance:getOldAlarmLevel()
	local curAlamrLevel = AtomicDungeonModel.instance:getCurAlarmLevel()

	if arenaInfoData.currentAlarm and curAlamrLevel ~= oldAlarmLevel then
		self:showTipToast(AtomicDungeonEnum.TipToastType.AlarmChange)
	end
end

function AtomicDungeonController:checkShowTipToastDirectly()
	local needPopupCommonPro = AtomicDungeonModel.instance:getNeedPopupCommonProViewState()
	local newAddElement = AtomicDungeonModel.instance:getNewElementList()

	if not needPopupCommonPro and #newAddElement == 0 then
		self:showElementTipToast()
	end
end

function AtomicDungeonController:checkShowAlarmTipToastDirectly()
	local needPopupCommonPro = AtomicDungeonModel.instance:getNeedPopupCommonProViewState()
	local newAddElement = AtomicDungeonModel.instance:getNewElementList()

	if not needPopupCommonPro and #newAddElement == 0 then
		self:showAlarmTipToast()
	end
end

function AtomicDungeonController:dungeonEndPush()
	AtomicDungeonModel.instance:setCurFightEpisodeId(nil)
end

function AtomicDungeonController:getLocalPolygonSelectHardMap()
	local saveStr = AtomicController.instance:getPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectHard, "")

	if string.nilorempty(saveStr) then
		return {}
	end

	return cjson.decode(saveStr) or {}
end

function AtomicDungeonController:saveLocalPolygonSelectHard(polygonHardMap)
	local selectHardMap = self:getLocalPolygonSelectHardMap()

	for mapId, hardIndex in pairs(polygonHardMap) do
		selectHardMap[tostring(mapId)] = hardIndex
	end

	local saveStr = cjson.encode(selectHardMap)

	AtomicController.instance:setPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectHard, saveStr)
end

function AtomicDungeonController:getCurPolygonSelectHard(mapId)
	local selectHardMap = self:getLocalPolygonSelectHardMap()

	if not next(selectHardMap) then
		local isAllHardUnlock, hardIndex = self:checkPolygonSelectIsAllHardUnlock()

		if isAllHardUnlock then
			return hardIndex
		end

		return 1
	end

	return selectHardMap[tostring(mapId)] or 1
end

function AtomicDungeonController:saveLocalPolygonData()
	local localDataMap = {}
	local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()

	for _, polygonCo in ipairs(allPolygonCoList) do
		local saveData = {}

		saveData.isUnLock = AtomicDungeonModel.instance:checkConditionCanUnlock(polygonCo.unlockCondition)
		saveData.passDiff = AtomicDungeonModel.instance:getPolygonDiffResult(polygonCo.id)
		localDataMap[tostring(polygonCo.id)] = saveData
	end

	local saveStr = cjson.encode(localDataMap)

	AtomicController.instance:setPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectData, saveStr)
end

function AtomicDungeonController:getLockPolygonData(polygonId)
	local saveStr = AtomicController.instance:getPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectData, "")

	if string.nilorempty(saveStr) then
		return {}
	end

	local localDataMap = cjson.decode(saveStr) or {}

	return localDataMap[tostring(polygonId)]
end

function AtomicDungeonController:saveLocalPolygonSelectUnlockIdList()
	local polygonInfoTab = AtomicDungeonModel.instance:getPolygonInfoTab()
	local unlockPolygonIdList = {}

	for polygonId, polygonMo in pairs(polygonInfoTab) do
		table.insert(unlockPolygonIdList, polygonId)
	end

	AtomicController.instance:setPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectUnlockIdList, (table.concat(unlockPolygonIdList, "#")))
end

function AtomicDungeonController:checkHasNewUnlockPolygonSelect()
	local polygonInfoTab = AtomicDungeonModel.instance:getPolygonInfoTab()
	local saveStr = AtomicController.instance:getPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonSelectUnlockIdList, "")

	if string.nilorempty(saveStr) then
		return tabletool.len(polygonInfoTab) > 0
	end

	local unlockPolygonIdList = string.splitToNumber(saveStr, "#")

	for polygonId, polygonMo in pairs(polygonInfoTab) do
		if not tabletool.indexOf(unlockPolygonIdList, polygonId) then
			return true
		end
	end

	return false
end

function AtomicDungeonController:checkPolygonSelectIsAllHardUnlock()
	local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()
	local firstPolygonMapId = allPolygonCoList[1].id
	local polygonMo = AtomicDungeonModel.instance:getPolygonMo(firstPolygonMapId)

	if polygonMo then
		local passDiffList = polygonMo.passDiffList
		local allPolygonDiffCoList = AtomicDungeonConfig.instance:getAllPolygonDiffCoList(firstPolygonMapId)

		if #passDiffList == #allPolygonDiffCoList then
			return true, #passDiffList
		end
	end

	return false
end

function AtomicDungeonController:openPuzzleGameView(puzzleParam)
	if puzzleParam.type == AtomicDungeonEnum.PuzzleType.Line then
		ViewMgr.instance:openView(ViewName.AtomicLineGameView, puzzleParam)
	elseif puzzleParam.type == AtomicDungeonEnum.PuzzleType.Color then
		ViewMgr.instance:openView(ViewName.AtomicColorGameView, puzzleParam)
	elseif puzzleParam.type == AtomicDungeonEnum.PuzzleType.Rhythm then
		ViewMgr.instance:openView(ViewName.AtomicRhythmGameView, puzzleParam)
	end

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
end

function AtomicDungeonController:isUnlockDungeon(showTips)
	local chapterId = VersionActivity3_10DungeonEnum.DungeonChapterId.Hard
	local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(chapterId)

	if isOpen then
		return true
	end

	if showTips then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(unLockEpisodeId)
		local episodeIndexWithSP = DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, unLockEpisodeId)
		local chapterCo = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
		local chapterTag = chapterCo.chapterIndex
		local chapterStr = string.format("%s-%s", chapterTag, episodeIndexWithSP)
		local tips = formatLuaLang("versionactivity1_3_hardlocktip", chapterStr)

		return false, tips
	end

	return false
end

function AtomicDungeonController:showDataBaseToast(dataBaseId)
	local param = {}

	param.dataBaseId = dataBaseId

	ViewMgr.instance:openView(ViewName.AtomicDataBaseToastView, param)
end

AtomicDungeonController.instance = AtomicDungeonController.New()

return AtomicDungeonController
