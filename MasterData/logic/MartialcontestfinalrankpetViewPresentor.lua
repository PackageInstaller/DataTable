-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankpetViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankpetViewPresentor", package.seeall)

local MartialcontestfinalrankpetViewPresentor = class("MartialcontestfinalrankpetViewPresentor", ViewPresentor)

function MartialcontestfinalrankpetViewPresentor:ctor()
	MartialcontestfinalrankpetViewPresentor.super.ctor(self)
end

function MartialcontestfinalrankpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalrankpetViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalrankpetview.prefab"
	}
end

function MartialcontestfinalrankpetViewPresentor:buildViews()
	return {
		MartialcontestfinalrankpetView.New()
	}
end

return MartialcontestfinalrankpetViewPresentor
