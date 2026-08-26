-- chunkname: @modules/logic/scene/view/LoadingRoomViewContainer.lua

module("modules.logic.scene.view.LoadingRoomViewContainer", package.seeall)

local LoadingRoomViewContainer = class("LoadingRoomViewContainer", BaseViewContainer)

function LoadingRoomViewContainer:buildViews()
	return {
		LoadingRoomView.New()
	}
end

function LoadingRoomViewContainer:playCloseTransition()
	UIBlockMgrExtend.setNeedCircleMv(false)
	LoadingRoomViewContainer.super.playCloseTransition(self)
end

function LoadingRoomViewContainer:onPlayCloseTransitionFinish()
	UIBlockMgrExtend.setNeedCircleMv(true)
	LoadingRoomViewContainer.super.onPlayCloseTransitionFinish(self)
end

return LoadingRoomViewContainer
