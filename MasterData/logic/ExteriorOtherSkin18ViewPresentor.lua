-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin18ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin18ViewPresentor", package.seeall)

local ExteriorOtherSkin18ViewPresentor = class("ExteriorOtherSkin18ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin18ViewPresentor:ctor()
	ExteriorOtherSkin18ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin18ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin18ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_18.prefab"
	}
end

function ExteriorOtherSkin18ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin18View.New()
	}
end

function ExteriorOtherSkin18ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin18ViewPresentor
