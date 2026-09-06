-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameScenceViewPresentor.lua

module("logic.extensions.landlords.view.FalGameScenceViewPresentor", package.seeall)

local FalGameScenceViewPresentor = class("FalGameScenceViewPresentor", ViewPresentor)

FalGameScenceViewPresentor.DouDiZhuCharacterPath = "character/doudizhu/doudizhu-ui_p.prefab"

function FalGameScenceViewPresentor:ctor()
	FalGameScenceViewPresentor.super.ctor(self)
end

function FalGameScenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalGameScenceViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falgamescenceview.prefab",
		FalGameScenceViewPresentor.DouDiZhuCharacterPath
	}
end

function FalGameScenceViewPresentor:buildViews()
	return {
		FalGameScenceView.New()
	}
end

return FalGameScenceViewPresentor
