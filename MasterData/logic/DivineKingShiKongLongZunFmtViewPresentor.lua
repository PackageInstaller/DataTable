-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunFmtViewPresentor.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunFmtViewPresentor", package.seeall)

local DivineKingShiKongLongZunFmtViewPresentor = class("DivineKingShiKongLongZunFmtViewPresentor", ViewPresentor)

function DivineKingShiKongLongZunFmtViewPresentor:ctor()
	DivineKingShiKongLongZunFmtViewPresentor.super.ctor(self)
end

function DivineKingShiKongLongZunFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingShiKongLongZunFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingshikongllongzun/divinekingshikonglongzunfmtview.prefab"
	}
end

function DivineKingShiKongLongZunFmtViewPresentor:buildViews()
	return {
		DivineKingShiKongLongZunFmtView.New()
	}
end

return DivineKingShiKongLongZunFmtViewPresentor
