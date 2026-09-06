-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/view/DragonpoolrewardViewPresentor.lua

module("logic.extensions.dragonpool.view.DragonpoolrewardViewPresentor", package.seeall)

local DragonpoolrewardViewPresentor = class("DragonpoolrewardViewPresentor", ViewPresentor)

function DragonpoolrewardViewPresentor:ctor()
	DragonpoolrewardViewPresentor.super.ctor(self)
end

function DragonpoolrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonpoolrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpool/dragonpoolrewardview.prefab"
	}
end

function DragonpoolrewardViewPresentor:buildViews()
	return {
		DragonpoolrewardView.New()
	}
end

return DragonpoolrewardViewPresentor
