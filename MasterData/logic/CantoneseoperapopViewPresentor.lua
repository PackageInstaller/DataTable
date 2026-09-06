-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperapopViewPresentor.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperapopViewPresentor", package.seeall)

local CantoneseoperapopViewPresentor = class("CantoneseoperapopViewPresentor", ViewPresentor)

function CantoneseoperapopViewPresentor:ctor()
	CantoneseoperapopViewPresentor.super.ctor(self)
end

function CantoneseoperapopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CantoneseoperapopViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseopera/cantoneseoperapopview.prefab"
	}
end

function CantoneseoperapopViewPresentor:buildViews()
	return {
		CantoneseoperapopView.New()
	}
end

return CantoneseoperapopViewPresentor
