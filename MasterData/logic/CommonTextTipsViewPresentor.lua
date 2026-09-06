-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonTextTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.CommonTextTipsViewPresentor", package.seeall)

local CommonTextTipsViewPresentor = class("CommonTextTipsViewPresentor", ViewPresentor)

function CommonTextTipsViewPresentor:ctor()
	CommonTextTipsViewPresentor.super.ctor(self)
end

function CommonTextTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function CommonTextTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/texttipsview.prefab"
	}
end

function CommonTextTipsViewPresentor:buildViews()
	local views = {}
	local view = CommonTextTipsView.New()

	table.insert(views, view)

	return views
end

return CommonTextTipsViewPresentor
