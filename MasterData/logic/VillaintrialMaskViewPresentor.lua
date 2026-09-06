-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialMaskViewPresentor.lua

module("logic.extensions.villaintrial.view.VillaintrialMaskViewPresentor", package.seeall)

local VillaintrialMaskViewPresentor = class("VillaintrialMaskViewPresentor", ViewPresentor)

function VillaintrialMaskViewPresentor:ctor()
	VillaintrialMaskViewPresentor.super.ctor(self)
end

function VillaintrialMaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VillaintrialMaskViewPresentor:dependWhatResources()
	return {
		"ui/views/villaintrial/villaintrialmask.prefab"
	}
end

function VillaintrialMaskViewPresentor:buildViews()
	return {
		VillaintrialMaskView.New()
	}
end

return VillaintrialMaskViewPresentor
