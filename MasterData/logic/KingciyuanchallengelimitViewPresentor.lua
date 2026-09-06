-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengelimitViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengelimitViewPresentor", package.seeall)

local KingciyuanchallengelimitViewPresentor = class("KingciyuanchallengelimitViewPresentor", ViewPresentor)

function KingciyuanchallengelimitViewPresentor:ctor()
	KingciyuanchallengelimitViewPresentor.super.ctor(self)
end

function KingciyuanchallengelimitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingciyuanchallengelimitViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengelimitview.prefab"
	}
end

function KingciyuanchallengelimitViewPresentor:buildViews()
	return {
		KingciyuanchallengelimitView.New()
	}
end

return KingciyuanchallengelimitViewPresentor
