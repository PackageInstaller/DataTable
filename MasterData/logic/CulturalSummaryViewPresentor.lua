-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/cultural/CulturalSummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.cultural.CulturalSummaryViewPresentor", package.seeall)

local CulturalSummaryViewPresentor = class("CulturalSummaryViewPresentor", ViewPresentor)

function CulturalSummaryViewPresentor:ctor()
	CulturalSummaryViewPresentor.super.ctor(self)
end

function CulturalSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CulturalSummaryViewPresentor:dependWhatResources()
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

function CulturalSummaryViewPresentor:buildViews()
	return {
		CulturalSummaryView.New()
	}
end

return CulturalSummaryViewPresentor
