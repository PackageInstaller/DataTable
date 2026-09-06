-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKDisplayViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKDisplayViewPresentor", package.seeall)

local TCKDisplayViewPresentor = class("TCKDisplayViewPresentor", ViewPresentor)

function TCKDisplayViewPresentor:ctor()
	TCKDisplayViewPresentor.super.ctor(self)
end

function TCKDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckdisplayview.prefab"
	}
end

function TCKDisplayViewPresentor:buildViews()
	return {
		TCKDisplayView.New()
	}
end

return TCKDisplayViewPresentor
