-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapScene.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapScene", package.seeall)

local VersionActivity2_9DungeonMapScene = class("VersionActivity2_9DungeonMapScene", VersionActivityFixedDungeonMapScene)

function VersionActivity2_9DungeonMapScene:_editableInitView()
	VersionActivity2_9DungeonMapScene.super._editableInitView(self)

	local setting = self.viewContainer:getSetting()

	self._mapPosYCurve = self.viewContainer._abLoader:getAssetItem(setting.otherRes[5]):GetResource()
	self._mapPosZCurve = self.viewContainer._abLoader:getAssetItem(setting.otherRes[6]):GetResource()
	self._mapWorldPos = Vector3()
	self._mapLocalPos = Vector3()
	self._offset = Vector2()
	self._tempVector2 = Vector2()
	self._tempVector3 = Vector3()

	self:initBg()
end

function VersionActivity2_9DungeonMapScene:addEvents()
	VersionActivity2_9DungeonMapScene.super.addEvents(self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnAllWorkLoadDone, self._onAllWorkLoadDone, self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnScrollEpisodeList, self._onScrollEpisodeList, self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnSelectEpisodeItem, self._onSelectEpisodeItem, self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnEpisodeListVisible, self._onEpisodeListVisible, self)
	self.addEventCb(self, VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.FocusEpisodeNode, self._focusEpisodeNode, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._initMapMoveRange, self, LuaEventSystem.High)
end

function VersionActivity2_9DungeonMapScene:initBg()
	local setting = self.viewContainer:getSetting()

	self._gobgroot = self:getResInst(setting.otherRes[4], self._sceneRoot, "bgroot")
	self._gocanvas = gohelper.findChild(self._gobgroot, "Canvas")
	self._canvas = self._gocanvas:GetComponent("Canvas")
	self._canvas.worldCamera = CameraMgr.instance:getMainCamera()
	self._govideo = gohelper.findChild(self._gobgroot, "Canvas/#go_video")
	self._bgVideoComp = VersionActivityVideoComp.get(self._govideo, self)

	self._bgVideoComp:play(langVideoUrl(VersionActivity2_9DungeonEnum.MapBgAudioName), true)
end

function VersionActivity2_9DungeonMapScene:refreshMap(needTween, mapCfg)
	self._mapCfg = mapCfg or VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)
	self.needTween = needTween

	if self._mapCfg.id == self._lastLoadMapId then
		if not self.loadedDone then
			return
		end

		self:_initElements()
		self:_setMapPos()
		self:_initSelectEpisode()
	elseif self._mapCfg.res == self._lastLoadMapRes then
		if not self.loadedDone then
			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, self.viewName)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
			mapConfig = self._mapCfg,
			mapSceneGo = self._sceneGo
		})

		self._lastLoadMapId = self._mapCfg.id

		self:_initElements()
		self:_setMapPos()
		self:_initSelectEpisode()
	else
		self:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

function VersionActivity2_9DungeonMapScene:loadMap()
	VersionActivity2_9DungeonMapScene.super.loadMap(self)

	self._lastLoadMapId = self._mapCfg.id
	self._lastLoadMapRes = self._mapCfg.res
end

function VersionActivity2_9DungeonMapScene:_disposeScene()
	VersionActivity2_9DungeonMapScene.super._disposeScene(self)

	self.loadedDone = false
	self._lastLoadMapId = nil
	self._lastLoadMapRes = nil
	self._episodeNodeList = nil
	self._curSelectIndex = nil
end

function VersionActivity2_9DungeonMapScene:_loadSceneFinish()
	VersionActivity2_9DungeonMapScene.super._loadSceneFinish(self)

	self._goroot = gohelper.findChild(self._sceneGo, "root")
	self._tranroot = self._goroot.transform
	self._goelementroot = gohelper.findChild(self._sceneGo, "elementRoot")
	self._tranelementroot = self._goelementroot.transform
	self._rootAnimator = gohelper.onceAddComponent(self._goroot, gohelper.Type_Animator)

	self:_buildEpisodeNodeList()
	self:_initMapMoveRange()
	self:_initSelectEpisode()
	self:_updateRootPosition(self._curRootLocalPosX, self._curRootLocalPosY, self._curRootLocalPosZ)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnOneWorkLoadDone, VersionActivity2_9DungeonEnum.LoadWorkType.Scene)
end

function VersionActivity2_9DungeonMapScene:_initSelectEpisode()
	local episodeId = self.activityDungeonMo.episodeId
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)

	for index, episodeCo in ipairs(episodeList) do
		if episodeCo.id == episodeId then
			self:_onSelectEpisodeItem(index, true)

			break
		end
	end
end

