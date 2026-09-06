-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankViewPresentor", package.seeall)

local MartialcontestfinalrankViewPresentor = class("MartialcontestfinalrankViewPresentor", ViewPresentor)

function MartialcontestfinalrankViewPresentor:ctor()
	MartialcontestfinalrankViewPresentor.super.ctor(self)
end

function MartialcontestfinalrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalrankViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalrankview.prefab"
	}
end

function MartialcontestfinalrankViewPresentor:buildViews()
	return {
		MartialcontestfinalrankView.New()
	}
end

return MartialcontestfinalrankViewPresentor
