-- chunkname: @modules/common/global/screen/GameFullViewState.lua

module("modules.common.global.screen.GameFullViewState", package.seeall)

local GameFullViewState = class("GameFullViewState")

function GameFullViewState:ctor()
	self:addConstEvents()

	self._sceneRootGO = nil
	self._ignoreViewNames = {}
	self._ignoreViewNames[ViewName.SettingsView] = true
	self._ignoreViewNames[ViewName.GMPostProcessView] = true
	self._ignoreViewNames[ViewName.StoryBackgroundView] = true
	self._ignoreViewNames[ViewName.V1a6_CachotCollectionSelectView] = true
	self._ignoreSceneTypes = {}
	self._ignoreSceneTypes[SceneType.Summon] = true
	self._ignoreSceneTypes[SceneType.Explore] = true
	self._callGCViews = {}
	self._banGcKey = {}
end

function GameFullViewState:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._reOpenWhileOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyFullViewFinish, self._onFullViewDestroy, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onPlayViewAnim, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onPlayViewAnim, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onPlayViewAnimFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onPlayViewAnimFinish, self)
	GameGCMgr.instance:registerCallback(GameGCEvent.OnFullGC, self._onFullGC, self)
	GameGCMgr.instance:registerCallback(GameGCEvent.SetBanGc, self._onSetBanGC, self)
end

function GameFullViewState:_onFullViewDestroy(viewName)
	self._callGCViews[viewName] = true

	self:_delayGC()
end

function GameFullViewState:_onPlayViewAnim(viewName)
	self._callGCViews[viewName] = nil

	self:_cancelGCTask()
end

function GameFullViewState:_onPlayViewAnimFinish()
	if self:_needGC() then
		self:_delayGC()
	end
end

function GameFullViewState:_onFullGC()
	tabletool.clear(self._callGCViews)
	self:_cancelGCTask()
end

function GameFullViewState:_onSetBanGC(key, isBan)
	self._banGcKey[key] = isBan and true or nil
end

function GameFullViewState:_delayGC()
	self:_cancelGCTask()
	TaskDispatcher.runDelay(self._gc, self, 1.5)
end

function GameFullViewState:_cancelGCTask()
	TaskDispatcher.cancelTask(self._gc, self)
end

function GameFullViewState:_gc()
	if next(self._banGcKey) then
		return
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
end

function GameFullViewState:isBanGC()
	return next(self._banGcKey)
end

function GameFullViewState:_needGC()
	for _, _ in pairs(self._callGCViews) do
		return true
	end
end

function GameFullViewState:_onOpenFullView(viewName)
	if self._ignoreViewNames[viewName] then
		return
	end

	local curScene = GameSceneMgr.instance:getCurScene()

	if not curScene then
		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if not curSceneType or self._ignoreSceneTypes[curSceneType] then
		return
	end

	local curSceneRootGO = curScene:getSceneContainerGO()

	if self._sceneRootGO and curSceneRootGO ~= self._sceneRootGO then
		gohelper.setActive(self._sceneRootGO, true)
	end

	self._sceneRootGO = curSceneRootGO

	gohelper.setActive(self._sceneRootGO, false)
	CameraMgr.instance:setSceneCameraActive(false, "fullviewstate")

	if curSceneType == SceneType.Fight then
		CameraMgr.instance:setVirtualCameraChildActive(false, "light")
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SceneGoChangeVisible, false)
end

function GameFullViewState:forceSceneCameraActive(active)
	local curScene = GameSceneMgr.instance:getCurScene()
	local curSceneRootGO = curScene and curScene:getSceneContainerGO()

	gohelper.setActive(curSceneRootGO, active)
	CameraMgr.instance:setSceneCameraActive(active, "fullviewstate")
end

function GameFullViewState:_onCloseFullView(viewName)
	if self._ignoreViewNames[viewName] then
		return
	end

	if not self:_hasOpenFullView() then
		gohelper.setActive(self._sceneRootGO, true)
		CameraMgr.instance:setSceneCameraActive(true, "fullviewstate")

		local curSceneType = GameSceneMgr.instance:getCurSceneType()

		if curSceneType == SceneType.Fight then
			CameraMgr.instance:setVirtualCameraChildActive(true, "light")
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.SceneGoChangeVisible, true)
	end
end

function GameFullViewState:_hasOpenFullView()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewNameList) do
		if ViewMgr.instance:isFull(viewName) and not self._ignoreViewNames[viewName] then
			local viewContainer = ViewMgr.instance:getContainer(viewName)

			if viewContainer and viewContainer:isOpenFinish() then
				return true
			end
		end
	end

	return false
end

function GameFullViewState:getOpenFullViewNames()
	local nameList = ""
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewNameList) do
		if ViewMgr.instance:isFull(viewName) and not self._ignoreViewNames[viewName] then
			nameList = nameList .. viewName .. ","
		end
	end

	return nameList
end

function GameFullViewState:_reOpenWhileOpen(viewName)
	if ViewMgr.instance:isFull(viewName) then
		self:_onOpenFullView(viewName)
	end
end

return GameFullViewState
