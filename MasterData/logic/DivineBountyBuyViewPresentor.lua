-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyBuyViewPresentor.lua

module("logic.extensions.divinebounty.view.DivineBountyBuyViewPresentor", package.seeall)

local DivineBountyBuyViewPresentor = class("DivineBountyBuyViewPresentor", ViewPresentor)

function DivineBountyBuyViewPresentor:ctor()
	DivineBountyBuyViewPresentor.super.ctor(self)
end

function DivineBountyBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineBountyBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/divinebounty/divinebountybuyview.prefab"
	}
end

function DivineBountyBuyViewPresentor:buildViews()
	return {
		DivineBountyBuyView.New()
	}
end

return DivineBountyBuyViewPresentor
