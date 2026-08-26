-- chunkname: @modules/logic/scene/summon/VirtualSummonScene.lua

module("modules.logic.scene.summon.VirtualSummonScene", package.seeall)

local VirtualSummonScene = class("VirtualSummonScene")

function VirtualSummonScene:ctor()
	self._curSceneType = SceneType.Summon
	self._curSceneId = SummonEnum.SummonSceneId

	local levelCOs = SceneConfig.instance:getSceneLevelCOs(self._curSceneId)

	if levelCOs and #levelCOs > 0 then
		self._curLevelId = levelCOs[1].id
	else
		logError("levelID Error in SummonScene : " .. tostring(self._curSceneId))
	end

	self._isOpenImmediately = false
	self._isOpen = false

	self:checkInitLoader()

	self._sceneObj = SummonSceneShell.New()

	self._sceneObj:init(self._curSceneId, self._curSceneLevel)
end

function VirtualSummonScene:createLoader(resMap, extendPath)
	local loader = SummonLoader.New()
	local targetResList = {}

	for k, path in pairs(resMap) do
		table.insert(targetResList, path)
	end

	table.insert(targetResList, extendPath)
	loader:init(targetResList)
	loader:setLoadOneItemCallback(self.onLoadOneCallback, self)
	loader:setLoadFinishCallback(self.onLoadAllCompleted, self)

	return loader
end

function VirtualSummonScene:checkInitLoader()
	local curScenePath = SummonController.getCharScenePrefabPath()
	local isNeedChangeScene = false

	if self.charGoPath == nil or self.charGoPath ~= curScenePath then
		self.charGoPath = curScenePath

		logNormal("切换抽卡皮肤路径")

		isNeedChangeScene = true
	end

	if not self._loaderChar then
		local preloadUrlMap = tabletool.copy(SummonEnum.SummonCharPreloadPath)

		if SummonConfig.instance:isLuckyBagPoolExist() then
			self:addUrlToPreloadMap(preloadUrlMap, SummonEnum.SummonLuckyBagPreloadPath)
		end

		self._loaderChar = self:createLoader(preloadUrlMap, self.charGoPath)
		self._isCharLoaded = false
	elseif isNeedChangeScene and not self._loaderChar:isResInList(curScenePath) then
		logNormal("添加抽卡皮肤路径")
		self._loaderChar:addSceneUrl(curScenePath)
	end
end

function VirtualSummonScene:addUrlToPreloadMap(urlMap, targetMap)
	for k, v in pairs(targetMap) do
		urlMap[k] = v
	end
end

function VirtualSummonScene:checkNeedLoad(isChar, needSync)
	if isChar then
		if self._loaderChar ~= nil then
			self._loaderChar:checkStartLoad(needSync)
		end
	else
		logError("other loader is not implement!")
	end
end

function VirtualSummonScene:onLoadOneCallback(url, assetItem)
	if url == self.charGoPath then
		self:getSummonScene().selector:initCharSceneGo(assetItem)
	else
		SummonEffectPool.onEffectPreload(assetItem)
	end
end

function VirtualSummonScene:onLoadAllCompleted(loader)
	local isChar = loader == self._loaderChar

	if isChar then
		self._isCharLoaded = true
	end

	self:dispatchEvent(SummonSceneEvent.OnPreloadFinish, isChar)
end

function VirtualSummonScene:onEnterScene()
	return
end

function VirtualSummonScene:onCloseFullView(viewName, viewParam)
	local curScene = GameSceneMgr.instance:getCurScene()

	if curScene and not gohelper.isNil(curScene:getSceneContainerGO()) then
		gohelper.setActive(curScene:getSceneContainerGO(), false)
	end
end

function VirtualSummonScene:onCloseView(viewName)
	if viewName == ViewName.SummonView and self:isOpen() then
		self:close(true)
	end
end

function VirtualSummonScene:onClickHome()
	self:close(true)
end

function VirtualSummonScene:openSummonScene(immediately)
	if self._isOpen then
		return
	end

	self._isOpen = true
	self._isOpenImmediately = immediately

	self:checkInitRootGO()
	self:checkInitLoader()
	gohelper.setActive(self:getRootGO(), true)

	local scene = self:getSummonScene()

	scene:onStart(self._curSceneId, self._curLevelId)

	if self._isOpenImmediately then
		self._loaderChar:checkStartLoad(true)
	end

	local curScene = GameSceneMgr.instance:getCurScene()

	if curScene and not gohelper.isNil(curScene:getSceneContainerGO()) then
		gohelper.setActive(curScene:getSceneContainerGO(), false)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self.onCloseFullView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onCloseView, self)
	NavigateMgr.instance:registerCallback(NavigateEvent.ClickHome, self.onClickHome, self)
	self._sceneObj.director:registerCallback(SummonSceneEvent.OnEnterScene, self.onEnterScene, self)
	self:checkCloseOldSceneUI()
end

function VirtualSummonScene:close(isRelease)
	if not self._isOpen then
		return
	end

	logNormal("VirtualSummonScene close")

	self._isOpen = false
	self._isOpenImmediately = false

	if isRelease then
		self:release()
	else
		self:hide()
	end

	self:checkResumeMainScene()
	MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, true)
end

function VirtualSummonScene:checkCloseOldSceneUI()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewRootVisible, false)
	else
		ViewMgr.instance:closeAllViews({
			ViewName.SummonADView,
			ViewName.SummonView
		})
	end
end

function VirtualSummonScene:checkResumeMainScene()
	local curScene = GameSceneMgr.instance:getCurScene()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		local scene = GameSceneMgr.instance:getCurScene()

		scene.camera:resetParam()
		scene.camera:applyDirectly()
	end

	if curScene and not gohelper.isNil(curScene:getSceneContainerGO()) then
		gohelper.setActive(curScene:getSceneContainerGO(), true)
	end
end

function VirtualSummonScene:checkInitRootGO()
	if gohelper.isNil(self._rootGO) then
		self._rootGO = gohelper.create3d(CameraMgr.instance:getSceneRoot(), "VirtualSummonScene")
	end
end

function VirtualSummonScene:getSummonScene()
	return self._sceneObj
end

function VirtualSummonScene:getRootGO()
	return self._rootGO
end

function VirtualSummonScene:isOpenImmediately()
	return self._isOpenImmediately
end

function VirtualSummonScene:isOpen()
	return self._isOpen
end

function VirtualSummonScene:isABLoaded(isChar)
	if isChar then
		return self._isCharLoaded
	end

	return false
end

function VirtualSummonScene:hide()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self.onCloseFullView, self)
	self._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, self.onEnterScene, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseView, self)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, self.onClickHome, self)

	local go = self:getRootGO()

	gohelper.setActive(go, false)
	self:getSummonScene():onHide()
end

function VirtualSummonScene:release()
	self:getSummonScene():onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self.onCloseFullView, self)
	self._sceneObj.director:unregisterCallback(SummonSceneEvent.OnEnterScene, self.onEnterScene, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseView, self)
	NavigateMgr.instance:unregisterCallback(NavigateEvent.ClickHome, self.onClickHome, self)

	self._isCharLoaded = false

	SummonEffectPool.dispose()
	self._loaderChar:dispose()

	self._loaderChar = nil

	gohelper.destroy(self._rootGO)

	self._rootGO = nil
end

VirtualSummonScene.instance = VirtualSummonScene.New()

LuaEventSystem.addEventMechanism(VirtualSummonScene.instance)

return VirtualSummonScene
