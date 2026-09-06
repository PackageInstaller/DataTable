-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunMainViewPresentor.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunMainViewPresentor", package.seeall)

local DivineKingShiKongLongZunMainViewPresentor = class("DivineKingShiKongLongZunMainViewPresentor", ViewPresentor)

function DivineKingShiKongLongZunMainViewPresentor:ctor()
	DivineKingShiKongLongZunMainViewPresentor.super.ctor(self)
end

function DivineKingShiKongLongZunMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingShiKongLongZunMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingshikongllongzun/divinekingshikonglongzunmainview.prefab"
	}
end

function DivineKingShiKongLongZunMainViewPresentor:buildViews()
	return {
		DivineKingShiKongLongZunMainView.New()
	}
end

return DivineKingShiKongLongZunMainViewPresentor
