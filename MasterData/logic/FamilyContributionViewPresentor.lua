-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyContributionViewPresentor.lua

module("logic.extensions.family.view.FamilyContributionViewPresentor", package.seeall)

local FamilyContributionViewPresentor = class("FamilyContributionViewPresentor", ViewPresentor)

function FamilyContributionViewPresentor:ctor()
	FamilyContributionViewPresentor.super.ctor(self)
end

function FamilyContributionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyContributionViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familycontributionview.prefab"
	}
end

function FamilyContributionViewPresentor:buildViews()
	return {
		FamilyContributionView.New()
	}
end

return FamilyContributionViewPresentor
