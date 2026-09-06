-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderStageViewPresentor.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderStageViewPresentor", package.seeall)

local DivineKingOrderStageViewPresentor = class("DivineKingOrderStageViewPresentor", ViewPresentor)

function DivineKingOrderStageViewPresentor:ctor()
	DivineKingOrderStageViewPresentor.super.ctor(self)
end

function DivineKingOrderStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingOrderStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingorder/divinekingorderstageview.prefab"
	}
end

function DivineKingOrderStageViewPresentor:buildViews()
	return {
		DivineKingOrderStageView.New()
	}
end

return DivineKingOrderStageViewPresentor
