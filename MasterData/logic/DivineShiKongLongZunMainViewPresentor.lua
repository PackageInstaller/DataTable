-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunMainViewPresentor.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunMainViewPresentor", package.seeall)

local DivineShiKongLongZunMainViewPresentor = class("DivineShiKongLongZunMainViewPresentor", ViewPresentor)

function DivineShiKongLongZunMainViewPresentor:ctor()
	DivineShiKongLongZunMainViewPresentor.super.ctor(self)
end

function DivineShiKongLongZunMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineShiKongLongZunMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineshikonglongzun/divineshikonglongzunmainview.prefab"
	}
end

function DivineShiKongLongZunMainViewPresentor:buildViews()
	return {
		DivineShiKongLongZunMainView.New()
	}
end

return DivineShiKongLongZunMainViewPresentor
