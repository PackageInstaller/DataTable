-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebossViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebossViewPresentor", package.seeall)

local KingciyuanchallengebossViewPresentor = class("KingciyuanchallengebossViewPresentor", ViewPresentor)

function KingciyuanchallengebossViewPresentor:ctor()
	KingciyuanchallengebossViewPresentor.super.ctor(self)
end

function KingciyuanchallengebossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingciyuanchallengebossViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengebossview.prefab"
	}
end

function KingciyuanchallengebossViewPresentor:buildViews()
	return {
		KingciyuanchallengebossView.New()
	}
end

return KingciyuanchallengebossViewPresentor
