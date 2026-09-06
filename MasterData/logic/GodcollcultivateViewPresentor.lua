-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GodcollcultivateViewPresentor.lua

module("logic.extensions.goddesscollector.view.GodcollcultivateViewPresentor", package.seeall)

local GodcollcultivateViewPresentor = class("GodcollcultivateViewPresentor", ViewPresentor)

function GodcollcultivateViewPresentor:ctor()
	GodcollcultivateViewPresentor.super.ctor(self)
end

function GodcollcultivateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodcollcultivateViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/godcollcultivateview.prefab"
	}
end

function GodcollcultivateViewPresentor:buildViews()
	return {
		GodcollcultivateView.New()
	}
end

return GodcollcultivateViewPresentor
