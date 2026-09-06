-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/NuoyasummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.NuoyasummaryViewPresentor", package.seeall)

local NuoyasummaryViewPresentor = class("NuoyasummaryViewPresentor", ViewPresentor)

function NuoyasummaryViewPresentor:ctor()
	NuoyasummaryViewPresentor.super.ctor(self)
end

function NuoyasummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoyasummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/nuoyasummaryview.prefab"
	}
end

function NuoyasummaryViewPresentor:buildViews()
	return {
		NuoyaSummaryView.New()
	}
end

return NuoyasummaryViewPresentor
