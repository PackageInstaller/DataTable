-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloGameViewPresentor.lua

module("logic.extensions.divinehalogame.view.DivineHaloGameViewPresentor", package.seeall)

local DivineHaloGameViewPresentor = class("DivineHaloGameViewPresentor", ViewPresentor)

function DivineHaloGameViewPresentor:ctor()
	DivineHaloGameViewPresentor.super.ctor(self)
end

function DivineHaloGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineHaloGameViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehalogame/divinehalogameview.prefab"
	}
end

function DivineHaloGameViewPresentor:buildViews()
	return {
		DivineHaloGameView.New()
	}
end

return DivineHaloGameViewPresentor
