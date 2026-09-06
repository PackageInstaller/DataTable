-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin23ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin23ViewPresentor", package.seeall)

local ExteriorOtherSkin23ViewPresentor = class("ExteriorOtherSkin23ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin23ViewPresentor:ctor()
	ExteriorOtherSkin23ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin23ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin23ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_23.prefab"
	}
end

function ExteriorOtherSkin23ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin23View.New()
	}
end

function ExteriorOtherSkin23ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin23ViewPresentor
