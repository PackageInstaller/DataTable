-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/GoddessgamehudViewPresentor.lua

module("logic.extensions.operationsummary.view.GoddessgamehudViewPresentor", package.seeall)

local GoddessgamehudViewPresentor = class("GoddessgamehudViewPresentor", ViewPresentor)

function GoddessgamehudViewPresentor:ctor()
	GoddessgamehudViewPresentor.super.ctor(self)
end

function GoddessgamehudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessgamehudViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/goddessgamehudview.prefab"
	}
end

function GoddessgamehudViewPresentor:buildViews()
	return {
		GoddessgamehudView.New()
	}
end

return GoddessgamehudViewPresentor
