-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastBackpackViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastBackpackViewPresentor", package.seeall)

local PanTaoFeastBackpackViewPresentor = class("PanTaoFeastBackpackViewPresentor", ViewPresentor)

function PanTaoFeastBackpackViewPresentor:ctor()
	PanTaoFeastBackpackViewPresentor.super.ctor(self)
end

function PanTaoFeastBackpackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastBackpackViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastbackpackview.prefab"
	}
end

function PanTaoFeastBackpackViewPresentor:buildViews()
	return {
		PanTaoFeastBackpackView.New()
	}
end

return PanTaoFeastBackpackViewPresentor
