-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin16ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin16ViewPresentor", package.seeall)

local ExteriorSkin16ViewPresentor = class("ExteriorSkin16ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin16ViewPresentor:ctor()
	ExteriorSkin16ViewPresentor.super.ctor(self)
end

function ExteriorSkin16ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin16ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_16.prefab"
	}
end

function ExteriorSkin16ViewPresentor:buildViews()
	return {
		ExteriorSkin16View.New()
	}
end

function ExteriorSkin16ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin16ViewPresentor
