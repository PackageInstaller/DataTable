-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeMainViewPresentor.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeMainViewPresentor", package.seeall)

local DivineMiuKeMainViewPresentor = class("DivineMiuKeMainViewPresentor", ViewPresentor)

function DivineMiuKeMainViewPresentor:ctor()
	DivineMiuKeMainViewPresentor.super.ctor(self)
end

function DivineMiuKeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiuKeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/divinemiuke/divinemiukemainview.prefab"
	}
end

function DivineMiuKeMainViewPresentor:buildViews()
	return {
		DivineMiuKeMainView.New()
	}
end

return DivineMiuKeMainViewPresentor
