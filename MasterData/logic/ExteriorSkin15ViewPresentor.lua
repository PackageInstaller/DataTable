-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin15ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin15ViewPresentor", package.seeall)

local ExteriorSkin15ViewPresentor = class("ExteriorSkin15ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin15ViewPresentor:ctor()
	ExteriorSkin15ViewPresentor.super.ctor(self)
end

function ExteriorSkin15ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin15ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_15.prefab"
	}
end

function ExteriorSkin15ViewPresentor:buildViews()
	return {
		ExteriorSkin15View.New()
	}
end

function ExteriorSkin15ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin15ViewPresentor
