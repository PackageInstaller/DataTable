-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderMainViewPresentor.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderMainViewPresentor", package.seeall)

local DivineKingOrderMainViewPresentor = class("DivineKingOrderMainViewPresentor", ViewPresentor)

function DivineKingOrderMainViewPresentor:ctor()
	DivineKingOrderMainViewPresentor.super.ctor(self)
end

function DivineKingOrderMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingOrderMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingorder/divinekingordermainview.prefab"
	}
end

function DivineKingOrderMainViewPresentor:buildViews()
	return {
		DivineKingOrderMainView.New()
	}
end

return DivineKingOrderMainViewPresentor
