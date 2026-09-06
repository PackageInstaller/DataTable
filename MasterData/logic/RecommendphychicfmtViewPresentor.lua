-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendphychicfmtViewPresentor.lua

module("logic.extensions.recommendfmt.view.RecommendphychicfmtViewPresentor", package.seeall)

local RecommendphychicfmtViewPresentor = class("RecommendphychicfmtViewPresentor", ViewPresentor)

function RecommendphychicfmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecommendphychicfmtViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/recommendphychicfmtview.prefab",
		MissionViewPresentor.RecPosItem,
		MissionViewPresentor.AtkSelfItem
	}
end

function RecommendphychicfmtViewPresentor:buildViews()
	return {
		RecommendphychicfmtView.New()
	}
end

return RecommendphychicfmtViewPresentor
