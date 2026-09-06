-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceshowtipViewPresentor.lua

module("logic.extensions.nineplace.view.NineplaceshowtipViewPresentor", package.seeall)

local NineplaceshowtipViewPresentor = class("NineplaceshowtipViewPresentor", ViewPresentor)

function NineplaceshowtipViewPresentor:ctor()
	NineplaceshowtipViewPresentor.super.ctor(self)
end

function NineplaceshowtipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NineplaceshowtipViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplaceshowtipview.prefab"
	}
end

function NineplaceshowtipViewPresentor:buildViews()
	return {
		NineplaceshowtipView.New()
	}
end

return NineplaceshowtipViewPresentor
