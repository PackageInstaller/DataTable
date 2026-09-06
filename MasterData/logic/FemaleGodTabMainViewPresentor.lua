-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodTabMainViewPresentor.lua

module("logic.extensions.femalegod.view.female", package.seeall)

local FemaleGodTabMainViewPresentor = class("FemaleGodTabMainViewPresentor", ViewPresentor)

function FemaleGodTabMainViewPresentor:ctor()
	FemaleGodTabMainViewPresentor.super.ctor(self)
end

function FemaleGodTabMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodTabMainViewPresentor:dependWhatResources()
	return {
		"ui/views/femalegod/femalegodtabmainview.prefab"
	}
end

function FemaleGodTabMainViewPresentor:buildViews()
	return {
		FemaleGodTabMainView.New()
	}
end

return FemaleGodTabMainViewPresentor