function VersionActivity2_9DungeonMapScene:_initMapMoveRange()
	if not self.loadedDone then
		return
	end

	self._maxRootLocalPosX = self._sceneTrans:InverseTransformPoint(VersionActivity2_9DungeonEnum.MapStartWorldPos).x
	self._minRootLocalPosX = self._maxRootLocalPosX
	self._unlockEpisodeCount = VersionActivity2_9DungeonController.instance:getUnlockEpisodeCount(self.activityDungeonMo.chapterId)

	local lastFocusRootLocalPos = self:_getRootLocalPos4Focus(self._unlockEpisodeCount)

	if lastFocusRootLocalPos then
		if not lastFocusRootLocalPos.x then
			local tempMinRootLocalPosX = 0
			local swapValue = tempMinRootLocalPosX > self._maxRootLocalPosX

			if swapValue then
				self._minRootLocalPosX = self._maxRootLocalPosX or tempMinRootLocalPosX
			end

			self._maxRootLocalPosX = swapValue and tempMinRootLocalPosX or self._maxRootLocalPosX
		end
	end
end

function VersionActivity2_9DungeonMapScene:_buildEpisodeNodeList()
	self._episodeNodeList = self:getUserDataTb_()

	for i = 1, math.huge do
		local gonode = gohelper.findChild(self._sceneGo, string.format("root/node/dna_node_%02d", i))
		local gomesh = gohelper.findChild(self._sceneGo, string.format("root/level/mesh_dna_%02d", i))

		if gohelper.isNil(gonode) or gohelper.isNil(gomesh) then
			break
		end

		self._episodeNodeList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(gonode, VersionActivity2_9DungeonMapNodeItem, {
			index = i,
			meshGO = gomesh
		})
	end
end

function VersionActivity2_9DungeonMapScene:_onSelectEpisodeItem(levelIndex, isSelect)
	if not self.loadedDone then
		return
	end

	if self._curSelectIndex == levelIndex and isSelect then
		return
	end

	self:_playAnimtionForEpisodeNode(self._curSelectIndex, false)
	self:_playAnimtionForEpisodeNode(levelIndex, isSelect)
end

function VersionActivity2_9DungeonMapScene:_playAnimtionForEpisodeNode(levelIndex, isSelect)
	if not levelIndex then
		return
	end

	local episodeNode = self._episodeNodeList[levelIndex]

	if not episodeNode then
		logError(string.format("DNA缺少关卡节点 levelIndex = %s", levelIndex))

		return
	end

	episodeNode:onSelect(isSelect)

	if isSelect then
		self._rootAnimator:Play(string.format("s01_level_%02d", levelIndex))
	end

	self._curSelectIndex = isSelect and levelIndex or nil
end

function VersionActivity2_9DungeonMapScene:_brocastAllNodePos()
	if not self.loadedDone or not self._episodeNodeList then
		return
	end

	for _, nodeItem in ipairs(self._episodeNodeList) do
		nodeItem:brocastPosition()
	end
end

function VersionActivity2_9DungeonMapScene:_onScrollEpisodeList(offsetX, isEndDrag)
	if not self.loadedDone then
		return
	end

	local nextRootPosX, nextRootPosY, nextRootPosZ = self:_getNextRootPos(offsetX * VersionActivity2_9DungeonEnum.MapScrollOffsetRate)

	self:_updateRootPosition(nextRootPosX, nextRootPosY, nextRootPosZ)
	TaskDispatcher.cancelTask(self._simulateEndDragTween, self)

	if isEndDrag then
		self._stopVelocity = offsetX or 0
		self._stopVelocity = self._stopVelocity * VersionActivity2_9DungeonEnum.MapStopVelocityRate

		TaskDispatcher.runRepeat(self._simulateEndDragTween, self, 0.01)
	end
end

function VersionActivity2_9DungeonMapScene:_simulateEndDragTween()
	self._stopVelocity = Mathf.Lerp(self._stopVelocity, 0, VersionActivity2_9DungeonEnum.MapTweenStopLerp)

	if Mathf.Abs(self._stopVelocity, 0) <= 0.0001 then
		TaskDispatcher.cancelTask(self._simulateEndDragTween, self)

		return
	end

	local nextRootPosX, nextRootPosY, nextRootPosZ = self:_getNextRootPos(self._stopVelocity)

	self:_updateRootPosition(nextRootPosX, nextRootPosY, nextRootPosZ)
end

function VersionActivity2_9DungeonMapScene:_getNextRootPos(offsetX)
	local originNextRootLocalPosX = self._curRootLocalPosX + offsetX / VersionActivity2_9DungeonEnum.PixelPerUnit
	local nextRootLocalPosX, nextRootLocalPosY, nextRootLocalPosZ = self:_getRootLocalPosXYZ(originNextRootLocalPosX)

	return nextRootLocalPosX, nextRootLocalPosY, nextRootLocalPosZ
