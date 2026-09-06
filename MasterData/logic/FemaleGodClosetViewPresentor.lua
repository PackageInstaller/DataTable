-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodClosetViewPresentor.lua

module("logic.extensions.femalegod.view.FemaleGodClosetViewPresentor", package.seeall)

local FemaleGodClosetViewPresentor = class("FemaleGodClosetViewPresentor", ViewPresentor)

function FemaleGodClosetViewPresentor:ctor()
	FemaleGodClosetViewPresentor.super.ctor(self)
end

function FemaleGodClosetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodClosetViewPresentor:dependWhatResources()
	return {
		"ui/views/femalegod/femalegodclosetview.prefab"
	}
end

function FemaleGodClosetViewPresentor:buildViews()
	return {
		FemaleGodClosetView.New()
	}
end

return FemaleGodClosetViewPresentor
