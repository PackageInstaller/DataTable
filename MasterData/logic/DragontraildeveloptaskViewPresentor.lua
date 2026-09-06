-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontraildeveloptaskViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontraildeveloptaskViewPresentor", package.seeall)

local DragontraildeveloptaskViewPresentor = class("DragontraildeveloptaskViewPresentor", ViewPresentor)

function DragontraildeveloptaskViewPresentor:ctor()
	DragontraildeveloptaskViewPresentor.super.ctor(self)
end

function DragontraildeveloptaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontraildeveloptaskViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontraildeveloptaskview.prefab"
	}
end

function DragontraildeveloptaskViewPresentor:buildViews()
	return {
		DragontraildeveloptaskView.New()
	}
end

return DragontraildeveloptaskViewPresentor
