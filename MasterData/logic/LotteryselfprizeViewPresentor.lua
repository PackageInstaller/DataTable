-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryselfprizeViewPresentor.lua

module("logic.extensions.lottery.view.LotteryselfprizeViewPresentor", package.seeall)

local LotteryselfprizeViewPresentor = class("LotteryselfprizeViewPresentor", ViewPresentor)

function LotteryselfprizeViewPresentor:ctor()
	LotteryselfprizeViewPresentor.super.ctor(self)
end

function LotteryselfprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryselfprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryselfprizeview.prefab"
	}
end

function LotteryselfprizeViewPresentor:buildViews()
	return {
		LotteryselfprizeView.New()
	}
end

return LotteryselfprizeViewPresentor
