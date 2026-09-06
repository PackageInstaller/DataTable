-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin15ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin15ViewPresentor", package.seeall)

local ExteriorOtherSkin15ViewPresentor = class("ExteriorOtherSkin15ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin15ViewPresentor:ctor()
	ExteriorOtherSkin15ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin15ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin15ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_15.prefab"
	}
end

function ExteriorOtherSkin15ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin15View.New()
	}
end

function ExteriorOtherSkin15ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin15ViewPresentor
