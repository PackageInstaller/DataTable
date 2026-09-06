-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideFrameViewPresentor.lua

module("logic.extensions.guide.view.GuideFrameViewPresentor", package.seeall)

local GuideFrameViewPresentor = class("GuideFrameViewPresentor", GuideViewPresentor)

function GuideFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_light_frame.prefab"
	}
end

function GuideFrameViewPresentor:buildViews()
	local views = {}
	local guideFrameView = GuideFrameView.New()

	table.insert(views, guideFrameView)

	return views
end

return GuideFrameViewPresentor
