-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunFightEndViewPresentor.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunFightEndViewPresentor", package.seeall)

local DivineKingShiKongLongZunFightEndViewPresentor = class("DivineKingShiKongLongZunFightEndViewPresentor", ViewPresentor)

function DivineKingShiKongLongZunFightEndViewPresentor:ctor()
	DivineKingShiKongLongZunFightEndViewPresentor.super.ctor(self)
end

function DivineKingShiKongLongZunFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingShiKongLongZunFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingshikongllongzun/divinekingshikonglongzunfightendview.prefab"
	}
end

function DivineKingShiKongLongZunFightEndViewPresentor:buildViews()
	return {
		DivineKingShiKongLongZunFightEndView.New()
	}
end

return DivineKingShiKongLongZunFightEndViewPresentor
