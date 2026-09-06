-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/qianli/QianliRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.qianli.QianliRuleViewPresentor", package.seeall)

local QianliRuleViewPresentor = class("QianliRuleViewPresentor", ViewPresentor)

function QianliRuleViewPresentor:ctor()
	QianliRuleViewPresentor.super.ctor(self)
end

function QianliRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QianliRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/qianli/qianliruleview.prefab"
	}
end

function QianliRuleViewPresentor:buildViews()
	return {
		QianliRuleView.New()
	}
end

return QianliRuleViewPresentor
