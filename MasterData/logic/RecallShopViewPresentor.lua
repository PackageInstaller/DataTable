-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallShopViewPresentor.lua

module("logic.extensions.recalltask.view.RecallShopViewPresentor", package.seeall)

local RecallShopViewPresentor = class("RecallShopViewPresentor", ViewPresentor)

function RecallShopViewPresentor:ctor()
	RecallShopViewPresentor.super.ctor(self)
end

function RecallShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecallShopViewPresentor:dependWhatResources()
	return {
		"ui/views/recalltask/recallshopview.prefab"
	}
end

function RecallShopViewPresentor:buildViews()
	return {
		RecallShopView.New()
	}
end

return RecallShopViewPresentor
