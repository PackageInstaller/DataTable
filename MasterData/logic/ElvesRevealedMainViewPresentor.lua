-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/view/ElvesRevealedMainViewPresentor.lua

module("logic.extensions.elvesrevealed.view.ElvesRevealedMainViewPresentor", package.seeall)

local ElvesRevealedMainViewPresentor = class("ElvesRevealedMainViewPresentor", ViewPresentor)

function ElvesRevealedMainViewPresentor:ctor()
	ElvesRevealedMainViewPresentor.super.ctor(self)
end

function ElvesRevealedMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElvesRevealedMainViewPresentor:dependWhatResources()
	return {
		"ui/views/elvesrevealed/elvesrevealedmainview.prefab"
	}
end

function ElvesRevealedMainViewPresentor:buildViews()
	return {
		ElvesRevealedMainView.New()
	}
end

return ElvesRevealedMainViewPresentor
