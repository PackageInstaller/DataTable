-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemixixi/view/DivineMiXiXiViewPresentor.lua

module("logic.extensions.divinemixixi.view.DivineMiXiXiViewPresentor", package.seeall)

local DivineMiXiXiViewPresentor = class("DivineMiXiXiViewPresentor", ViewPresentor)

function DivineMiXiXiViewPresentor:ctor()
	DivineMiXiXiViewPresentor.super.ctor(self)
end

function DivineMiXiXiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiXiXiViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemixixi/divinemixixiview.prefab"
	}
end

function DivineMiXiXiViewPresentor:buildViews()
	return {
		DivineMiXiXiView.New()
	}
end

return DivineMiXiXiViewPresentor
