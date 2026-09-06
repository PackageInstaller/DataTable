-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRewardViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberRewardViewPresentor", package.seeall)

local NumberRewardViewPresentor = class("NumberRewardViewPresentor", ViewWithGuidePresentor)

function NumberRewardViewPresentor:ctor()
	NumberRewardViewPresentor.super.ctor(self)
end

function NumberRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberrewardview.prefab"
	}
end

function NumberRewardViewPresentor:buildViews()
	return {
		NumberRewardView.New()
	}
end

return NumberRewardViewPresentor
