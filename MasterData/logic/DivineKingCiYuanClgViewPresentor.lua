-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanClgViewPresentor.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanClgViewPresentor", package.seeall)

local DivineKingCiYuanClgViewPresentor = class("DivineKingCiYuanClgViewPresentor", ViewPresentor)

function DivineKingCiYuanClgViewPresentor:ctor()
	DivineKingCiYuanClgViewPresentor.super.ctor(self)
end

function DivineKingCiYuanClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingCiYuanClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingciyuan/divinekingciyuanclgview.prefab"
	}
end

function DivineKingCiYuanClgViewPresentor:buildViews()
	return {
		DivineKingCiYuanClgView.New()
	}
end

return DivineKingCiYuanClgViewPresentor
