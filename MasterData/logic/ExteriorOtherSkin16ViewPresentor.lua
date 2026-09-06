-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin16ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin16ViewPresentor", package.seeall)

local ExteriorOtherSkin16ViewPresentor = class("ExteriorOtherSkin16ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin16ViewPresentor:ctor()
	ExteriorOtherSkin16ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin16ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin16ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_16.prefab"
	}
end

function ExteriorOtherSkin16ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin16View.New()
	}
end

function ExteriorOtherSkin16ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin16ViewPresentor
