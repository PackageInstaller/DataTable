-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankjuesaiViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankjuesaiViewPresentor", package.seeall)

local MartialcontestfinalrankjuesaiViewPresentor = class("MartialcontestfinalrankjuesaiViewPresentor", ViewPresentor)

function MartialcontestfinalrankjuesaiViewPresentor:ctor()
	MartialcontestfinalrankjuesaiViewPresentor.super.ctor(self)
end

function MartialcontestfinalrankjuesaiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalrankjuesaiViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalrankjuesaiview.prefab"
	}
end

function MartialcontestfinalrankjuesaiViewPresentor:buildViews()
	return {
		MartialcontestfinalrankjuesaiView.New()
	}
end

return MartialcontestfinalrankjuesaiViewPresentor
