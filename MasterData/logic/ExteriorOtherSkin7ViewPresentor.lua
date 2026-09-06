-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin7ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin7ViewPresentor", package.seeall)

local ExteriorOtherSkin7ViewPresentor = class("ExteriorOtherSkin7ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin7ViewPresentor:ctor()
	ExteriorOtherSkin7ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin7ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin7ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_7.prefab"
	}
end

function ExteriorOtherSkin7ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin7View.New()
	}
end

function ExteriorOtherSkin7ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin7ViewPresentor
