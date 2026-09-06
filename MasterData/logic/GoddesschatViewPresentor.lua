-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddesschatViewPresentor.lua

module("logic.extensions.goddess.view.GoddesschatViewPresentor", package.seeall)

local GoddesschatViewPresentor = class("GoddesschatViewPresentor", ViewPresentor)

function GoddesschatViewPresentor:ctor()
	GoddesschatViewPresentor.super.ctor(self)
end

function GoddesschatViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddesschatViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddesschatview.prefab"
	}
end

function GoddesschatViewPresentor:buildViews()
	return {
		GoddesschatView.New()
	}
end

return GoddesschatViewPresentor
