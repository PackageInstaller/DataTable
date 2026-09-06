-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerBossViewPresentor.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerbossViewPresentor", package.seeall)

local DragonXiuerbossViewPresentor = class("DragonXiuerbossViewPresentor", ViewPresentor)

function DragonXiuerbossViewPresentor:ctor()
	DragonXiuerbossViewPresentor.super.ctor(self)
end

function DragonXiuerbossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonXiuerbossViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/dragonxiuerbossview.prefab"
	}
end

function DragonXiuerbossViewPresentor:buildViews()
	return {
		DragonXiuerBossView.New()
	}
end

return DragonXiuerbossViewPresentor
