-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberGameViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberGameViewPresentor", package.seeall)

local NumberGameViewPresentor = class("NumberGameViewPresentor", ViewWithGuidePresentor)

function NumberGameViewPresentor:ctor()
	NumberGameViewPresentor.super.ctor(self)
end

function NumberGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberGameViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numbergameview.prefab"
	}
end

function NumberGameViewPresentor:buildViews()
	return {
		NumberGameView.New()
	}
end

return NumberGameViewPresentor
