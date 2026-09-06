-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonJobTipsPresentor.lua

module("logic.extensions.common.instruction.view.CommonJobTipsPresentor", package.seeall)

local CommonJobTipsPresentor = class("CommonJobTipsPresentor", ViewPresentor)

function CommonJobTipsPresentor:ctor()
	CommonJobTipsPresentor.super.ctor(self)
end

function CommonJobTipsPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CommonJobTipsPresentor:dependWhatResources()
	return {
		"ui/views/common/job_tips.prefab"
	}
end

function CommonJobTipsPresentor:buildViews()
	return {
		CommonJobTipsView.New()
	}
end

return CommonJobTipsPresentor
