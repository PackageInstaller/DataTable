-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonInstructionViewPresentor.lua

module("logic.extensions.common.instruction.view.CommonInstructionViewPresentor", package.seeall)

local CommonInstructionViewPresentor = class("CommonInstructionViewPresentor", ViewPresentor)

function CommonInstructionViewPresentor:ctor()
	CommonInstructionViewPresentor.super.ctor(self)
end

function CommonInstructionViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function CommonInstructionViewPresentor:dependWhatResources()
	return {
		"ui/views/common/instruction.prefab"
	}
end

function CommonInstructionViewPresentor:buildViews()
	local views = {}
	local view = CommonInstructionView.New()

	table.insert(views, view)

	return views
end

return CommonInstructionViewPresentor
