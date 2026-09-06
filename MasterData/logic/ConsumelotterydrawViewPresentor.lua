-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumelotterydrawViewPresentor.lua

module("logic.extensions.consumelottery.view.ConsumelotterydrawViewPresentor", package.seeall)

local ConsumelotterydrawViewPresentor = class("ConsumelotterydrawViewPresentor", ViewPresentor)

function ConsumelotterydrawViewPresentor:ctor()
	ConsumelotterydrawViewPresentor.super.ctor(self)
end

function ConsumelotterydrawViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ConsumelotterydrawViewPresentor:dependWhatResources()
	return {
		"ui/views/consumelottery/consumelotterydrawview.prefab"
	}
end

function ConsumelotterydrawViewPresentor:buildViews()
	return {
		ConsumelotterydrawView.New()
	}
end

function ConsumelotterydrawViewPresentor:setGrayMaskGO(grayMaskGO)
	BigOrangeViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return ConsumelotterydrawViewPresentor
