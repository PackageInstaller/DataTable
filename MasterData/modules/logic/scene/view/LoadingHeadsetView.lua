-- chunkname: @modules/logic/scene/view/LoadingHeadsetView.lua

module("modules.logic.scene.view.LoadingHeadsetView", package.seeall)

local LoadingHeadsetView = class("LoadingHeadsetView", BaseView)

function LoadingHeadsetView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoadingHeadsetView:addEvents()
	return
end

function LoadingHeadsetView:removeEvents()
	return
end

function LoadingHeadsetView:_editableInitView()
	return
end

function LoadingHeadsetView:onUpdateParam()
	return
end

function LoadingHeadsetView:onOpen()
	TaskDispatcher.runDelay(self._onShowFinished, self, 4.5)
	TaskDispatcher.runDelay(self.closeThis, self, 4.667)
end

function LoadingHeadsetView:_onShowFinished()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitCloseHeadsetView)
end

function LoadingHeadsetView:onClose()
	return
end

function LoadingHeadsetView:onDestroyView()
	TaskDispatcher.cancelTask(self._onShowFinished, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return LoadingHeadsetView
