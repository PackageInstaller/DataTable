-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisilevelViewPresentor.lua

module("logic.extensions.dragonaruisi.view.DragonaruisilevelViewPresentor", package.seeall)

local DragonaruisilevelViewPresentor = class("DragonaruisilevelViewPresentor", ViewPresentor)

function DragonaruisilevelViewPresentor:ctor()
	DragonaruisilevelViewPresentor.super.ctor(self)
end

function DragonaruisilevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonaruisilevelViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonaruisi/dragonaruisilevelview.prefab"
	}
end

function DragonaruisilevelViewPresentor:buildViews()
	return {
		DragonaruisilevelView.New()
	}
end

return DragonaruisilevelViewPresentor
