-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin9ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin9ViewPresentor", package.seeall)

local ExteriorSkin9ViewPresentor = class("ExteriorSkin9ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin9ViewPresentor:ctor()
	ExteriorSkin9ViewPresentor.super.ctor(self)
end

function ExteriorSkin9ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin9ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_9.prefab"
	}
end

function ExteriorSkin9ViewPresentor:buildViews()
	return {
		ExteriorSkin9View.New()
	}
end

function ExteriorSkin9ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin9ViewPresentor
