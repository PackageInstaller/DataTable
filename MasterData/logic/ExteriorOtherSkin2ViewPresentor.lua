-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin2ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin2ViewPresentor", package.seeall)

local ExteriorOtherSkin2ViewPresentor = class("ExteriorOtherSkin2ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin2ViewPresentor:ctor()
	ExteriorOtherSkin2ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin2ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_2.prefab"
	}
end

function ExteriorOtherSkin2ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin2View.New()
	}
end

function ExteriorOtherSkin2ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin2ViewPresentor
