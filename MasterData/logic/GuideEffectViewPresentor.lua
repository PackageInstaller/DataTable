-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideEffectViewPresentor.lua

module("logic.extensions.guide.view.GuideEffectViewPresentor", package.seeall)

local GuideEffectViewPresentor = class("GuideEffectViewPresentor", GuideViewPresentor)

function GuideEffectViewPresentor:ctor()
	GuideEffectViewPresentor.super.ctor(self)
end

function GuideEffectViewPresentor:attachToWhichRoot()
	return nil
end

function GuideEffectViewPresentor:dependWhatResources()
	local branch = GuideModel.instance:getCurrGuideBranch()
	local guide = branch:getGuide()
	local resTable = {}

	table.insert(resTable, guide:getGuideUIParams()[1])

	return resTable
end

function GuideEffectViewPresentor:buildViews()
	return {
		GuideEffectView.New()
	}
end

return GuideEffectViewPresentor
