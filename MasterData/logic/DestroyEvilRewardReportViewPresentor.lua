-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardReportViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardReportViewPresentor", package.seeall)

local DestroyEvilRewardReportViewPresentor = class("DestroyEvilRewardReportViewPresentor", ViewPresentor)

function DestroyEvilRewardReportViewPresentor:ctor()
	DestroyEvilRewardReportViewPresentor.super.ctor(self)
end

function DestroyEvilRewardReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilRewardReportViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilrewardreportview.prefab"
	}
end

function DestroyEvilRewardReportViewPresentor:buildViews()
	return {
		DestroyEvilRewardReportView.New()
	}
end

return DestroyEvilRewardReportViewPresentor
