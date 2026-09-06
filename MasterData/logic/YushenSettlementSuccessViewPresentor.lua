-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenSettlementSuccessViewPresentor.lua

module("logic.extensions.battlesettlement.view.YushenSettlementSuccessViewPresentor", package.seeall)

local YushenSettlementSuccessViewPresentor = class("YushenSettlementSuccessViewPresentor", ViewPresentor)

function YushenSettlementSuccessViewPresentor:ctor()
	YushenSettlementSuccessViewPresentor.super.ctor(self)
end

function YushenSettlementSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YushenSettlementSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/copy/yushensettlementsuccess.prefab"
	}
end

function YushenSettlementSuccessViewPresentor:buildViews()
	return {
		YushenSettlementSuccessView.New()
	}
end

return YushenSettlementSuccessViewPresentor
