-- chunkname: @modules/logic/scene/view/LoadingRoomView.lua

module("modules.logic.scene.view.LoadingRoomView", package.seeall)

local LoadingRoomView = class("LoadingRoomView", LoadingBlackView)

function LoadingRoomView:onInitView()
	LoadingRoomView.super.onInitView(self)
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_mist)
end

return LoadingRoomView
