-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonDropTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.CommonDropTipsViewPresentor", package.seeall)

local CommonDropTipsViewPresentor = class("CommonDropTipsViewPresentor", ViewPresentor)

function CommonDropTipsViewPresentor:ctor()
	CommonDropTipsViewPresentor.super.ctor(self)
end

function CommonDropTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CommonDropTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/drop_tips.prefab"
	}
end

function CommonDropTipsViewPresentor:buildViews()
	local views = {}
	local view = CommonDropTipsView.New()

	table.insert(views, view)

	return views
end

return CommonDropTipsViewPresentor
