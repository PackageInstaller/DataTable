-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin12ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin12ViewPresentor", package.seeall)

local ExteriorOtherSkin12ViewPresentor = class("ExteriorOtherSkin12ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin12ViewPresentor:ctor()
	ExteriorOtherSkin12ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin12ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin12ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_12.prefab"
	}
end

function ExteriorOtherSkin12ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin12View.New()
	}
end

function ExteriorOtherSkin12ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin12ViewPresentor
