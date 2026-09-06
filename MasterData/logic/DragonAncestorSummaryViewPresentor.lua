-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dragonancestor/DragonAncestorSummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.dragonancestor.DragonAncestorSummaryViewPresentor", package.seeall)

local DragonAncestorSummaryViewPresentor = class("DragonAncestorSummaryViewPresentor", ViewPresentor)

function DragonAncestorSummaryViewPresentor:ctor()
	DragonAncestorSummaryViewPresentor.super.ctor(self)
end

function DragonAncestorSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAncestorSummaryViewPresentor:dependWhatResources()
	local key = self.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))
	end

	local viewprefab = data.viewPrefab

	return {
		"ui/views/operationsummary/" .. viewprefab .. ".prefab"
	}
end

function DragonAncestorSummaryViewPresentor:buildViews()
	return {
		DragonAncestorSummaryView.New()
	}
end

return DragonAncestorSummaryViewPresentor
