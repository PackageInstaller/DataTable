-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/RewardselectOncePresentor.lua

module("logic.extensions.itembag.view.RewardselectOncePresentor", package.seeall)

local RewardselectOncePresentor = class("RewardselectOncePresentor", ViewPresentor)

function RewardselectOncePresentor:ctor()
	RewardselectOncePresentor.super.ctor(self)
end

function RewardselectOncePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RewardselectOncePresentor:dependWhatResources()
	return {
		"ui/views/itembag/rewardselectonceview.prefab"
	}
end

function RewardselectOncePresentor:buildViews()
	return {
		RewardselectOnceView.New()
	}
end

return RewardselectOncePresentor
