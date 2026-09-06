-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdMibaoPetViewPresentor.lua

module("logic.extensions.activitypopup.view.HdMibaoPetViewPresentor", package.seeall)

local HdMibaoPetViewPresentor = class("HdMibaoPetViewPresentor", ViewPresentor)

function HdMibaoPetViewPresentor:ctor()
	HdMibaoPetViewPresentor.super.ctor(self)
end

function HdMibaoPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdMibaoPetViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdmibaopetview.prefab"
	}
end

function HdMibaoPetViewPresentor:buildViews()
	return {
		HdMibaoPetView.New()
	}
end

return HdMibaoPetViewPresentor
