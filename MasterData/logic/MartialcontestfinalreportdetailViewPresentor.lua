-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalreportdetailViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalreportdetailViewPresentor", package.seeall)

local MartialcontestfinalreportdetailViewPresentor = class("MartialcontestfinalreportdetailViewPresentor", ViewPresentor)

function MartialcontestfinalreportdetailViewPresentor:ctor()
	MartialcontestfinalreportdetailViewPresentor.super.ctor(self)
end

function MartialcontestfinalreportdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalreportdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalreportdetailview.prefab"
	}
end

function MartialcontestfinalreportdetailViewPresentor:buildViews()
	return {
		MartialcontestfinalreportdetailView.New()
	}
end

return MartialcontestfinalreportdetailViewPresentor
