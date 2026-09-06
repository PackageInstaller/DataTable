-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyRankRewardViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyRankRewardViewPresentor", package.seeall)

local FamilyRankRewardViewPresentor = class("FamilyRankRewardViewPresentor", ViewPresentor)

function FamilyRankRewardViewPresentor:ctor()
	FamilyRankRewardViewPresentor.super.ctor(self)
end

function FamilyRankRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyRankRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/callorder/familyrankrewardview.prefab"
	}
end

function FamilyRankRewardViewPresentor:buildViews()
	return {
		FamilyRankRewardView.New()
	}
end

return FamilyRankRewardViewPresentor
