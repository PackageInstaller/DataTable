-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengelimitfmtViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengelimitfmtViewPresentor", package.seeall)

local KingciyuanchallengelimitfmtViewPresentor = class("KingciyuanchallengelimitfmtViewPresentor", ViewPresentor)

function KingciyuanchallengelimitfmtViewPresentor:ctor()
	KingciyuanchallengelimitfmtViewPresentor.super.ctor(self)
end

function KingciyuanchallengelimitfmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingciyuanchallengelimitfmtViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengelimitfmtview.prefab"
	}
end

function KingciyuanchallengelimitfmtViewPresentor:buildViews()
	return {
		KingciyuanchallengelimitfmtView.New()
	}
end

return KingciyuanchallengelimitfmtViewPresentor
