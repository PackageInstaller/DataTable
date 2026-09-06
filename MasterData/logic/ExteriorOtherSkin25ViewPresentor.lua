-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin25ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin25ViewPresentor", package.seeall)

local ExteriorOtherSkin25ViewPresentor = class("ExteriorOtherSkin25ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin25ViewPresentor:ctor()
	ExteriorOtherSkin25ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin25ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin25ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_25.prefab"
	}
end

function ExteriorOtherSkin25ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin25View.New()
	}
end

function ExteriorOtherSkin25ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin25ViewPresentor
