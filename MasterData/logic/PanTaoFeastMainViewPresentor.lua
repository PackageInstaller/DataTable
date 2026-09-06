-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastMainViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastMainViewPresentor", package.seeall)

local PanTaoFeastMainViewPresentor = class("PanTaoFeastMainViewPresentor", ViewPresentor)

function PanTaoFeastMainViewPresentor:ctor()
	PanTaoFeastMainViewPresentor.super.ctor(self)
end

function PanTaoFeastMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastmainview.prefab"
	}
end

function PanTaoFeastMainViewPresentor:buildViews()
	return {
		PanTaoFeastMainView.New()
	}
end

return PanTaoFeastMainViewPresentor
