-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/WelfareequiprecycleViewPresentor.lua

module("logic.extensions.welfareequiprecycle.view.WelfareequiprecycleViewPresentor", package.seeall)

local WelfareequiprecycleViewPresentor = class("WelfareequiprecycleViewPresentor", ViewPresentor)

function WelfareequiprecycleViewPresentor:ctor()
	WelfareequiprecycleViewPresentor.super.ctor(self)
end

function WelfareequiprecycleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WelfareequiprecycleViewPresentor:dependWhatResources()
	return {
		"ui/views/welfareequiprecycle/welfareequiprecycleview.prefab"
	}
end

function WelfareequiprecycleViewPresentor:buildViews()
	return {
		WelfareequiprecycleView.New()
	}
end

return WelfareequiprecycleViewPresentor
