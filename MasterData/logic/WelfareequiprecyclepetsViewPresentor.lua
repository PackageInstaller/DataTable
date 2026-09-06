-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/WelfareequiprecyclepetsViewPresentor.lua

module("logic.extensions.welfareequiprecycle.view.WelfareequiprecyclepetsViewPresentor", package.seeall)

local WelfareequiprecyclepetsViewPresentor = class("WelfareequiprecyclepetsViewPresentor", ViewPresentor)

function WelfareequiprecyclepetsViewPresentor:ctor()
	WelfareequiprecyclepetsViewPresentor.super.ctor(self)
end

function WelfareequiprecyclepetsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WelfareequiprecyclepetsViewPresentor:dependWhatResources()
	return {
		"ui/views/welfareequiprecycle/welfareequiprecyclepetsview.prefab"
	}
end

function WelfareequiprecyclepetsViewPresentor:buildViews()
	return {
		WelfareequiprecyclepetsView.New()
	}
end

return WelfareequiprecyclepetsViewPresentor
