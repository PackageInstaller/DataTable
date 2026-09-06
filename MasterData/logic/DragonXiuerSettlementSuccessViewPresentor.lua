-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerSettlementSuccessViewPresentor.lua

module("logic.extensions.battlesettlement.view.DragonXiuerSettlementSuccessViewPresentor", package.seeall)

local DragonXiuerSettlementSuccessViewPresentor = class("DragonXiuerSettlementSuccessViewPresentor", ViewPresentor)

function DragonXiuerSettlementSuccessViewPresentor:ctor()
	DragonXiuerSettlementSuccessViewPresentor.super.ctor(self)
end

function DragonXiuerSettlementSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonXiuerSettlementSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/dragonxiuersettlementsuccess.prefab"
	}
end

function DragonXiuerSettlementSuccessViewPresentor:buildViews()
	return {
		DragonXiuerSettlementSuccessView.New()
	}
end

return DragonXiuerSettlementSuccessViewPresentor
