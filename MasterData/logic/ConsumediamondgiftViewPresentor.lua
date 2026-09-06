-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/view/ConsumediamondgiftViewPresentor.lua

module("logic.extensions.consumediamondgift.view.ConsumediamondgiftViewPresentor", package.seeall)

local ConsumediamondgiftViewPresentor = class("ConsumediamondgiftViewPresentor", ViewPresentor)

function ConsumediamondgiftViewPresentor:ctor()
	ConsumediamondgiftViewPresentor.super.ctor(self)
end

function ConsumediamondgiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ConsumediamondgiftViewPresentor:dependWhatResources()
	return {
		"ui/views/consumediamondgift/consumediamondgiftview.prefab"
	}
end

function ConsumediamondgiftViewPresentor:buildViews()
	return {
		ConsumediamondgiftView.New()
	}
end

return ConsumediamondgiftViewPresentor
