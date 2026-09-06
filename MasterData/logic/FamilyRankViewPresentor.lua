-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyRankViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyRankViewPresentor", package.seeall)

local FamilyRankViewPresentor = class("FamilyRankViewPresentor", ViewPresentor)

function FamilyRankViewPresentor:ctor()
	FamilyRankViewPresentor.super.ctor(self)
end

function FamilyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/callorder/familyrankview.prefab"
	}
end

function FamilyRankViewPresentor:buildViews()
	return {
		FamilyRankView.New()
	}
end

return FamilyRankViewPresentor
