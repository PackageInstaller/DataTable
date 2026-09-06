-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/battlereport/PTBattlefieldReportAsEliFightViewPresentor.lua

module("logic.extensions.peaktournament.view.common.battlereport.PTBattlefieldReportAsEliFightViewPresentor", package.seeall)

local PTBattlefieldReportAsEliFightViewPresentor = class("PTBattlefieldReportAsEliFightViewPresentor", ViewPresentor)

function PTBattlefieldReportAsEliFightViewPresentor:ctor()
	PTBattlefieldReportAsEliFightViewPresentor.super.ctor(self)
end

function PTBattlefieldReportAsEliFightViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PTBattlefieldReportAsEliFightViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/ptbattlefieldreportview.prefab"
	}
end

function PTBattlefieldReportAsEliFightViewPresentor:buildViews()
	return {
		PTBattlefieldReportAsEliFightView.New()
	}
end

return PTBattlefieldReportAsEliFightViewPresentor
