-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastGameViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastGameViewPresentor", package.seeall)

local PanTaoFeastGameViewPresentor = class("PanTaoFeastGameViewPresentor", ViewPresentor)

function PanTaoFeastGameViewPresentor:ctor()
	PanTaoFeastGameViewPresentor.super.ctor(self)
end

function PanTaoFeastGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastGameViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastgameview.prefab"
	}
end

function PanTaoFeastGameViewPresentor:buildViews()
	return {
		PanTaoFeastGameView.New()
	}
end

return PanTaoFeastGameViewPresentor
