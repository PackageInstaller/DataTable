-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengemainViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengemainViewPresentor", package.seeall)

local KingciyuanchallengemainViewPresentor = class("KingciyuanchallengemainViewPresentor", ViewPresentor)

function KingciyuanchallengemainViewPresentor:ctor()
	KingciyuanchallengemainViewPresentor.super.ctor(self)
end

function KingciyuanchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingciyuanchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengemainview.prefab"
	}
end

function KingciyuanchallengemainViewPresentor:buildViews()
	return {
		KingciyuanchallengemainView.New()
	}
end

return KingciyuanchallengemainViewPresentor
