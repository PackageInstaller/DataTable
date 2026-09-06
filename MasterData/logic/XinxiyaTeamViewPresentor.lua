-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaTeamViewPresentor.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaTeamViewPresentor", package.seeall)

local XinxiyaTeamViewPresentor = class("XinxiyaTeamViewPresentor", ViewWithGuidePresentor)

function XinxiyaTeamViewPresentor:ctor()
	XinxiyaTeamViewPresentor.super.ctor(self)
end

function XinxiyaTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XinxiyaTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/xinxiyamirror/xinxiyateamview.prefab"
	}
end

function XinxiyaTeamViewPresentor:buildViews()
	return {
		XinxiyaTeamView.New()
	}
end

return XinxiyaTeamViewPresentor