end

function VersionActivity2_9DungeonMapScene:_getRootLocalPosXYZ(rootLocalPosX)
	rootLocalPosX = Mathf.Clamp(rootLocalPosX, self._minRootLocalPosX, self._maxRootLocalPosX)

	local rootOffsetX = self._maxRootLocalPosX - rootLocalPosX
	local progress = rootOffsetX / VersionActivity2_9DungeonEnum.MapMaxPosXRange
	local rootLocalPosY = self._mapPosYCurve:GetY(progress)
	local rootLocalPosZ = self._mapPosZCurve:GetY(progress)

	return rootLocalPosX, rootLocalPosY, rootLocalPosZ
end

function VersionActivity2_9DungeonMapScene:_updateRootPosition(posX, posY, posZ)
	if not self._tranroot or not self._tranelementroot or gohelper.isNil(self._goroot) or gohelper.isNil(self._goelementroot) then
		return
	end

	self._curRootLocalPosX = posX or 0
	self._curRootLocalPosY = posY or 0
	self._curRootLocalPosZ = posZ or 0

	transformhelper.setLocalPos(self._tranroot, self._curRootLocalPosX, self._curRootLocalPosY, self._curRootLocalPosZ)
	transformhelper.setLocalPos(self._tranelementroot, self._curRootLocalPosX, self._curRootLocalPosY, self._curRootLocalPosZ)
	self:_brocastAllNodePos()
	self:_updateElementArrow()
end

function VersionActivity2_9DungeonMapScene:_onAllWorkLoadDone()
	self:_brocastAllNodePos()
	self:_tryFocusEpisodeNode()
end

function VersionActivity2_9DungeonMapScene:_onEpisodeListVisible(isShow)
	if not self.loadedDone then
		return
	end

	local rootPosY = VersionActivity2_9DungeonEnum.Map_Hide_Root_PosY

	if isShow then
		_, rootPosY = self:_getRootLocalPosXYZ(self._curRootLocalPosX)
	end

	self:killTween()

	self._isEpisodeListVisible = isShow
	self._mapTweenId = ZProj.TweenHelper.DOTweenFloat(self._curRootLocalPosY, rootPosY, VersionActivity2_9DungeonEnum.Map_Visible_Tween_Time, self._onUpdateEpisodeListVisibleFrameCb, self._onUpdateEpisodeListVisibleDoneCb, self)
end

function VersionActivity2_9DungeonMapScene:_onUpdateEpisodeListVisibleFrameCb(targetRootPosY)
	self:_updateRootPosition(self._curRootLocalPosX, targetRootPosY, self._curRootLocalPosZ)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnTweenEpisodeListVisible)
end

function VersionActivity2_9DungeonMapScene:_onUpdateEpisodeListVisibleDoneCb(targetRootPosY)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnEpisodeListVisibleDone, self._isEpisodeListVisible)
end

function VersionActivity2_9DungeonMapScene:_onDrag(param, pointerEventData)
	return
end

function VersionActivity2_9DungeonMapScene:directSetScenePos(targetPos)
	VersionActivity2_9DungeonMapScene.super.directSetScenePos(self, targetPos)
	self:_brocastAllNodePos()
end

function VersionActivity2_9DungeonMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = false
end

function VersionActivity2_9DungeonMapScene:_focusEpisodeNode(index, tween)
	self._focusIndex = index
	self._tween = tween

	if not self.loadedDone then
		return
	end

	self:_tryFocusEpisodeNode()
end

function VersionActivity2_9DungeonMapScene:_tryFocusEpisodeNode()
	if not self._focusIndex or not self._episodeNodeList[self._focusIndex] then
		return
	end

	local targetRootLocalPos = self:_getRootLocalPos4Focus(self._focusIndex)

	self:_tweenMap2TargetPos(targetRootLocalPos, self._tween)

	self._focusIndex = nil
	self._tween = false
end

function VersionActivity2_9DungeonMapScene:_tweenMap2TargetPos(targetRootLocalPos, tween)
	self:killTween()

	if tween then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._curRootLocalPosX, targetRootLocalPos.x, VersionActivity2_9DungeonEnum.TWEEN_TIME, self._tweenFocusEpisodeCb, self._tweenFocusEpisodeDone, self, nil, EaseType.Linear)
	else
		self:_tweenFocusEpisodeCb(targetRootLocalPos.x)
		TaskDispatcher.cancelTask(self._tweenFocusEpisodeDone, self)
		TaskDispatcher.runDelay(self._tweenFocusEpisodeDone, self, 0.1)
	end
end

