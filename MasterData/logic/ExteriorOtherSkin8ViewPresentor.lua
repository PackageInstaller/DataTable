-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin8ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin8ViewPresentor", package.seeall)

local ExteriorOtherSkin8ViewPresentor = class("ExteriorOtherSkin8ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin8ViewPresentor:ctor()
	ExteriorOtherSkin8ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin8ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin8ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_8.prefab"
	}
end

function ExteriorOtherSkin8ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin8View.New()
	}
end

function ExteriorOtherSkin8ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin8ViewPresentor
