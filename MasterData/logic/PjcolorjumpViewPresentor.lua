-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/baioogamescommunity/view/PjcolorjumpViewPresentor.lua

module("logic.extensions.baioogamescommunity.view.PjcolorjumpViewPresentor", package.seeall)

local PjcolorjumpViewPresentor = class("PjcolorjumpViewPresentor", ViewPresentor)

function PjcolorjumpViewPresentor:ctor()
	PjcolorjumpViewPresentor.super.ctor(self)
end

function PjcolorjumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PjcolorjumpViewPresentor:dependWhatResources()
	return {
		"ui/views/baioogamescommunity/pjcolorjumpview.prefab"
	}
end

function PjcolorjumpViewPresentor:buildViews()
	return {
		PjcolorjumpView.New()
	}
end

return PjcolorjumpViewPresentor
