-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/stage/StagePetShopViewPresentor.lua

module("logic.extensions.powerland.view.stage.StagePetShopViewPresentor", package.seeall)

local StagePetShopViewPresentor = class("StagePetShopViewPresentor", ViewPresentor)

function StagePetShopViewPresentor:ctor()
	StagePetShopViewPresentor.super.ctor(self)
end

function StagePetShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StagePetShopViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/stagepetshopview.prefab"
	}
end

function StagePetShopViewPresentor:buildViews()
	return {
		StagePetShopView.New()
	}
end

return StagePetShopViewPresentor
