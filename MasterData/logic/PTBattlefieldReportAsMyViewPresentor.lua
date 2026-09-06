-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/battlereport/PTBattlefieldReportAsMyViewPresentor.lua

module("logic.extensions.peaktournament.view.common.battlereport.PTBattlefieldReportViewPresentor", package.seeall)

local PTBattlefieldReportViewPresentor = class("PTBattlefieldReportViewPresentor", ViewPresentor)

function PTBattlefieldReportViewPresentor:ctor()
	PTBattlefieldReportViewPresentor.super.ctor(self)
end

function PTBattlefieldReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PTBattlefieldReportViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/ptbattlefieldreportview.prefab"
	}
end

function PTBattlefieldReportViewPresentor:buildViews()
	return {
		PTBattlefieldReportAsMyView.New()
	}
end

return PTBattlefieldReportViewPresentor
