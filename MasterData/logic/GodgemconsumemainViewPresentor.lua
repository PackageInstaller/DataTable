-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumemainViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumemainViewPresentor", package.seeall)

local GodgemconsumemainViewPresentor = class("GodgemconsumemainViewPresentor", ViewPresentor)

function GodgemconsumemainViewPresentor:ctor()
	GodgemconsumemainViewPresentor.super.ctor(self)
end

function GodgemconsumemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumemainViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumemainview.prefab"
	}
end

function GodgemconsumemainViewPresentor:buildViews()
	return {
		GodgemconsumemainView.New()
	}
end

return GodgemconsumemainViewPresentor
