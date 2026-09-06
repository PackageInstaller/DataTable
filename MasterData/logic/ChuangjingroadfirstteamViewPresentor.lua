-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadfirstteamViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadfirstteamViewPresentor", package.seeall)

local ChuangjingroadfirstteamViewPresentor = class("ChuangjingroadfirstteamViewPresentor", ViewPresentor)

function ChuangjingroadfirstteamViewPresentor:ctor()
	ChuangjingroadfirstteamViewPresentor.super.ctor(self)
end

function ChuangjingroadfirstteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadfirstteamViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadfirstteamview.prefab"
	}
end

function ChuangjingroadfirstteamViewPresentor:buildViews()
	return {
		ChuangjingroadfirstteamView.New()
	}
end

return ChuangjingroadfirstteamViewPresentor
