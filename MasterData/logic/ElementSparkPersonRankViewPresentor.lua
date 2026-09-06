-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPersonRankViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkPersonRankViewPresentor", package.seeall)

local ElementSparkPersonRankViewPresentor = class("ElementSparkPersonRankViewPresentor", ViewPresentor)

function ElementSparkPersonRankViewPresentor:ctor()
	ElementSparkPersonRankViewPresentor.super.ctor(self)
end

function ElementSparkPersonRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkPersonRankViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkpersonrankview.prefab"
	}
end

function ElementSparkPersonRankViewPresentor:buildViews()
	return {
		ElementSparkPersonRankView.New()
	}
end

return ElementSparkPersonRankViewPresentor
