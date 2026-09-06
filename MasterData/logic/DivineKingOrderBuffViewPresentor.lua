-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderBuffViewPresentor.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderBuffViewPresentor", package.seeall)

local DivineKingOrderBuffViewPresentor = class("DivineKingOrderBuffViewPresentor", ViewPresentor)

function DivineKingOrderBuffViewPresentor:ctor()
	DivineKingOrderBuffViewPresentor.super.ctor(self)
end

function DivineKingOrderBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingOrderBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingorder/divinekingorderbuffview.prefab"
	}
end

function DivineKingOrderBuffViewPresentor:buildViews()
	return {
		DivineKingOrderBuffView.New()
	}
end

return DivineKingOrderBuffViewPresentor
