-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin13ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin13ViewPresentor", package.seeall)

local ExteriorSkin13ViewPresentor = class("ExteriorSkin13ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin13ViewPresentor:ctor()
	ExteriorSkin13ViewPresentor.super.ctor(self)
end

function ExteriorSkin13ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin13ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_13.prefab"
	}
end

function ExteriorSkin13ViewPresentor:buildViews()
	return {
		ExteriorSkin13View.New()
	}
end

function ExteriorSkin13ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin13ViewPresentor
