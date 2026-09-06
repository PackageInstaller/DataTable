-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSaprkCampDetailViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSaprkCampDetailViewPresentor", package.seeall)

local ElementSaprkCampDetailViewPresentor = class("ElementSaprkCampDetailViewPresentor", ViewPresentor)

function ElementSaprkCampDetailViewPresentor:ctor()
	ElementSaprkCampDetailViewPresentor.super.ctor(self)
end

function ElementSaprkCampDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSaprkCampDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsaprkcampdetailview.prefab"
	}
end

function ElementSaprkCampDetailViewPresentor:buildViews()
	return {
		ElementSaprkCampDetailView.New()
	}
end

return ElementSaprkCampDetailViewPresentor
