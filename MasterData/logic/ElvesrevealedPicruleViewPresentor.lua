-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/view/ElvesrevealedPicruleViewPresentor.lua

module("logic.extensions.elvesrevealed.view.ElvesrevealedPicruleViewPresentor", package.seeall)

local ElvesrevealedPicruleViewPresentor = class("ElvesrevealedPicruleViewPresentor", ViewPresentor)

function ElvesrevealedPicruleViewPresentor:ctor()
	ElvesrevealedPicruleViewPresentor.super.ctor(self)
end

function ElvesrevealedPicruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElvesrevealedPicruleViewPresentor:dependWhatResources()
	return {
		"ui/views/elvesrevealed/elvesrevealedpicruleview.prefab"
	}
end

function ElvesrevealedPicruleViewPresentor:buildViews()
	return {
		ElvesrevealedPicruleView.New()
	}
end

return ElvesrevealedPicruleViewPresentor
