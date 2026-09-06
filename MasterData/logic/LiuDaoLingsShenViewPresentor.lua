-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoLingsShenViewPresentor.lua

module("logic.extensions.liudao.view.LiuDaoLingsShenViewPresentor", package.seeall)

local LiuDaoLingsShenViewPresentor = class("LiuDaoLingsShenViewPresentor", ViewPresentor)

function LiuDaoLingsShenViewPresentor:ctor()
	LiuDaoLingsShenViewPresentor.super.ctor(self)
end

function LiuDaoLingsShenViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LiuDaoLingsShenViewPresentor:dependWhatResources()
	return {
		"ui/views/liudao/liudaolingshenview.prefab"
	}
end

function LiuDaoLingsShenViewPresentor:buildViews()
	return {
		LiuDaoLingsShenView.New()
	}
end

return LiuDaoLingsShenViewPresentor
