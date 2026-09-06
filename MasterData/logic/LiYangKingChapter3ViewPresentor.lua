-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingChapter3ViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingChapter3ViewPresentor", package.seeall)

local LiYangKingChapter3ViewPresentor = class("LiYangKingChapter3ViewPresentor", ViewPresentor)

function LiYangKingChapter3ViewPresentor:ctor()
	LiYangKingChapter3ViewPresentor.super.ctor(self)
end

function LiYangKingChapter3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingChapter3ViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingchapter3view.prefab"
	}
end

function LiYangKingChapter3ViewPresentor:buildViews()
	return {
		LiYangKingChapter3View.New()
	}
end

return LiYangKingChapter3ViewPresentor
