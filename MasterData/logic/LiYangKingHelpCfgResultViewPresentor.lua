-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingHelpCfgResultViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingHelpCfgResultViewPresentor", package.seeall)

local LiYangKingHelpCfgResultViewPresentor = class("LiYangKingHelpCfgResultViewPresentor", ViewPresentor)

function LiYangKingHelpCfgResultViewPresentor:ctor()
	LiYangKingHelpCfgResultViewPresentor.super.ctor(self)
end

function LiYangKingHelpCfgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingHelpCfgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkinghelpcfgresultview.prefab"
	}
end

function LiYangKingHelpCfgResultViewPresentor:buildViews()
	return {
		LiYangKingHelpCfgResultView.New()
	}
end

return LiYangKingHelpCfgResultViewPresentor
