-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/view/CashBackLuckyViewPresentor.lua

module("logic.extensions.cashback.view.CashBackLuckyViewPresentor", package.seeall)

local CashBackLuckyViewPresentor = class("CashBackLuckyViewPresentor", ViewPresentor)

function CashBackLuckyViewPresentor:ctor()
	CashBackLuckyViewPresentor.super.ctor(self)
end

function CashBackLuckyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CashBackLuckyViewPresentor:dependWhatResources()
	return {
		"ui/views/cashback/cashbackluckyview.prefab"
	}
end

function CashBackLuckyViewPresentor:buildViews()
	return {
		CashBackLuckyView.New()
	}
end

return CashBackLuckyViewPresentor
