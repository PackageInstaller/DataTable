-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumerecordaddressViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumerecordaddressViewPresentor", package.seeall)

local GodgemconsumerecordaddressViewPresentor = class("GodgemconsumerecordaddressViewPresentor", ViewPresentor)

function GodgemconsumerecordaddressViewPresentor:ctor()
	GodgemconsumerecordaddressViewPresentor.super.ctor(self)
end

function GodgemconsumerecordaddressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumerecordaddressViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumerecordaddressview.prefab"
	}
end

function GodgemconsumerecordaddressViewPresentor:buildViews()
	return {
		GodgemconsumerecordaddressView.New()
	}
end

return GodgemconsumerecordaddressViewPresentor
