-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberResultViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberResultViewPresentor", package.seeall)

local NumberResultViewPresentor = class("NumberResultViewPresentor", ViewWithGuidePresentor)

function NumberResultViewPresentor:ctor()
	NumberResultViewPresentor.super.ctor(self)
end

function NumberResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberResultViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberresultview.prefab"
	}
end

function NumberResultViewPresentor:buildViews()
	return {
		NumberResultView.New()
	}
end

return NumberResultViewPresentor
