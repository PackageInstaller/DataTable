-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabPTRewardDescriptionViewPresentor.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabPTRewardDescriptionViewPresentor", package.seeall)

local TabPTRewardDescriptionViewPresentor = class("TabPTRewardDescriptionViewPresentor", ViewPresentor)

function TabPTRewardDescriptionViewPresentor:ctor()
	TabPTRewardDescriptionViewPresentor.super.ctor(self)
end

function TabPTRewardDescriptionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTRewardDescriptionViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/rewarddesc/tabptrewarddescriptionview.prefab"
	}
end

function TabPTRewardDescriptionViewPresentor:buildViews()
	return {
		TabPTRewardDescriptionView.New()
	}
end

return TabPTRewardDescriptionViewPresentor