function VersionActivity2_9DungeonMapScene:_getRootLocalPos4Focus(focusIndex)
	local focusNode = self._episodeNodeList[focusIndex]

	if not focusNode then
		return
	end

	local focusNodeLocalPosX, focusNodeLocalPosY, focusNodeLocalPosZ = focusNode:getNodeLocalPos()

	return (self:_rootLocalPosX2TargetFocusRootLocalPos(focusNodeLocalPosX, focusNodeLocalPosY, focusNodeLocalPosZ))
end

function VersionActivity2_9DungeonMapScene:_rootLocalPosX2TargetFocusRootLocalPos(focusNodeLocalPosX, focusNodeLocalPosY, focusNodeLocalPosZ)
	local uiCamera = CameraMgr.instance:getUICamera()
	local originNextRootLocalPosX = self._maxRootLocalPosX - focusNodeLocalPosX
	local nextRootLocalPosX, nextRootLocalPosY, nextRootLocalPosZ = self:_getRootLocalPosXYZ(originNextRootLocalPosX)
	local scenePosX, scenePosY, scenePosZ = transformhelper.getPos(self._sceneTrans)
	local rootWorldPosX = scenePosX + nextRootLocalPosX
	local rootWorldPosY = scenePosY + nextRootLocalPosY
	local rootWorldPosZ = scenePosZ + nextRootLocalPosZ
	local nodeWorldPosX = rootWorldPosX + focusNodeLocalPosX
	local nodeWorldPosY = rootWorldPosY + focusNodeLocalPosY
	local nodeWorldPosZ = rootWorldPosZ + focusNodeLocalPosZ
	local nodeScreenPosX = recthelper.worldPosToScreenPoint(uiCamera, nodeWorldPosX, nodeWorldPosY, nodeWorldPosZ)
	local rootScreenPosX, rootScreenPosY = recthelper.worldPosToScreenPoint(uiCamera, rootWorldPosX, rootWorldPosY, rootWorldPosZ)
	local screenOffsetX = UnityEngine.Screen.width / VersionActivity2_9DungeonEnum.MapFocusScale - nodeScreenPosX

	rootScreenPosX = rootScreenPosX + screenOffsetX

	self._tempVector2:Set(rootScreenPosX, rootScreenPosY)

	local targetRootWorldPosX, targetRootWorldPosY, targetRootWorldPosZ = recthelper.screenPosToWorldPos3(self._tempVector2, uiCamera, self._sceneTrans.position)

	self._tempVector3:Set(targetRootWorldPosX, targetRootWorldPosY, targetRootWorldPosZ)

	return (self._sceneTrans:InverseTransformPoint(self._tempVector3))
end

function VersionActivity2_9DungeonMapScene:_tweenFocusEpisodeCb(originRootLocalPosX)
	local rootLocalPosX, rootLocalPosY, rootLocalPosZ = self:_getRootLocalPosXYZ(originRootLocalPosX)

	self:_updateRootPosition(rootLocalPosX, rootLocalPosY, rootLocalPosZ)
end

function VersionActivity2_9DungeonMapScene:_tweenFocusEpisodeDone()
	self:_brocastAllNodePos()
	self:_updateElementArrow()
end

function VersionActivity2_9DungeonMapScene:focusElementByCo(elementCo)
	if not self.loadedDone then
		return
	end

	local elementPosList = string.splitToNumber(elementCo.pos, "#")
	local targetRootLocalPos = self:_rootLocalPosX2TargetFocusRootLocalPos(elementPosList[1], elementPosList[2], elementPosList[3])

	self:_tweenMap2TargetPos(targetRootLocalPos, true)
end

function VersionActivity2_9DungeonMapScene:killTween()
	VersionActivity2_9DungeonMapScene.super.killTween(self)
	self:_killMapVisibleTween()
	self:_killMapFocusTween()
	TaskDispatcher.cancelTask(self._tweenFocusEpisodeDone, self)
	TaskDispatcher.cancelTask(self._simulateEndDragTween, self)
end

function VersionActivity2_9DungeonMapScene:_killMapVisibleTween()
	if self._mapTweenId then
		ZProj.TweenHelper.KillById(self._mapTweenId)

		self._mapTweenId = nil
	end
end

function VersionActivity2_9DungeonMapScene:_killMapFocusTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity2_9DungeonMapScene:onClose()
	VersionActivity2_9DungeonMapScene.super.onClose(self)

	self.loadedDone = false
end

function VersionActivity2_9DungeonMapScene:onCloseFinish()
	VersionActivity2_9DungeonMapScene.super.onCloseFinish(self)
	transformhelper.setPosXY(self._sceneRoot.transform, 100000, 0, 0)
end

function VersionActivity2_9DungeonMapScene:onDestroyView()
	VersionActivity2_9DungeonMapScene.super.onDestroyView(self)

	if self._bgVideoComp then
		self._bgVideoComp:destroy()

		self._bgVideoComp = nil
	end
end

return VersionActivity2_9DungeonMapScene
