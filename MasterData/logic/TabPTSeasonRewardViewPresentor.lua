-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTSeasonRewardViewPresentor.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTSeasonRewardViewPresentor", package.seeall)

local TabPTSeasonRewardViewPresentor = class("TabPTSeasonRewardViewPresentor", ViewPresentor)

function TabPTSeasonRewardViewPresentor:ctor()
	TabPTSeasonRewardViewPresentor.super.ctor(self)
end

function TabPTSeasonRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTSeasonRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/rewarddesc/tabptseasonrewardview.prefab"
	}
end

function TabPTSeasonRewardViewPresentor:buildViews()
	return {
		TabPTSeasonRewardView.New()
	}
end

function TabPTSeasonRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTSeasonRewardViewPresentor
