-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishtreeletterViewPresentor.lua

module("logic.extensions.wishtree.view.WishtreeletterViewPresentor", package.seeall)

local WishtreeletterViewPresentor = class("WishtreeletterViewPresentor", ViewPresentor)

function WishtreeletterViewPresentor:ctor()
	WishtreeletterViewPresentor.super.ctor(self)
end

function WishtreeletterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishtreeletterViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtree/wishtreeletterview.prefab"
	}
end

function WishtreeletterViewPresentor:buildViews()
	return {
		WishTreeLetterView.New()
	}
end

return WishtreeletterViewPresentor
