-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortGoodsViewPresentor.lua

module("logic.extensions.escort.view.EscortGoodsViewPresentor", package.seeall)

local EscortGoodsViewPresentor = class("EscortGoodsViewPresentor", ViewWithGuidePresentor)

function EscortGoodsViewPresentor:ctor()
	EscortGoodsViewPresentor.super.ctor(self)
end

function EscortGoodsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EscortGoodsViewPresentor:dependWhatResources()
	return {
		"ui/views/escort/escortgoodsview.prefab"
	}
end

function EscortGoodsViewPresentor:buildViews()
	return {
		EscortGoodsView.New()
	}
end

return EscortGoodsViewPresentor
