-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiMainViewPresentor", package.seeall)

local MississiMainViewPresentor = class("MississiMainViewPresentor", ViewPresentor)

function MississiMainViewPresentor:ctor()
	MississiMainViewPresentor.super.ctor(self)
end

function MississiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MississiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mississi/mississimainview.prefab"
	}
end

function MississiMainViewPresentor:buildViews()
	return {
		MississiMainView.New()
	}
end

return MississiMainViewPresentor
