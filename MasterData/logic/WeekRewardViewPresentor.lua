-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/view/WeekRewardViewPresentor.lua

module("logic.extensions.weekreward.view.WeekRewardViewPresentor", package.seeall)

local WeekRewardViewPresentor = class("WeekRewardViewPresentor", ViewPresentor)

function WeekRewardViewPresentor:ctor()
	WeekRewardViewPresentor.super.ctor(self)
end

function WeekRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeekRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/weekreward/weekrewardview.prefab"
	}
end

function WeekRewardViewPresentor:buildViews()
	local views = {}
	local v = WeekRewardView.New()

	table.insert(views, v)

	return views
end

return WeekRewardViewPresentor
