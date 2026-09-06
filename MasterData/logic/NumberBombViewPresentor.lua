-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberBombViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberBombViewPresentor", package.seeall)

local NumberBombViewPresentor = class("NumberBombViewPresentor", ViewWithGuidePresentor)

function NumberBombViewPresentor:ctor()
	NumberBombViewPresentor.super.ctor(self)
end

function NumberBombViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberBombViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberbombview.prefab"
	}
end

function NumberBombViewPresentor:buildViews()
	return {
		NumberBombView.New()
	}
end

return NumberBombViewPresentor
