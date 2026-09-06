-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingHelpCenterViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingHelpCenterViewPresentor", package.seeall)

local LiYangKingHelpCenterViewPresentor = class("LiYangKingHelpCenterViewPresentor", ViewPresentor)

function LiYangKingHelpCenterViewPresentor:ctor()
	LiYangKingHelpCenterViewPresentor.super.ctor(self)
end

function LiYangKingHelpCenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingHelpCenterViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkinghelpcenterview.prefab"
	}
end

function LiYangKingHelpCenterViewPresentor:buildViews()
	return {
		LiYangKingHelpCenterView.New()
	}
end

return LiYangKingHelpCenterViewPresentor
