-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunLevelViewPresentor.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunLevelViewPresentor", package.seeall)

local DivineShiKongLongZunLevelViewPresentor = class("DivineShiKongLongZunLevelViewPresentor", ViewPresentor)

function DivineShiKongLongZunLevelViewPresentor:ctor()
	DivineShiKongLongZunLevelViewPresentor.super.ctor(self)
end

function DivineShiKongLongZunLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineShiKongLongZunLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divineshikonglongzun/divineshikonglongzunlevelview.prefab"
	}
end

function DivineShiKongLongZunLevelViewPresentor:buildViews()
	return {
		DivineShiKongLongZunLevelView.New()
	}
end

return DivineShiKongLongZunLevelViewPresentor
