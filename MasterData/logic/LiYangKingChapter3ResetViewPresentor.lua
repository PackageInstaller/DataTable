-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingChapter3ResetViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingChapter3ResetViewPresentor", package.seeall)

local LiYangKingChapter3ResetViewPresentor = class("LiYangKingChapter3ResetViewPresentor", ViewPresentor)

function LiYangKingChapter3ResetViewPresentor:ctor()
	LiYangKingChapter3ResetViewPresentor.super.ctor(self)
end

function LiYangKingChapter3ResetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingChapter3ResetViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingchapter3resetview.prefab"
	}
end

function LiYangKingChapter3ResetViewPresentor:buildViews()
	return {
		LiYangKingChapter3ResetView.New()
	}
end

return LiYangKingChapter3ResetViewPresentor
