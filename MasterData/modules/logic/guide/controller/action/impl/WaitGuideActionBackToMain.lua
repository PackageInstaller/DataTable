-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionBackToMain.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionBackToMain", package.seeall)

local WaitGuideActionBackToMain = class("WaitGuideActionBackToMain", BaseGuideAction)

function WaitGuideActionBackToMain:onStart(context)
	WaitGuideActionBackToMain.super.onStart(self, context)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onEnterMainScene, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._checkInMain, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkInMain, self)

	self._needView = self.actionParam

	self:_checkInMain()
end

function WaitGuideActionBackToMain:_onEnterMainScene(sceneId, enterOrExit)
	if enterOrExit == 1 then
		self:_checkInMain()
	end
end

function WaitGuideActionBackToMain:_checkInMain()
	if self:checkGuideLock() then
		return
	end

	local inMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
	local isLoading = GameSceneMgr.instance:isLoading()
	local isClosing = GameSceneMgr.instance:isClosing()

	if inMainScene and not isLoading and not isClosing then
		local hasOpenAnyView = false
		local openViewNameList = ViewMgr.instance:getOpenViewNameList()

		for _, viewName in ipairs(openViewNameList) do
			if viewName ~= self._needView and (ViewMgr.instance:isModal(viewName) or ViewMgr.instance:isFull(viewName)) then
				hasOpenAnyView = true

				break
			end
		end

		if not hasOpenAnyView and (string.nilorempty(self._needView) or ViewMgr.instance:isOpen(self._needView)) then
			self:_removeEvents()
			self:onDone(true)
		end
	end
end

function WaitGuideActionBackToMain:_removeEvents()
	GameSceneMgr.instance:unregisterCallback(SceneType.Main, self._onEnterMainScene, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._checkInMain, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkInMain, self)
end

function WaitGuideActionBackToMain:clearWork()
	self:_removeEvents()
end

return WaitGuideActionBackToMain
