-- chunkname: @modules/logic/seasonver/act166/view/Season166MainSceneView.lua

module("modules.logic.seasonver.act166.view.Season166MainSceneView", package.seeall)

local Season166MainSceneView = class("Season166MainSceneView", BaseView)

function Season166MainSceneView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._goTrainEntrance = gohelper.findChild(self.viewGO, "trainEntrance")
	self._gospotEntrance = gohelper.findChild(self.viewGO, "spotEntrance")
	self._goMainContent = gohelper.findChild(self.viewGO, "#go_mainContent")
	self._goTrainEpisodeContent = gohelper.findChild(self.viewGO, "trainEntrance/#go_episodeContent")
	self._goStarCollect = gohelper.findChild(self.viewGO, "starCollect")
	self._goTrainEntranceNew = gohelper.findChild(self.viewGO, "trainEntrance/Title/#go_trainEntranceNew")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166MainSceneView:addEvents()
	self.addEventCb(self, Season166Controller.instance, Season166Event.CloseBaseSpotView, self.playBaseSpotAnim, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OpenBaseSpotView, self.playBaseSpotAnim, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OpenTrainView, self.playTrainViewAnim, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.CloseTrainView, self.playTrainViewAnim, self)
end

function Season166MainSceneView:removeEvents()
	self.removeEventCb(self, Season166Controller.instance, Season166Event.CloseBaseSpotView, self.playBaseSpotAnim, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.OpenBaseSpotView, self.playBaseSpotAnim, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.OpenTrainView, self.playTrainViewAnim, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.CloseTrainView, self.playTrainViewAnim, self)
end

function Season166MainSceneView:_editableInitView()
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.trainEntranceAnim = self._goTrainEntrance:GetComponent(gohelper.Type_Animator)
	self.basespotEntranceAnim = self._gospotEntrance:GetComponent(gohelper.Type_Animator)
	self.mainContentAnim = self._goMainContent:GetComponent(gohelper.Type_Animator)
	self.starCollectAnim = self._goStarCollect:GetComponent(gohelper.Type_Animator)
	self.trainEpisodeContentAnim = self._goTrainEpisodeContent:GetComponent(gohelper.Type_Animator)
	self.trainEpisodeContentCanvasGroup = self._goTrainEpisodeContent:GetComponent(gohelper.Type_CanvasGroup)
	self.spotEntranceCanvasGroup = self._gospotEntrance:GetComponent(gohelper.Type_CanvasGroup)
	self.mainContentCanvasGroup = self._goMainContent:GetComponent(gohelper.Type_CanvasGroup)
	self.trainLevelAlphaTab = {
		0,
		0.2,
		0.35,
		0.5,
		0.65,
		0.8,
		1
	}
	self.trainItemTab = self:getUserDataTb_()
end

function Season166MainSceneView:onUpdateParam()
	return
end

function Season166MainSceneView:onOpen()
	self.actId = self.viewParam.actId
	self.sceneUrl = Season166Config.instance:getSeasonConstStr(self.actId, Season166Enum.MainSceneUrl)
	self.sceneGo = self.viewContainer:getResInst(self.sceneUrl, self._gobg, "SeasonBG")
	self.sceneTrans = self.sceneGo.transform
	self.sceneAnim = self.sceneGo:GetComponent(gohelper.Type_Animator)
	self.trainLevelBgCanvasGroup1 = gohelper.findChild(self.sceneGo, "#simage_building_5a2"):GetComponent(gohelper.Type_CanvasGroup)
	self.trainLevelBgCanvasGroup2 = gohelper.findChild(self.sceneGo, "#simage_building_5_1a"):GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(self._goStarCollect, false)
	gohelper.setActive(self._gospotEntrance, true)

	self.spotEntranceCanvasGroup.blocksRaycasts = true
	self.mainContentCanvasGroup.blocksRaycasts = true
	self.trainEpisodeContentCanvasGroup.blocksRaycasts = false
