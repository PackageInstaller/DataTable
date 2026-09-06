-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisimainViewPresentor.lua

module("logic.extensions.dragonaruisi.view.DragonaruisimainViewPresentor", package.seeall)

local DragonaruisimainViewPresentor = class("DragonaruisimainViewPresentor", ViewPresentor)

function DragonaruisimainViewPresentor:ctor()
	DragonaruisimainViewPresentor.super.ctor(self)
end

function DragonaruisimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonaruisimainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonaruisi/dragonaruisimainview.prefab"
	}
end

function DragonaruisimainViewPresentor:buildViews()
	return {
		DragonaruisimainView.New()
	}
end

return DragonaruisimainViewPresentor
