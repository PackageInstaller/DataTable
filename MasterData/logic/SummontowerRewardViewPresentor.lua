-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerRewardViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerRewardViewPresentor", package.seeall)

local SummontowerRewardViewPresentor = class("SummontowerRewardViewPresentor", ViewPresentor)

function SummontowerRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowerrewardview.prefab"
	}
end

function SummontowerRewardViewPresentor:buildViews()
	return {
		SummontowerRewardView.New()
	}
end

return SummontowerRewardViewPresentor
