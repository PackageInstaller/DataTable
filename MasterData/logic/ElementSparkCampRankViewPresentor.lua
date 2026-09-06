-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkCampRankViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkCampRankViewPresentor", package.seeall)

local ElementSparkCampRankViewPresentor = class("ElementSparkCampRankViewPresentor", ViewPresentor)

function ElementSparkCampRankViewPresentor:ctor()
	ElementSparkCampRankViewPresentor.super.ctor(self)
end

function ElementSparkCampRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkCampRankViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkcamprankview.prefab"
	}
end

function ElementSparkCampRankViewPresentor:buildViews()
	return {
		ElementSparkCampRankView.New()
	}
end

return ElementSparkCampRankViewPresentor
