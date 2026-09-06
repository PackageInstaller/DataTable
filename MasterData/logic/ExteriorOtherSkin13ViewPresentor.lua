-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin13ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin13ViewPresentor", package.seeall)

local ExteriorOtherSkin13ViewPresentor = class("ExteriorOtherSkin13ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin13ViewPresentor:ctor()
	ExteriorOtherSkin13ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin13ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin13ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_13.prefab"
	}
end

function ExteriorOtherSkin13ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin13View.New()
	}
end

function ExteriorOtherSkin13ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin13ViewPresentor
