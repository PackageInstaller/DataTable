-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeClgMainViewPresentor.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeClgMainViewPresentor", package.seeall)

local DivineMiuKeClgMainViewPresentor = class("DivineMiuKeClgMainViewPresentor", ViewPresentor)

function DivineMiuKeClgMainViewPresentor:ctor()
	DivineMiuKeClgMainViewPresentor.super.ctor(self)
end

function DivineMiuKeClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiuKeClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/divinemiuke/divinemiukeclgmainview.prefab"
	}
end

function DivineMiuKeClgMainViewPresentor:buildViews()
	return {
		DivineMiuKeClgMainView.New()
	}
end

return DivineMiuKeClgMainViewPresentor
