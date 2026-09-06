-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin22ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin22ViewPresentor", package.seeall)

local ExteriorSkin22ViewPresentor = class("ExteriorSkin22ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin22ViewPresentor:ctor()
	ExteriorSkin22ViewPresentor.super.ctor(self)
end

function ExteriorSkin22ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin22ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_22.prefab"
	}
end

function ExteriorSkin22ViewPresentor:buildViews()
	return {
		ExteriorSkin22View.New()
	}
end

function ExteriorSkin22ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin22ViewPresentor
