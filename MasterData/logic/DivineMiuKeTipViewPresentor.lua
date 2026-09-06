-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeTipViewPresentor.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeTipViewPresentor", package.seeall)

local DivineMiuKeTipViewPresentor = class("DivineMiuKeTipViewPresentor", ViewPresentor)

function DivineMiuKeTipViewPresentor:ctor()
	DivineMiuKeTipViewPresentor.super.ctor(self)
end

function DivineMiuKeTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiuKeTipViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/divinemiuke/divinemiuketipview.prefab"
	}
end

function DivineMiuKeTipViewPresentor:buildViews()
	return {
		DivineMiuKeTipView.New()
	}
end

return DivineMiuKeTipViewPresentor
