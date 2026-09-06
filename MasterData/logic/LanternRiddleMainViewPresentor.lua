-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/LanternRiddleMainViewPresentor.lua

module("logic.extensions.lanternriddle.view.LanternRiddleMainViewPresentor", package.seeall)

local LanternRiddleMainViewPresentor = class("LanternRiddleMainViewPresentor", ViewPresentor)

function LanternRiddleMainViewPresentor:ctor()
	LanternRiddleMainViewPresentor.super.ctor(self)
end

function LanternRiddleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternRiddleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternriddle/lanternriddlemainview.prefab"
	}
end

function LanternRiddleMainViewPresentor:buildViews()
	return {
		LanternRiddleMainView.New()
	}
end

return LanternRiddleMainViewPresentor
