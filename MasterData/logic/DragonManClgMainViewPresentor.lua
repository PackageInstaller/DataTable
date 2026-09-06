-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgMainViewPresentor.lua

module("logic.extensions.dragonmanclg.view.DragonManClgMainViewPresentor", package.seeall)

local DragonManClgMainViewPresentor = class("DragonManClgMainViewPresentor", ViewPresentor)

function DragonManClgMainViewPresentor:ctor()
	DragonManClgMainViewPresentor.super.ctor(self)
end

function DragonManClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonManClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonmanclg/dragonmanclgmainview.prefab"
	}
end

function DragonManClgMainViewPresentor:buildViews()
	return {
		DragonManClgMainView.New()
	}
end

return DragonManClgMainViewPresentor
