-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin12ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin12ViewPresentor", package.seeall)

local ExteriorSkin12ViewPresentor = class("ExteriorSkin12ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin12ViewPresentor:ctor()
	ExteriorSkin12ViewPresentor.super.ctor(self)
end

function ExteriorSkin12ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin12ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_12.prefab"
	}
end

function ExteriorSkin12ViewPresentor:buildViews()
	return {
		ExteriorSkin12View.New()
	}
end

function ExteriorSkin12ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin12ViewPresentor
