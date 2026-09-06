-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumerankViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumerankViewPresentor", package.seeall)

local GodgemconsumerankViewPresentor = class("GodgemconsumerankViewPresentor", ViewPresentor)

function GodgemconsumerankViewPresentor:ctor()
	GodgemconsumerankViewPresentor.super.ctor(self)
end

function GodgemconsumerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumerankViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumerankview.prefab"
	}
end

function GodgemconsumerankViewPresentor:buildViews()
	return {
		GodgemconsumerankView.New()
	}
end

return GodgemconsumerankViewPresentor
