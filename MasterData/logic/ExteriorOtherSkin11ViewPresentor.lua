-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin11ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin11ViewPresentor", package.seeall)

local ExteriorOtherSkin11ViewPresentor = class("ExteriorOtherSkin11ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin11ViewPresentor:ctor()
	ExteriorOtherSkin11ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin11ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin11ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_11.prefab"
	}
end

function ExteriorOtherSkin11ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin11View.New()
	}
end

function ExteriorOtherSkin11ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin11ViewPresentor
