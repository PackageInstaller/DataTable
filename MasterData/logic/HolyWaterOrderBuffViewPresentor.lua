-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderBuffViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderBuffViewPresentor", package.seeall)

local HolyWaterOrderBuffViewPresentor = class("HolyWaterOrderBuffViewPresentor", ViewPresentor)

function HolyWaterOrderBuffViewPresentor:ctor()
	HolyWaterOrderBuffViewPresentor.super.ctor(self)
end

function HolyWaterOrderBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyWaterOrderBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderbuffview.prefab"
	}
end

function HolyWaterOrderBuffViewPresentor:buildViews()
	return {
		HolyWaterOrderBuffView.New()
	}
end

function HolyWaterOrderBuffViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyWaterOrderBuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return HolyWaterOrderBuffViewPresentor
