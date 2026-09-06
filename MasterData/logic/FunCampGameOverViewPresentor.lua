-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameOverViewPresentor.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameOverViewPresentor", package.seeall)

local FunCampGameOverViewPresentor = class("FunCampGameOverViewPresentor", ViewPresentor)

function FunCampGameOverViewPresentor:ctor()
	FunCampGameOverViewPresentor.super.ctor(self)
end

function FunCampGameOverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampGameOverViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/flipgame/funcampgameoverview.prefab"
	}
end

function FunCampGameOverViewPresentor:buildViews()
	return {
		FunCampGameOverView.New()
	}
end

return FunCampGameOverViewPresentor
