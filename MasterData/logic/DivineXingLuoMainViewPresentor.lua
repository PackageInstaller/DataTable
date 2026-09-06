-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/DivineXingLuoMainViewPresentor.lua

module("logic.extensions.yishichallenge.view.DivineXingLuoMainViewPresentor", package.seeall)

local DivineXingLuoMainViewPresentor = class("DivineXingLuoMainViewPresentor", ViewPresentor)

function DivineXingLuoMainViewPresentor:ctor()
	DivineXingLuoMainViewPresentor.super.ctor(self)
end

function DivineXingLuoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXingLuoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yishichallenge/divinexingluomainview.prefab"
	}
end

function DivineXingLuoMainViewPresentor:buildViews()
	return {
		DivineXingLuoMainView.New()
	}
end

return DivineXingLuoMainViewPresentor
