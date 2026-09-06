-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgFmtExViewPresentor.lua

module("logic.extensions.dragonmanclg.view.DragonManClgFmtExViewPresentor", package.seeall)

local DragonManClgFmtExViewPresentor = class("DragonManClgFmtExViewPresentor", ViewPresentor)

function DragonManClgFmtExViewPresentor:ctor()
	DragonManClgFmtExViewPresentor.super.ctor(self)
end

function DragonManClgFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonManClgFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonmanclg/dragonmanclgfmtexview.prefab"
	}
end

function DragonManClgFmtExViewPresentor:buildViews()
	return {
		DragonManClgFmtExView.New()
	}
end

return DragonManClgFmtExViewPresentor
