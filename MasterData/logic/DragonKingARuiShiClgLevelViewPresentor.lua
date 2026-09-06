-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgLevelViewPresentor.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgLevelViewPresentor", package.seeall)

local DragonKingARuiShiClgLevelViewPresentor = class("DragonKingARuiShiClgLevelViewPresentor", ViewPresentor)

function DragonKingARuiShiClgLevelViewPresentor:ctor()
	DragonKingARuiShiClgLevelViewPresentor.super.ctor(self)
end

function DragonKingARuiShiClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingARuiShiClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishiclg/dragonkingaruishiclglevelview.prefab"
	}
end

function DragonKingARuiShiClgLevelViewPresentor:buildViews()
	return {
		DragonKingARuiShiClgLevelView.New()
	}
end

return DragonKingARuiShiClgLevelViewPresentor
