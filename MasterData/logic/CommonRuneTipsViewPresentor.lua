-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonRuneTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.CommonRuneTipsViewPresentor", package.seeall)

local CommonRuneTipsViewPresentor = class("CommonRuneTipsViewPresentor", ViewPresentor)

function CommonRuneTipsViewPresentor:ctor()
	CommonRuneTipsViewPresentor.super.ctor(self)
end

function CommonRuneTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CommonRuneTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/rune_tips.prefab"
	}
end

function CommonRuneTipsViewPresentor:buildViews()
	return {
		CommonRuneTipsView.New()
	}
end

return CommonRuneTipsViewPresentor
