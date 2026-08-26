-- chunkname: @modules/logic/versionactivity3_1/dungeon/view/map/scene/VersionActivity3_1DungeonMapScene.lua

module("modules.logic.versionactivity3_1.dungeon.view.map.scene.VersionActivity3_1DungeonMapScene", package.seeall)

local VersionActivity3_1DungeonMapScene = class("VersionActivity3_1DungeonMapScene", VersionActivityFixedDungeonMapScene)

function VersionActivity3_1DungeonMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local gobg = gohelper.findChild(self._sceneGo, "root/BackGround")

	if sizeGo then
		VersionActivity3_1DungeonMapScene.super._initScene(self)
	else
		self._mapMinX = nil
		self._mapMaxX = nil
		self._mapMinY = nil
		self._mapMaxY = nil
	end

	if gobg then
		self._bgAnim = gobg:GetComponent(typeof(UnityEngine.Animator))
	end
end

function VersionActivity3_1DungeonMapScene:_playSceneAnim(animName)
	if string.nilorempty(animName) or not self._sceneGo then
		return
	end

	self._sceneAnim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if not self._sceneAnim then
		return
	end

	self._sceneAnim:Play(animName, 0, 0)
end

function VersionActivity3_1DungeonMapScene:refreshMap(needTween, mapCfg, isPlayAnim)
	self._sceneAnimName = nil

	if isPlayAnim then
		if self._lastEpisodeId and self.activityDungeonMo.episodeId ~= self._lastEpisodeId then
			local episodeId = self.activityDungeonMo.episodeId

			if episodeId > self._lastEpisodeId then
				self._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.left_close
			elseif episodeId < self._lastEpisodeId then
				self._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.right_close
			end
		end

		if not string.nilorempty(self._sceneAnimName) then
			self:_playSceneAnim(self._sceneAnimName)
		end
	end

	self._lastEpisodeId = self.activityDungeonMo.episodeId

	VersionActivity3_1DungeonMapScene.super.refreshMap(self, needTween, mapCfg)
end

function VersionActivity3_1DungeonMapScene:_loadSceneFinish()
	self.loadedDone = true

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish)

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	gohelper.setActive(self._sceneGo, string.nilorempty(self._sceneAnimName))
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = self._mapCfg,
		mapSceneGo = self._sceneGo
	})
	self:_initScene()
	self:_setMapPos()
	self:_addMapLight()
	self:_initElements()
	self:_addMapAudio()
end

function VersionActivity3_1DungeonMapScene:directSetScenePos(targetPos)
	VersionActivity3_1DungeonMapScene.super.directSetScenePos(self, targetPos)
	TaskDispatcher.cancelTask(self._endSceneAnim, self)

	if string.nilorempty(self._sceneAnimName) then
		self:_endSceneAnimCB()
	else
		TaskDispatcher.runDelay(self._endSceneAnim, self, VersionActivity3_1DungeonEnum.LevelAnimDelayTime)
	end
end

function VersionActivity3_1DungeonMapScene:_endSceneAnim()
	self:_endSceneAnimCB()

	local sceneName

	if not string.nilorempty(self._sceneAnimName) then
		if self._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.right_close then
			sceneName = VersionActivity3_1DungeonEnum.LevelAnim.right_open
		elseif self._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.left_close then
			sceneName = VersionActivity3_1DungeonEnum.LevelAnim.left_open
		end
	end

	if not string.nilorempty(sceneName) then
		self:_playSceneAnim(sceneName)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish)

	self._sceneAnimName = nil
end

function VersionActivity3_1DungeonMapScene:_endSceneAnimCB()
	self:disposeOldMap()
	gohelper.setActive(self._sceneGo, true)

	if self._bgAnim then
		self._bgAnim.enabled = self._mapCfg.playEffect == 1
	end
end

function VersionActivity3_1DungeonMapScene:onModeChange()
	VersionActivity3_1DungeonMapScene.super.onModeChange(self)
end

function VersionActivity3_1DungeonMapScene:onActivityDungeonMoChange()
	local needTween = VersionActivityFixedDungeonModel.instance:getMapNeedTweenState()

	self:refreshMap(needTween, nil, true)
end

function VersionActivity3_1DungeonMapScene:_onDragBegin(param, pointerEventData)
	return
end

function VersionActivity3_1DungeonMapScene:_onDrag(param, pointerEventData)
	return
end

function VersionActivity3_1DungeonMapScene:_onDragEnd(param, pointerEventData)
	return
end

function VersionActivity3_1DungeonMapScene:onClose()
	VersionActivity3_1DungeonMapScene.super.onClose(self)
	TaskDispatcher.cancelTask(self._endSceneAnim, self)
end

return VersionActivity3_1DungeonMapScene
