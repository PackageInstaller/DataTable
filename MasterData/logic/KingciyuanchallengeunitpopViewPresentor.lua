-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengeunitpopViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengeunitpopViewPresentor", package.seeall)

local KingciyuanchallengeunitpopViewPresentor = class("KingciyuanchallengeunitpopViewPresentor", ViewPresentor)

function KingciyuanchallengeunitpopViewPresentor:ctor()
	KingciyuanchallengeunitpopViewPresentor.super.ctor(self)
end

function KingciyuanchallengeunitpopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingciyuanchallengeunitpopViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengeunitpopview.prefab"
	}
end

function KingciyuanchallengeunitpopViewPresentor:buildViews()
	return {
		KingciyuanchallengeunitpopView.New()
	}
end

return KingciyuanchallengeunitpopViewPresentor
