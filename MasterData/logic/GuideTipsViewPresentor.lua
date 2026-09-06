-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideTipsViewPresentor.lua

module("logic.extensions.guide.view.GuideTipsViewPresentor", package.seeall)

local GuideTipsViewPresentor = class("GuideTipsViewPresentor", GuideViewPresentor)

function GuideTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_tips.prefab"
	}
end

function GuideTipsViewPresentor:buildViews()
	local views = {}
	local guideTipsView = GuideTipsView.New()

	table.insert(views, guideTipsView)

	return views
end

return GuideTipsViewPresentor
