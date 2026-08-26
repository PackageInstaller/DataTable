-- chunkname: @modules/logic/scene/view/LoadingBlackView.lua

module("modules.logic.scene.view.LoadingBlackView", package.seeall)

local LoadingBlackView = class("LoadingBlackView", BaseView)
local ForceCloseLoadingDelay = 60

function LoadingBlackView:addEvents()
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.AgainOpenLoading, self._againOpenLoading, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self.closeThis, self)
	TaskDispatcher.runDelay(self._errorCloseLoading, self, ForceCloseLoadingDelay)
end

function LoadingBlackView:removeEvents()
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.AgainOpenLoading, self._againOpenLoading, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self.closeThis, self)
	TaskDispatcher.cancelTask(self._errorCloseLoading, self)
end

function LoadingBlackView:_againOpenLoading()
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(self._errorCloseLoading, self)
	TaskDispatcher.runDelay(self._errorCloseLoading, self, ForceCloseLoadingDelay)
end

function LoadingBlackView:_errorCloseLoading()
	local sceneType = GameSceneMgr.instance:getCurSceneType()
	local sceneId = GameSceneMgr.instance:getCurSceneId()
	local isLoading = GameSceneMgr.instance:isLoading()

	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", sceneType or -1, sceneId or -1, isLoading and "true" or "false"))
	self:closeThis()
end

return LoadingBlackView
