-- chunkname: @modules/logic/udimo/controller/UdimoController.lua

module("modules.logic.udimo.controller.UdimoController", package.seeall)

local UdimoController = class("UdimoController", BaseController)

function UdimoController:onInit()
	return
end

function UdimoController:onInitFinish()
	return
end

function UdimoController:addConstEvents()
	MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, self._resetWaitEnterUdimoLock, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._resetWaitEnterUdimoLock, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._resetWaitEnterUdimoLock, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterScene, self._resetWaitEnterUdimoLock, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._resetWaitEnterUdimoLock, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._resetWaitEnterUdimoLock, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._resetWaitEnterUdimoLock, self)
end

function UdimoController:_resetWaitEnterUdimoLock()
	TaskDispatcher.cancelTask(self._waitTimeFinished, self)
	self:_beginWaitEnterUdimoLock()
end

function UdimoController:_beginWaitEnterUdimoLock()
	local isCanEnter = UdimoHelper.isCanEnterUdimoLockMode()

	if not isCanEnter then
		return
	end

	local settingId = UdimoModel.instance:getUdimoSettingId()
	local waitTime = UdimoConfig.instance:getSettingWaitTime(settingId)

	if waitTime and waitTime > 0 then
		TaskDispatcher.runDelay(self._waitTimeFinished, self, waitTime)
	end
end

