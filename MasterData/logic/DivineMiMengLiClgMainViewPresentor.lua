-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgMainViewPresentor.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgMainViewPresentor", package.seeall)

local DivineMiMengLiClgMainViewPresentor = class("DivineMiMengLiClgMainViewPresentor", ViewPresentor)

function DivineMiMengLiClgMainViewPresentor:ctor()
	DivineMiMengLiClgMainViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiMengLiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemimengliclg/divinemimengliclgmainview.prefab"
	}
end

function DivineMiMengLiClgMainViewPresentor:buildViews()
	return {
		DivineMiMengLiClgMainView.New()
	}
end

return DivineMiMengLiClgMainViewPresentor