end

function Season166MainSceneView:playInViewAnim(jumpId)
	self.jumpId = jumpId
	self.isJump = jumpId and jumpId > 0

	self.viewAnim:Play(self.isJump and "open1" or "open", 0, 0)

	if not self.isJump then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wulu_kerandian_enter_level)
	end
end

function Season166MainSceneView:playTrainAnim(isEnter)
	if self.sceneAnim then
		self.sceneAnim:Play(isEnter and "inTrain" or "outTrain", 0, 0)
	else
		logError("self.sceneAnim is nil")
	end

	gohelper.setActive(self._goMainContent, true)
	gohelper.setActive(self._gospotEntrance, true)
	gohelper.setActive(self._goStarCollect, true)
	gohelper.setActive(self._goTrainEntranceNew, false)

	local animState = self.isJump and 1 or 0

	self.trainEntranceAnim:Play(isEnter and "in" or "out", 0, animState)
	self.mainContentAnim:Play(isEnter and "out" or "in", 0, animState)
	self.basespotEntranceAnim:Play(isEnter and "in" or "out", 0, animState)
	self.starCollectAnim:Play(isEnter and "in" or "out", 0, animState)

	self.spotEntranceCanvasGroup.blocksRaycasts = not isEnter
	self.mainContentCanvasGroup.blocksRaycasts = not isEnter
	self.trainEpisodeContentCanvasGroup.blocksRaycasts = isEnter

	TaskDispatcher.cancelTask(self.refreshItemUnlockState, self)

	if isEnter then
		if self.isJump and self.jumpId == Season166Enum.JumpId.TrainView then
			TaskDispatcher.runDelay(self.refreshTrainItemFinishEffect, self, 0.6)
		else
			self:refreshItemUnlockState()
		end
	else
		self:saveUnlockState()
		self:saveTrainItemFinishState()
	end
end

function Season166MainSceneView:playBaseSpotAnim(param)
	local isEnter = param.isEnter
	local baseSpotId = param.baseSpotId

	if isEnter then
		if not ("inBaseSpot" .. baseSpotId) then
			local animName = "outBaseSpot" .. baseSpotId

			if self.sceneAnim then
				self.sceneAnim:Play(animName, 0, 0)
			else
				logError("self.sceneAnim is nil")
			end

			gohelper.setActive(self._goMainContent, true)
			gohelper.setActive(self._gospotEntrance, true)
			gohelper.setActive(self._goStarCollect, false)
			self.trainEntranceAnim:Play(isEnter and "close" or "open", 0, 0)
			self.basespotEntranceAnim:Play(isEnter and "in" or "out", 0, 0)
			self.mainContentAnim:Play(isEnter and "out" or "in", 0, 0)

			self.spotEntranceCanvasGroup.blocksRaycasts = not isEnter
			self.mainContentCanvasGroup.blocksRaycasts = not isEnter
			self.trainEpisodeContentCanvasGroup.blocksRaycasts = false
		end
	end
end

function Season166MainSceneView:playTrainViewAnim(param)
	if not self.sceneAnim then
		logError("self.sceneAnim is nil")

		return
	end

	local isEnter = param.isEnter

	self.trainEntranceAnim:Play(isEnter and "trainentrance_indetail" or "trainentrance_outdetail", 0, 0)
	self.sceneAnim:Play(isEnter and "inTrainView" or "outTrainView", 0, 0)
	self.trainEpisodeContentAnim:Play(isEnter and "out" or "in", 0, 0)
	self.starCollectAnim:Play(isEnter and "out" or "in", 0, 0)
	gohelper.setActive(self._goMainContent, false)
	gohelper.setActive(self._gospotEntrance, false)
	gohelper.setActive(self._goTrainEntranceNew, false)

	if self.isJump and self.jumpId == Season166Enum.JumpId.TrainEpisode then
		self.spotEntranceCanvasGroup.blocksRaycasts = not isEnter
		self.mainContentCanvasGroup.blocksRaycasts = not isEnter
		self.trainEpisodeContentCanvasGroup.blocksRaycasts = isEnter

		self:refreshItemUnlockState()
		self:cleanJumpData()
	end
