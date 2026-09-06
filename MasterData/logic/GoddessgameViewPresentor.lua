-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessgameViewPresentor.lua

module("logic.extensions.goddess.view.GoddessgameViewPresentor", package.seeall)

local GoddessgameViewPresentor = class("GoddessgameViewPresentor", ViewPresentor)

function GoddessgameViewPresentor:ctor()
	GoddessgameViewPresentor.super.ctor(self)
end

function GoddessgameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessgameViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddessgameview.prefab"
	}
end

function GoddessgameViewPresentor:buildViews()
	return {
		GoddessgameView.New()
	}
end

return GoddessgameViewPresentor
