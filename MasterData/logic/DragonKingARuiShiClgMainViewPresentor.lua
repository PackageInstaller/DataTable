-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgMainViewPresentor.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgMainViewPresentor", package.seeall)

local DragonKingARuiShiClgMainViewPresentor = class("DragonKingARuiShiClgMainViewPresentor", ViewPresentor)

function DragonKingARuiShiClgMainViewPresentor:ctor()
	DragonKingARuiShiClgMainViewPresentor.super.ctor(self)
end

function DragonKingARuiShiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingARuiShiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishiclg/dragonkingaruishiclgmainview.prefab"
	}
end

function DragonKingARuiShiClgMainViewPresentor:buildViews()
	return {
		DragonKingARuiShiClgMainView.New()
	}
end

return DragonKingARuiShiClgMainViewPresentor
