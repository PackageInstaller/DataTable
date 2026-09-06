-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideHighLightViewPresentor.lua

module("logic.extensions.guide.view.GuideHighLightViewPresentor", package.seeall)

local GuideHighLightViewPresentor = class("GuideHighLightViewPresentor", GuideViewPresentor)

function GuideHighLightViewPresentor:ctor()
	GuideHighLightViewPresentor.super.ctor(self)
end

function GuideHighLightViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideHighLightViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_highlight.prefab"
	}
end

function GuideHighLightViewPresentor:buildViews()
	local views = {}
	local guideFrameView = GuideHighLightView.New()

	table.insert(views, guideFrameView)

	return views
end

return GuideHighLightViewPresentor
