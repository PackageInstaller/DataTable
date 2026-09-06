-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoolostanimalViewPresentor.lua

module("logic.extensions.zoo.view.ZoolostanimalViewPresentor", package.seeall)

local ZoolostanimalViewPresentor = class("ZoolostanimalViewPresentor", ViewPresentor)

function ZoolostanimalViewPresentor:ctor()
	ZoolostanimalViewPresentor.super.ctor(self)
end

function ZoolostanimalViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoolostanimalViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoolostanimalview.prefab"
	}
end

function ZoolostanimalViewPresentor:buildViews()
	return {
		ZoolostanimalView.New()
	}
end

return ZoolostanimalViewPresentor
