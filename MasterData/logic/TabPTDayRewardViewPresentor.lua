-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTDayRewardViewPresentor.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTDayRewardViewPresentor", package.seeall)

local TabPTDayRewardViewPresentor = class("TabPTDayRewardViewPresentor", ViewPresentor)

function TabPTDayRewardViewPresentor:ctor()
	TabPTDayRewardViewPresentor.super.ctor(self)
end

function TabPTDayRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTDayRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/rewarddesc/tabptdayrewardview.prefab"
	}
end

function TabPTDayRewardViewPresentor:buildViews()
	return {
		TabPTDayRewardView.New()
	}
end

function TabPTDayRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTDayRewardViewPresentor
