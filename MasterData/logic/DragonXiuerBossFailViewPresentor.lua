-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerBossFailViewPresentor.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerBossFailViewPresentor", package.seeall)

local DragonXiuerBossFailViewPresentor = class("DragonXiuerBossFailViewPresentor", ViewPresentor)

function DragonXiuerBossFailViewPresentor:ctor()
	DragonXiuerBossFailViewPresentor.super.ctor(self)
end

function DragonXiuerBossFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonXiuerBossFailViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/dragonxiuerbossfailview.prefab"
	}
end

function DragonXiuerBossFailViewPresentor:buildViews()
	return {
		DragonXiuerBossFailView.New()
	}
end

return DragonXiuerBossFailViewPresentor
