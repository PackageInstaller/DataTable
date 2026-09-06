-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin5ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin5ViewPresentor", package.seeall)

local ExteriorOtherSkin5ViewPresentor = class("ExteriorOtherSkin5ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin5ViewPresentor:ctor()
	ExteriorOtherSkin5ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin5ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin5ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_5.prefab"
	}
end

function ExteriorOtherSkin5ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin5View.New()
	}
end

function ExteriorOtherSkin5ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin5ViewPresentor
