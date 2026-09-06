-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooanimalViewPresentor.lua

module("logic.extensions.zoo.view.ZooanimalViewPresentor", package.seeall)

local ZooanimalViewPresentor = class("ZooanimalViewPresentor", ViewPresentor)

function ZooanimalViewPresentor:ctor()
	ZooanimalViewPresentor.super.ctor(self)
end

function ZooanimalViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooanimalViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooanimalview.prefab"
	}
end

function ZooanimalViewPresentor:buildViews()
	return {
		ZooanimalView.New()
	}
end

return ZooanimalViewPresentor
