-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/qianli/QianliDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.qianli.QianliDifficultyViewPresentor", package.seeall)

local QianliDifficultyViewPresentor = class("QianliDifficultyViewPresentor", ViewPresentor)

function QianliDifficultyViewPresentor:ctor()
	QianliDifficultyViewPresentor.super.ctor(self)
end

function QianliDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QianliDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/qianli/qianlidifficultyview.prefab"
	}
end

function QianliDifficultyViewPresentor:buildViews()
	return {
		QianliDifficultyView.New()
	}
end

return QianliDifficultyViewPresentor
