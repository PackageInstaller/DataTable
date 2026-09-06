-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRankViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberRankViewPresentor", package.seeall)

local NumberRankViewPresentor = class("NumberRankViewPresentor", ViewWithGuidePresentor)

function NumberRankViewPresentor:ctor()
	NumberRankViewPresentor.super.ctor(self)
end

function NumberRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberRankViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberrankview.prefab"
	}
end

function NumberRankViewPresentor:buildViews()
	return {
		NumberRankView.New()
	}
end

return NumberRankViewPresentor
