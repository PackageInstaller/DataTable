-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworklistViewPresentor.lua

module("logic.extensions.firework.view.FireworklistViewPresentor", package.seeall)

local FireworklistViewPresentor = class("FireworklistViewPresentor", ViewPresentor)

function FireworklistViewPresentor:ctor()
	FireworklistViewPresentor.super.ctor(self)
end

function FireworklistViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FireworklistViewPresentor:dependWhatResources()
	return {
		"ui/views/firework/fireworklistview.prefab"
	}
end

function FireworklistViewPresentor:buildViews()
	return {
		FireworklistView.New()
	}
end

return FireworklistViewPresentor
