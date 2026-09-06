-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorRewardViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorRewardViewPresentor", package.seeall)

local SeniorRewardViewPresentor = class("SeniorRewardViewPresentor", ViewPresentor)

function SeniorRewardViewPresentor:ctor()
	SeniorRewardViewPresentor.super.ctor(self)
end

function SeniorRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeniorRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorrewardview.prefab"
	}
end

function SeniorRewardViewPresentor:buildViews()
	return {
		SeniorRewardView.New()
	}
end

return SeniorRewardViewPresentor
