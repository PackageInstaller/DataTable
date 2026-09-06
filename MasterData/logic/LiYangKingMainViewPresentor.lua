-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingMainViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingMainViewPresentor", package.seeall)

local LiYangKingMainViewPresentor = class("LiYangKingMainViewPresentor", ViewPresentor)

function LiYangKingMainViewPresentor:ctor()
	LiYangKingMainViewPresentor.super.ctor(self)
end

function LiYangKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkingmainview.prefab"
	}
end

function LiYangKingMainViewPresentor:buildViews()
	return {
		LiYangKingMainView.New()
	}
end

return LiYangKingMainViewPresentor
