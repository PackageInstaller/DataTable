-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberMatchViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberMatchViewPresentor", package.seeall)

local NumberMatchViewPresentor = class("NumberMatchViewPresentor", ViewWithGuidePresentor)

function NumberMatchViewPresentor:ctor()
	NumberMatchViewPresentor.super.ctor(self)
end

function NumberMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numbermatchview.prefab"
	}
end

function NumberMatchViewPresentor:buildViews()
	return {
		NumberMatchView.New()
	}
end

return NumberMatchViewPresentor
