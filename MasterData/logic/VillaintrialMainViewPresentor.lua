-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialMainViewPresentor.lua

module("logic.extensions.villaintrial.view.VillaintrialMainViewPresentor", package.seeall)

local VillaintrialMainViewPresentor = class("VillaintrialMainViewPresentor", ViewPresentor)

function VillaintrialMainViewPresentor:ctor()
	VillaintrialMainViewPresentor.super.ctor(self)
end

function VillaintrialMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VillaintrialMainViewPresentor:dependWhatResources()
	return {
		"ui/views/villaintrial/villaintrialmainview.prefab"
	}
end

function VillaintrialMainViewPresentor:buildViews()
	return {
		VillaintrialMainView.New()
	}
end

return VillaintrialMainViewPresentor
