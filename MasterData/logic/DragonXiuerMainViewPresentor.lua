-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerMainViewPresentor.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerMainViewPresentor", package.seeall)

local DragonXiuerMainViewPresentor = class("DragonXiuerMainViewPresentor", ViewPresentor)

function DragonXiuerMainViewPresentor:ctor()
	DragonXiuerMainViewPresentor.super.ctor(self)
end

function DragonXiuerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonXiuerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/dragonxiuermainview.prefab"
	}
end

function DragonXiuerMainViewPresentor:buildViews()
	return {
		DragonXiuerMainView.New()
	}
end

return DragonXiuerMainViewPresentor
