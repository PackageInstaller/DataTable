-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebuffselectViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebuffselectViewPresentor", package.seeall)

local KingciyuanchallengebuffselectViewPresentor = class("KingciyuanchallengebuffselectViewPresentor", ViewPresentor)

function KingciyuanchallengebuffselectViewPresentor:ctor()
	KingciyuanchallengebuffselectViewPresentor.super.ctor(self)
end

function KingciyuanchallengebuffselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingciyuanchallengebuffselectViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengebuffselectview.prefab"
	}
end

function KingciyuanchallengebuffselectViewPresentor:buildViews()
	return {
		KingciyuanchallengebuffselectView.New()
	}
end

return KingciyuanchallengebuffselectViewPresentor
