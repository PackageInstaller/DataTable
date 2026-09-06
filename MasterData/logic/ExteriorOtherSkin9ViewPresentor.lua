-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin9ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin9ViewPresentor", package.seeall)

local ExteriorOtherSkin9ViewPresentor = class("ExteriorOtherSkin9ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin9ViewPresentor:ctor()
	ExteriorOtherSkin9ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin9ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin9ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_9.prefab"
	}
end

function ExteriorOtherSkin9ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin9View.New()
	}
end

function ExteriorOtherSkin9ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin9ViewPresentor
