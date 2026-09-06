-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestSettlementViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestSettlementViewPresentor", package.seeall)

local MartialContestSettlementViewPresentor = class("MartialContestSettlementViewPresentor", ViewPresentor)

function MartialContestSettlementViewPresentor:ctor()
	MartialContestSettlementViewPresentor.super.ctor(self)
end

function MartialContestSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestsettlementview.prefab"
	}
end

function MartialContestSettlementViewPresentor:buildViews()
	return {
		MartialContestSettlementView.New()
	}
end

return MartialContestSettlementViewPresentor
