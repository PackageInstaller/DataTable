-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/DivineXingLuoLevelViewPresentor.lua

module("logic.extensions.yishichallenge.view.DivineXingLuoLevelViewPresentor", package.seeall)

local DivineXingLuoLevelViewPresentor = class("DivineXingLuoLevelViewPresentor", ViewPresentor)

function DivineXingLuoLevelViewPresentor:ctor()
	DivineXingLuoLevelViewPresentor.super.ctor(self)
end

function DivineXingLuoLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXingLuoLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/yishichallenge/divinexingluolevelview.prefab"
	}
end

function DivineXingLuoLevelViewPresentor:buildViews()
	return {
		DivineXingLuoLevelView.New()
	}
end

return DivineXingLuoLevelViewPresentor
