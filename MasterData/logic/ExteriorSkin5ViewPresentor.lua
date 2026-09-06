-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin5ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin5ViewPresentor", package.seeall)

local ExteriorSkin5ViewPresentor = class("ExteriorSkin5ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin5ViewPresentor:ctor()
	ExteriorSkin5ViewPresentor.super.ctor(self)
end

function ExteriorSkin5ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin5ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_5.prefab"
	}
end

function ExteriorSkin5ViewPresentor:buildViews()
	return {
		ExteriorSkin5View.New()
	}
end

function ExteriorSkin5ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin5ViewPresentor
