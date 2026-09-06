-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsSelectViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKFinalsSelectViewPresentor", package.seeall)

local TCKFinalsSelectViewPresentor = class("TCKFinalsSelectViewPresentor", ViewPresentor)

function TCKFinalsSelectViewPresentor:ctor()
	TCKFinalsSelectViewPresentor.super.ctor(self)
end

function TCKFinalsSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKFinalsSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckfinalsselectview.prefab"
	}
end

function TCKFinalsSelectViewPresentor:buildViews()
	return {
		TCKFinalsSelectView.New()
	}
end

return TCKFinalsSelectViewPresentor
