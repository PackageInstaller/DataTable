-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKGuessViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKGuessViewPresentor", package.seeall)

local TCKGuessViewPresentor = class("TCKGuessViewPresentor", ViewPresentor)

function TCKGuessViewPresentor:ctor()
	TCKGuessViewPresentor.super.ctor(self)
end

function TCKGuessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKGuessViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckguessview.prefab"
	}
end

function TCKGuessViewPresentor:buildViews()
	return {
		TCKGuessView.New()
	}
end

return TCKGuessViewPresentor
