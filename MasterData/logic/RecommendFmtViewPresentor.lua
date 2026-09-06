-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendFmtViewPresentor.lua

module("logic.extensions.recommendfmt.view.RecommendFmtViewPresentor", package.seeall)

local RecommendFmtViewPresentor = class("RecommendFmtViewPresentor", ViewPresentor)

function RecommendFmtViewPresentor:ctor()
	RecommendFmtViewPresentor.super.ctor(self)
end

function RecommendFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecommendFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/recommendfmtpageview.prefab",
		MissionViewPresentor.RecPosItem,
		MissionViewPresentor.AtkSelfItem
	}
end

function RecommendFmtViewPresentor:buildViews()
	return {
		RecommendFmtWeekView.New()
	}
end

return RecommendFmtViewPresentor