end

function Season166MainSceneView:playTrainEpisodeAnim(isTrainState)
	self.trainEpisodeContentAnim:Play(isTrainState and "in" or "out", 0, 0)
end

function Season166MainSceneView:setTrainLevelBg()
	local finishCount = Season166TrainModel.instance:getCurTrainPassCount(self.actId)

	self.trainLevelBgCanvasGroup1.alpha = self.trainLevelAlphaTab[finishCount + 1]
	self.trainLevelBgCanvasGroup2.alpha = self.trainLevelAlphaTab[finishCount + 1]
end

function Season166MainSceneView:setTrainItemTab(trainItemTab)
	self.trainItemTab = trainItemTab
end

function Season166MainSceneView:checkHasNewUnlock()
	local saveUnlockStateTab = Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)

	for index, trainItem in pairs(self.trainItemTab) do
		local saveUnlockState = saveUnlockStateTab[index]
		local trainUnlockState = trainItem.item:getUnlockState()

		if trainUnlockState == Season166Enum.UnlockState and trainUnlockState ~= saveUnlockState then
			return true
		end
	end

	return false
end

function Season166MainSceneView:refreshTrainEntranceNew()
	local canShowNew = self:checkHasNewUnlock()

	gohelper.setActive(self._goTrainEntranceNew, canShowNew)
end

function Season166MainSceneView:refreshItemUnlockState()
	local saveUnlockStateTab = Season166Model.instance:getLocalUnlockState(Season166Enum.MainTrainLockSaveKey)

	for index, trainItem in pairs(self.trainItemTab) do
		if GameUtil.getTabLen(saveUnlockStateTab) == 0 then
			trainItem.item:refreshUnlockState(Season166Enum.LockState)
		else
			local saveUnlockState = saveUnlockStateTab[index]

			trainItem.item:refreshUnlockState(saveUnlockState)
		end
	end

	self:saveUnlockState()
end

function Season166MainSceneView:saveUnlockState()
	local saveStrTab = {}

	for index, trainItem in ipairs(self.trainItemTab) do
		local unlockState = trainItem.item:getUnlockState()
		local saveStr = string.format("%s|%s", index, unlockState)

		table.insert(saveStrTab, saveStr)
	end

	local saveDataStr = cjson.encode(saveStrTab)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.MainTrainLockSaveKey, saveDataStr)
end

function Season166MainSceneView:refreshTrainItemFinishEffect()
	local saveFinishStateTab = Season166Model.instance:getLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey)

	for index, trainItem in pairs(self.trainItemTab) do
		if saveFinishStateTab[index] ~= 1 then
			trainItem.item:playFinishEffect()
		end
	end

	self:saveTrainItemFinishState()
end

function Season166MainSceneView:saveTrainItemFinishState()
	for index, trainItem in pairs(self.trainItemTab) do
		local finishState = trainItem.item:getFinishState()

		Season166Model.instance:setLocalPrefsTab(Season166Enum.MainTrainFinishSaveKey, index, finishState and 1 or 0)
	end
end

function Season166MainSceneView:cleanJumpData()
	self.isJump = false
	self.jumpId = 0
end

function Season166MainSceneView:onClose()
	self:saveUnlockState()
	self:saveTrainItemFinishState()
	TaskDispatcher.cancelTask(self.refreshItemUnlockState, self)
end

function Season166MainSceneView:onDestroyView()
	gohelper.destroy(self._sceneRoot)

	if self.sceneGo then
		gohelper.destroy(self.sceneGo)

		self.sceneGo = nil
	end

	if self._bgLoader then
		self._bgLoader:dispose()

		self._bgLoader = nil
	end
end

return Season166MainSceneView
