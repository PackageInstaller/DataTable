-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisiclgViewPresentor.lua

module("logic.extensions.dragonaruisi.view.DragonaruisiclgViewPresentor", package.seeall)

local DragonaruisiclgViewPresentor = class("DragonaruisiclgViewPresentor", ViewPresentor)

function DragonaruisiclgViewPresentor:ctor()
	DragonaruisiclgViewPresentor.super.ctor(self)
end

function DragonaruisiclgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonaruisiclgViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonaruisi/dragonaruisiclgview.prefab"
	}
end

function DragonaruisiclgViewPresentor:buildViews()
	return {
		DragonaruisiclgView.New()
	}
end

return DragonaruisiclgViewPresentor
