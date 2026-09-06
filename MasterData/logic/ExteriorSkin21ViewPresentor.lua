-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin21ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin21ViewPresentor", package.seeall)

local ExteriorSkin21ViewPresentor = class("ExteriorSkin21ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin21ViewPresentor:ctor()
	ExteriorSkin21ViewPresentor.super.ctor(self)
end

function ExteriorSkin21ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin21ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_21.prefab"
	}
end

function ExteriorSkin21ViewPresentor:buildViews()
	return {
		ExteriorSkin21View.New()
	}
end

function ExteriorSkin21ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin21ViewPresentor
