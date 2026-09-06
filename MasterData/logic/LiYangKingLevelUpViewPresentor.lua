-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingLevelUpViewPresentor.lua

module("logic.extensions.liyangking.view.LiYangKingLevelUpViewPresentor", package.seeall)

local LiYangKingLevelUpViewPresentor = class("LiYangKingLevelUpViewPresentor", ViewPresentor)

function LiYangKingLevelUpViewPresentor:ctor()
	LiYangKingLevelUpViewPresentor.super.ctor(self)
end

function LiYangKingLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiYangKingLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/liyangking/liyangkinglevelupview.prefab"
	}
end

function LiYangKingLevelUpViewPresentor:buildViews()
	return {
		LiYangKingLevelUpView.New()
	}
end

return LiYangKingLevelUpViewPresentor
