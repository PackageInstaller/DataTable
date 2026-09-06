-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectPresentor.lua

module("logic.extensions.itembag.view.RewardselectPresentor", package.seeall)

local RewardselectPresentor = class("RewardselectPresentor", ViewPresentor)

function RewardselectPresentor:ctor()
	RewardselectPresentor.super.ctor(self)
end

function RewardselectPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RewardselectPresentor:dependWhatResources()
	return {
		"ui/views/itembag/rewardselectview.prefab"
	}
end

function RewardselectPresentor:buildViews()
	return {
		RewardselectView.New()
	}
end

return RewardselectPresentor
