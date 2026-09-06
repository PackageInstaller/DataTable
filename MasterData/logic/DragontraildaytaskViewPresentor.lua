-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontraildaytaskViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontraildaytaskViewPresentor", package.seeall)

local DragontraildaytaskViewPresentor = class("DragontraildaytaskViewPresentor", ViewPresentor)

function DragontraildaytaskViewPresentor:ctor()
	DragontraildaytaskViewPresentor.super.ctor(self)
end

function DragontraildaytaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontraildaytaskViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontraildaytaskview.prefab"
	}
end

function DragontraildaytaskViewPresentor:buildViews()
	return {
		DragontraildaytaskView.New()
	}
end

return DragontraildaytaskViewPresentor
