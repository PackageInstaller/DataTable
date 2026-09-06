-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalreportViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalreportViewPresentor", package.seeall)

local MartialcontestfinalreportViewPresentor = class("MartialcontestfinalreportViewPresentor", ViewPresentor)

function MartialcontestfinalreportViewPresentor:ctor()
	MartialcontestfinalreportViewPresentor.super.ctor(self)
end

function MartialcontestfinalreportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalreportViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalreportview.prefab"
	}
end

function MartialcontestfinalreportViewPresentor:buildViews()
	return {
		MartialcontestfinalreportView.New()
	}
end

return MartialcontestfinalreportViewPresentor
