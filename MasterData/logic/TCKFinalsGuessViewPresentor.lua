-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsGuessViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKFinalsGuessViewPresentor", package.seeall)

local TCKFinalsGuessViewPresentor = class("TCKFinalsGuessViewPresentor", ViewPresentor)

function TCKFinalsGuessViewPresentor:ctor()
	TCKFinalsGuessViewPresentor.super.ctor(self)
end

function TCKFinalsGuessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKFinalsGuessViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckfinalsguessview.prefab"
	}
end

function TCKFinalsGuessViewPresentor:buildViews()
	return {
		TCKFinalsGuessView.New()
	}
end

return TCKFinalsGuessViewPresentor
