-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiResultViewPresentor", package.seeall)

local MississiResultViewPresentor = class("MississiResultViewPresentor", ViewPresentor)

function MississiResultViewPresentor:ctor()
	MississiResultViewPresentor.super.ctor(self)
end

function MississiResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MississiResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mississi/mississiresultview.prefab"
	}
end

function MississiResultViewPresentor:buildViews()
	return {
		MississiResultView.New()
	}
end

return MississiResultViewPresentor