function UdimoController:_waitTimeFinished()
	local isCanEnter = UdimoHelper.isCanEnterUdimoLockMode()

	if not isCanEnter then
		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.Udimo then
		self:dispatchEvent(UdimoEvent.Switch2UdimoLockMode)
	else
		local viewNameList = ViewMgr.instance:getOpenViewNameList()
		local topView = viewNameList[#viewNameList]

		self:enterUdimo(true, topView)
	end
end

function UdimoController:reInit()
	return
end

function UdimoController:enterUdimo(isLock, resumeView)
	local isOpen = UdimoModel.instance:isOpenUdimoFunc(true)

	if not isOpen then
		return
	end

	self._isLock = isLock

	UdimoModel.instance:clearSceneData()
	UdimoModel.instance:setResumeViewName(resumeView)
	self.getUdimoInfo(self, self._enterScene, self)
end

function UdimoController:_enterScene(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local sceneLevel = UdimoItemModel.instance:getUseBgSceneLevelId()

	GameSceneMgr.instance:startScene(SceneType.Udimo, UdimoEnum.Const.SceneId, sceneLevel)
end

function UdimoController:getUdimoScene()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if scene and sceneType == SceneType.Udimo then
		return scene
	end
end

function UdimoController:exitUdimo()
	MainController.instance:enterMainScene()
	ExitUdimoSceneHelper.resumeViewOnExitScene()
	UdimoModel.instance:clearSceneData()
end

function UdimoController:getUdimoInfo(cb, cbObj)
	local lat, lon = DeviceController.instance:getDeviceLocation()

	UdimoRpc.instance:sendGetUdimoInfoRequest(lat, lon, cb, cbObj)
end

function UdimoController:changUdimoShow(udimoId, isShow, cb, cbObj)
	local cfg = UdimoConfig.instance:getUdimoCfg(udimoId, true)
	local hasUnlock = UdimoModel.instance:isUnlockUdimo(udimoId)

	if not cfg or not hasUnlock then
		return
	end

	isShow = not not isShow

	local curIsShow = not not UdimoModel.instance:isUseUdimo(udimoId)

	if isShow == curIsShow then
		return
	end

	local useUidmoIdList = UdimoModel.instance:getUseUdimoIdList()

	if isShow then
		useUidmoIdList[#useUidmoIdList + 1] = udimoId
	else
		tabletool.removeValue(useUidmoIdList, udimoId)
	end

	local newShowingCount = #useUidmoIdList
	local maxShowingCount = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.MaxShowUdimoCount, true)

	if maxShowingCount < newShowingCount then
		GameFacade.showToast(ToastEnum.V3a2UdimoShowFull)

		return
	end

	UdimoRpc.instance:sendUseUdimoRequest(useUidmoIdList, cb, cbObj)
end

function UdimoController:useBg(bgId, cb, cbObj)
	local isUnlock = UdimoItemModel.instance:isUnlockBg(bgId)

	if not isUnlock then
		return
	end

	UdimoRpc.instance:sendUseBackgroundRequest(bgId, cb, cbObj)
end

function UdimoController:useDecoration(useDecorationId, removeDecorationId, cb, cbObj)
	if useDecorationId then
		::label_15_0::

		local isUnlock = UdimoItemModel.instance:isUnlockDecoration(useDecorationId)

		if useDecorationId == removeDecorationId or not isUnlock then
			if useDecorationId and not isUnlock then
				GameFacade.showToast(ToastEnum.V3a2UdimoDecorationLocked)
			end

			if cb then
				cb(cbObj)
			end

			return
		end

		UdimoRpc.instance:sendUseDecorationRequest(useDecorationId, removeDecorationId, cb, cbObj)
	end
end

function UdimoController:onGetUdimoInfo(info)
	if not info then
		return
	end

	UdimoModel.instance:setUdimoInfoByList(info.udimos)
	UdimoItemModel.instance:setDecorationUseInfoByList(info.decorations)
	UdimoItemModel.instance:setBgUseInfoByList(info.backgrounds)
	self:onGetWeatherInfo(info)
	self:dispatchEvent(UdimoEvent.OnGetUdimoInfo)
end

function UdimoController:onUseUdimo(info)
	if not info then
		return
	end

	UdimoModel.instance:updateAllUdimoUseInfo(info.useUdimoIds)
	self:dispatchEvent(UdimoEvent.OnChangeUidmoShow)
end

function UdimoController:onUseBg(info)
	if not info then
		return
	end

	UdimoItemModel.instance:setUseBg(info.useBackgroundId)
	self:dispatchEvent(UdimoEvent.OnChangeBg)
end

function UdimoController:onUseDecoration(info)
	if not info then
		return
	end

	UdimoItemModel.instance:setIsUseDecoration(info.useDecorationId, true)
	UdimoItemModel.instance:setIsUseDecoration(info.removeDecorationId, false)
	self:dispatchEvent(UdimoEvent.OnChangeDecoration, info.useDecorationId, info.removeDecorationId)
end

function UdimoController:onGetWeatherInfo(info)
	local weatherInfo
	local isOversea = SettingsModel.instance:isOverseas()

	if isOversea then
		local curTime = ServerTime.now()
		local nextChangeWeatherTime = UdimoWeatherModel.instance:getOverseasNextChangeWeatherTime()

		if nextChangeWeatherTime and curTime < nextChangeWeatherTime then
			return
		end

		local randomTemp = self:_getRandomTemp()
		local randomWeatherId = self:_getRandomWeatherId(randomTemp)

		weatherInfo = {
			windLevel = 0,
			temp = randomTemp,
			weatherId = randomWeatherId
		}

		local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.RandomWeatherIntervalTime, false, "#", true)
		local weatherInterval = math.random(timeArr[1], timeArr[2])

		UdimoWeatherModel.instance:setOverseasNextChangeWeatherTime(curTime + weatherInterval)
	else
		weatherInfo = info and info.weather
	end

	if not weatherInfo then
		return
	end

	UdimoWeatherModel.instance:setWeatherInfo(weatherInfo)
	self:dispatchEvent(UdimoEvent.OnGetWeatherInfo)
end

function UdimoController:_getRandomTemp()
	local tempRang = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.OverseasRandomTemperatureRange, false, "#", true)

	return (tempRang and #tempRang >= 2 or nil) and math.random(tempRang[1], tempRang[2])
end

function UdimoController:_getRandomWeatherId(temp)
	local weatherId = UdimoWeatherModel.instance:getWeatherId()
	local cfgWeatherId = UdimoConfig.instance:findCfgWeatherId(weatherId)
	local cfgWeatherIdList = UdimoConfig.instance:getCfgWeatherIdList(cfgWeatherId, temp, true)
	local index = math.random(#cfgWeatherIdList)
	local randomCfgWeatherId = cfgWeatherIdList[index]
	local weatherIds = UdimoConfig.instance:getWeatherIds(randomCfgWeatherId)
	local randomWeatherId

	if weatherIds then
		local weatherIndex = math.random(#weatherIds)

		randomWeatherId = weatherIds[weatherIndex]
	end

	return randomWeatherId
end

function UdimoController:openMainView()
	ViewMgr.instance:openView(ViewName.UdimoMainView, {
		isLock = self._isLock
	})

	if not self._isLock then
		self:dispatchEvent(UdimoEvent.OnEnterUdimoPlayMode)
	end

	self._isLock = nil
end

function UdimoController:openChangeBgView()
	ViewMgr.instance:openView(ViewName.UdimoChangeBgView)
end

function UdimoController:openChangeDecorationView()
	ViewMgr.instance:openView(ViewName.UdimoChangeDecorationView)
end

function UdimoController:openInfoView()
	UdimoInfoListModel.instance:setUdimoInfoList()
	ViewMgr.instance:openView(ViewName.UdimoInfoView)
end

function UdimoController:pickUpUdimo(udimoId, clickPos)
	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if pickedUpUdimo then
		return
	end

	local scene = self:getUdimoScene()

	if scene then
		::label_27_0::

		local udimoEntity = scene.udimomgr:getUdimoEntity(udimoId)
		local isTranslating = udimoEntity and udimoEntity:getIsInTranslating()

		if not udimoEntity or isTranslating then
			return
		end

		UdimoModel.instance:setPickedUpUdimoId(udimoId)
		self:_resetWaitEnterUdimoLock()
		self:_updateInteractPointAndCheckInteract(udimoId)

		local triggerEvent = UdimoEvent.OnPickUpUdimo

		self:dispatchEvent(triggerEvent, udimoId, {
			eventId = triggerEvent,
			param = {
				clickPos = clickPos
			}
		})
	end
end

function UdimoController:pickUpUdimoOver(pos)
	local scene = self:getUdimoScene()
	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if not pickedUpUdimo or not scene then
		return
	end

	UdimoModel.instance:setPickedUpUdimoId()
	self:_resetWaitEnterUdimoLock()

	local interactId = scene.interactPoint:getCanPlaceInteractPoint(pos, pickedUpUdimo)
	local friendId = self:_updateInteractPointAndCheckInteract(pickedUpUdimo, interactId)
	local triggerEvent = UdimoEvent.OnPickUpUdimoOver

	self:dispatchEvent(triggerEvent, pickedUpUdimo, {
		eventId = triggerEvent,
		param = {
			friendId = friendId
		}
	})
	UdimoStatController.instance:udimoOperation(pickedUpUdimo, interactId, friendId)
end

function UdimoController:udimoWaitInteractOverTime(udimoId)
	local scene = self:getUdimoScene()

	if not scene then
		return
	end

	self:_updateInteractPointAndCheckInteract(udimoId)

	local triggerEvent = UdimoEvent.UdimoWaitInteractOverTime

	self:dispatchEvent(triggerEvent, udimoId, {
		eventId = triggerEvent
	})
end

function UdimoController:_updateInteractPointAndCheckInteract(udimoId, newInteractId)
	local oldInteractId = UdimoModel.instance:getUdimoInteractId(udimoId)

	UdimoModel.instance:setUdimoInteractPoint(oldInteractId)

	local useBg = UdimoItemModel.instance:getUseBg()
	local _, friendUdimoId = UdimoConfig.instance:getUdimoRelativeFriend(useBg, udimoId, oldInteractId)

	if friendUdimoId then
		self:_udimoInteractFinished(friendUdimoId)
	end

	if newInteractId then
		UdimoModel.instance:setUdimoInteractPoint(newInteractId, udimoId)

		local isCanEnterInteract = UdimoModel.instance:canStartInteract(udimoId, newInteractId)

		if isCanEnterInteract then
			local newFriendId, newFriendUdimoId = UdimoConfig.instance:getUdimoRelativeFriend(useBg, udimoId, newInteractId)

			UdimoModel.instance:setFriendInteractEmojiList(newFriendId)
			self:_udimoBeginInteract(newFriendUdimoId)

			return newFriendId
		end
	end
end

function UdimoController:_udimoBeginInteract(udimoId)
	local scene = self:getUdimoScene()

	if scene then
		::label_31_0::

		local udimoEntity = scene.udimomgr:getUdimoEntity(udimoId)

		if not udimoEntity then
			return
		end

		local triggerEvent = UdimoEvent.BeginInetract

		self:dispatchEvent(triggerEvent, udimoId, {
			eventId = triggerEvent
		})
	end
end

function UdimoController:playNextFriendInteractEmoji(friendId)
	local scene = self:getUdimoScene()

	if not scene or not friendId then
		return
	end

	local nextEmojiData = UdimoModel.instance:getNextFriendInteractEmoji(friendId)

	if nextEmojiData then
		local udimoId = UdimoModel.instance:getInteractPointUdimo(nextEmojiData.interactId)

		scene.udimomgr:updateUdimoCurStateParam(udimoId, UdimoEnum.UdimoState.Interact, {
			friendId = friendId,
			emojiId = nextEmojiData.emojiId
		})
	else
		local useBg = UdimoItemModel.instance:getUseBg()
		local udimo1, udimo2 = UdimoConfig.instance:getFriendUidmo(useBg, friendId)

		self:_udimoInteractFinished(udimo1)
		self:_udimoInteractFinished(udimo2)
		UdimoModel.instance:setFriendInteractEmojiList(friendId, true)
	end
end

function UdimoController:_udimoInteractFinished(udimoId)
	local interactId = UdimoModel.instance:getUdimoInteractId(udimoId)

	UdimoModel.instance:setUdimoInteractPoint(interactId)

	local scene = self:getUdimoScene()

	if scene then
		::label_33_0::

		local udimoEntity = scene.udimomgr:getUdimoEntity(udimoId)

		if not udimoEntity then
			return
		end

		local triggerEvent = UdimoEvent.InteractFinished

		self:dispatchEvent(triggerEvent, udimoId, {
			eventId = triggerEvent
		})
	end
end

function UdimoController:playUdimoAnimation(udimoId, animName, isLoop, reStart, cb, cbObj, cbParam)
	self:dispatchEvent(UdimoEvent.PlayUdimoAnimation, udimoId, {
		name = animName,
		isLoop = isLoop,
		reStart = reStart
	}, cb, cbObj, cbParam)
end

function UdimoController:setCacheData(cacheKey, data)
	local cacheData = UdimoModel.instance:getCacheKeyData(cacheKey)

	if cacheData == data then
		return
	end

	UdimoModel.instance:setCacheKeyData(cacheKey, data)
	UdimoModel.instance:savePlayerCacheData()
end

function UdimoController:selectInfoViewHeadItem(index, isOpen)
	UdimoInfoListModel.instance:selectCell(index, true)

	local selectedUdimoId = UdimoInfoListModel.instance:getSelectedUdimoId()

	if selectedUdimoId then
		local cacheKey = UdimoHelper.getPlayerCacheDataKey(UdimoEnum.PlayerCacheDataKey.UdimoHasClicked, selectedUdimoId)

		self:setCacheData(cacheKey, true)
	end

	self:dispatchEvent(UdimoEvent.OnSelectInfoHeadItem, isOpen)
end

function UdimoController:selectDecoration(decorationId, notPreview)
	UdimoItemModel.instance:setSelectedDecorationId(decorationId)
	self:dispatchEvent(UdimoEvent.OnSelectDecorationItem, notPreview)
end

function UdimoController:changeUdimoLockSetting(settingId)
	local udimoSettingIdList = UdimoConfig.instance:getLockSettingIdList()

	if not tabletool.indexOf(udimoSettingIdList, settingId) then
		return
	end

	UdimoModel.instance:setUdimoSettingId(settingId)
end

UdimoController.instance = UdimoController.New()

return UdimoController
