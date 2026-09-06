-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PksetenemypowerViewPresentor.lua

module("logic.extensions.pk.view.PksetenemypowerViewPresentor", package.seeall)

local PksetenemypowerViewPresentor = class("PksetenemypowerViewPresentor", ViewPresentor)

function PksetenemypowerViewPresentor:ctor()
	PksetenemypowerViewPresentor.super.ctor(self)
end

function PksetenemypowerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PksetenemypowerViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pksetenemypowerview.prefab"
	}
end

function PksetenemypowerViewPresentor:buildViews()
	return {
		PksetenemypowerView.New()
	}
end

return PksetenemypowerViewPresentor
