-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectcommonViewPresentor.lua

module("logic.extensions.itembag.view.RewardselectcommonViewPresentor", package.seeall)

local RewardselectcommonViewPresentor = class("RewardselectcommonViewPresentor", ViewPresentor)

function RewardselectcommonViewPresentor:ctor()
	RewardselectcommonViewPresentor.super.ctor(self)
end

function RewardselectcommonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RewardselectcommonViewPresentor:dependWhatResources()
	return {
		"ui/views/itembag/rewardselectonceview.prefab"
	}
end

function RewardselectcommonViewPresentor:buildViews()
	return {
		RewardselectcommonView.New()
	}
end

return RewardselectcommonViewPresentor
