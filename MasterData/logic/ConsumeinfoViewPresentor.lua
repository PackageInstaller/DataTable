-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumeinfoViewPresentor.lua

module("logic.extensions.consumelottery.view.ConsumeinfoViewPresentor", package.seeall)

local ConsumeinfoViewPresentor = class("ConsumeinfoViewPresentor", ViewPresentor)

function ConsumeinfoViewPresentor:ctor()
	ConsumeinfoViewPresentor.super.ctor(self)
end

function ConsumeinfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ConsumeinfoViewPresentor:dependWhatResources()
	return {
		"ui/views/consumelottery/consumeinfoview.prefab"
	}
end

function ConsumeinfoViewPresentor:buildViews()
	return {
		ConsumeinfoView.New()
	}
end

function ConsumeinfoViewPresentor:setGrayMaskGO(grayMaskGO)
	BigOrangeViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return ConsumeinfoViewPresentor
