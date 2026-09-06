-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderResultViewPresentor.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderResultViewPresentor", package.seeall)

local DivineKingOrderResultViewPresentor = class("DivineKingOrderResultViewPresentor", ViewPresentor)

function DivineKingOrderResultViewPresentor:ctor()
	DivineKingOrderResultViewPresentor.super.ctor(self)
end

function DivineKingOrderResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineKingOrderResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingorder/divinekingorderresultview.prefab"
	}
end

function DivineKingOrderResultViewPresentor:buildViews()
	return {
		DivineKingOrderResultView.New()
	}
end

return DivineKingOrderResultViewPresentor
