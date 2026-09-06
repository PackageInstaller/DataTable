-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/view/DivineCoronateGameViewPresentor.lua

module("logic.extensions.divinecoronate.view.DivineCoronateGameViewPresentor", package.seeall)

local DivineCoronateGameViewPresentor = class("DivineCoronateGameViewPresentor", ViewPresentor)

function DivineCoronateGameViewPresentor:ctor()
	DivineCoronateGameViewPresentor.super.ctor(self)
end

function DivineCoronateGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineCoronateGameViewPresentor:dependWhatResources()
	return {
		"ui/views/divinecoronate/divinecoronategameview.prefab"
	}
end

function DivineCoronateGameViewPresentor:buildViews()
	return {
		DivineCoronateGameView.New()
	}
end

return DivineCoronateGameViewPresentor
