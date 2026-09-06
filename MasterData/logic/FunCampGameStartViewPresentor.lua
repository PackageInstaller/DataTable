-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameStartViewPresentor.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameStartViewPresentor", package.seeall)

local FunCampGameStartViewPresentor = class("FunCampGameStartViewPresentor", ViewPresentor)

function FunCampGameStartViewPresentor:ctor()
	FunCampGameStartViewPresentor.super.ctor(self)
end

function FunCampGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FunCampGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/flipgame/funcampgamestartview.prefab"
	}
end

function FunCampGameStartViewPresentor:buildViews()
	return {
		FunCampGameStartView.New()
	}
end

return FunCampGameStartViewPresentor
