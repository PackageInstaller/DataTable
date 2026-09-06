-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankscoreViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankscoreViewPresentor", package.seeall)

local MartialcontestfinalrankscoreViewPresentor = class("MartialcontestfinalrankscoreViewPresentor", ViewPresentor)

function MartialcontestfinalrankscoreViewPresentor:ctor()
	MartialcontestfinalrankscoreViewPresentor.super.ctor(self)
end

function MartialcontestfinalrankscoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalrankscoreViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalrankscoreview.prefab"
	}
end

function MartialcontestfinalrankscoreViewPresentor:buildViews()
	return {
		MartialcontestfinalrankscoreView.New()
	}
end

return MartialcontestfinalrankscoreViewPresentor
