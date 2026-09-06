-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerLevelViewPresentor.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerLevelViewPresentor", package.seeall)

local DragonXiuerLevelViewPresentor = class("DragonXiuerLevelViewPresentor", ViewPresentor)

function DragonXiuerLevelViewPresentor:ctor()
	DragonXiuerLevelViewPresentor.super.ctor(self)
end

function DragonXiuerLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonXiuerLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/dragonxiuerlevelview.prefab"
	}
end

function DragonXiuerLevelViewPresentor:buildViews()
	return {
		DragonXiuerLevelView.New()
	}
end

return DragonXiuerLevelViewPresentor
