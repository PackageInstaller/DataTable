-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapScene.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapScene", package.seeall)

local VersionActivity3_10DungeonMapScene = class("VersionActivity3_10DungeonMapScene", VersionActivityFixedDungeonMapScene)

function VersionActivity3_10DungeonMapScene:addEvents()
	VersionActivity3_10DungeonMapScene.super.addEvents(self)
	self.addEventCb(self, VersionActivity3_10DungeonController.instance, VersionActivity3_10Event.OnScrollEpisodeList, self._onScrollEpisodeList, self)
end

function VersionActivity3_10DungeonMapScene:_onOpenView(viewName)
	return
end

function VersionActivity3_10DungeonMapScene:_onCloseView(viewName)
	return
end

function VersionActivity3_10DungeonMapScene:_initScene()
	VersionActivity3_10DungeonMapScene.super._initScene(self)
	self:_setMapPos()
	self:resetScrollValue()
end

function VersionActivity3_10DungeonMapScene:refreshMap(needTween, mapCfg)
	self._mapCfg = mapCfg or DungeonConfig.instance:getChapterMapCfg(VersionActivity3_10DungeonEnum.DungeonChapterId.Story, 0)
	self.needTween = needTween

	if self._mapCfg.id == self._lastLoadMapId then
		if not self.loadedDone then
			return
		end

		self:_initElements()
		self:_setMapPos()
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
	else
		self:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

function VersionActivity3_10DungeonMapScene:loadMap()
	VersionActivity3_10DungeonMapScene.super.loadMap(self)

	self._lastLoadMapId = self._mapCfg.id
	self._lastLoadMapRes = self._mapCfg.res
end

function VersionActivity3_10DungeonMapScene:_disposeScene()
	VersionActivity3_10DungeonMapScene.super._disposeScene(self)

	self.loadedDone = false
	self._lastLoadMapId = nil
	self._lastLoadMapRes = nil
end

function VersionActivity3_10DungeonMapScene:_loadSceneFinish()
	VersionActivity3_10DungeonMapScene.super._loadSceneFinish(self)

	local pos = self._mapCfg.initPos
	local posParam = pos and string.splitToNumber(pos, "#") or {}

	self._initPosX = posParam[1] or 0
	self._initPosY = posParam[2] or 0
	self._sceneAnimator = gohelper.onceAddComponent(self._sceneGo, gohelper.Type_Animator)
	self._sceneAnimator.speed = 0

	self:resetScrollValue()
end

function VersionActivity3_10DungeonMapScene:playAnimSlider(value)
	if self._sceneAnimator then
		self._sceneAnimator:Play("slide", 0, value)
	end

	self._scrollValue = value
end

function VersionActivity3_10DungeonMapScene:_onScrollEpisodeList(value, isEndDrag)
	if not self.loadedDone then
		self._scrollValue = value

		return
	end

	self:playAnimSlider(value)
	self:sliderElementRoot(value)
end

function VersionActivity3_10DungeonMapScene:sliderElementRoot(value)
	local size = self._mapMaxX - self._mapMinX
	local deltaPosX = size * value
	local startPosX = 0
	local posX = startPosX - deltaPosX

	if self.mapSceneElementsView then
		self.mapSceneElementsView:setPosX(posX)
	end
end

function VersionActivity3_10DungeonMapScene:resetScrollValue()
	if self._scrollValue then
		local value = self._scrollValue

		self._scrollValue = nil

		self:_onScrollEpisodeList(value)
	end
end

function VersionActivity3_10DungeonMapScene:focusElementByCo(elementCo)
	return
end

function VersionActivity3_10DungeonMapScene:setVisible(isVisible)
	VersionActivity3_10DungeonMapScene.super.setVisible(self, isVisible)

	if isVisible then
		self:resetScrollValue()
	end
end

function VersionActivity3_10DungeonMapScene:onClose()
	VersionActivity3_10DungeonMapScene.super.onClose(self)

	self.loadedDone = false
end

return VersionActivity3_10DungeonMapScene
