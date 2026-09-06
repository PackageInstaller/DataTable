-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworkViewPresentor.lua

module("logic.extensions.firework.view.FireworkViewPresentor", package.seeall)

local FireworkViewPresentor = class("FireworkViewPresentor", ViewPresentor)

function FireworkViewPresentor:ctor()
	FireworkViewPresentor.super.ctor(self)
end

function FireworkViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FireworkViewPresentor:dependWhatResources()
	return {
		"ui/views/firework/fireworkview.prefab"
	}
end

function FireworkViewPresentor:buildViews()
	return {
		FireworkView.New()
	}
end

return FireworkViewPresentor
