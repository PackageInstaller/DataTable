-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/qianli/QianliMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.qianli.QianliMainViewPresentor", package.seeall)

local QianliMainViewPresentor = class("QianliMainViewPresentor", ViewPresentor)

function QianliMainViewPresentor:ctor()
	QianliMainViewPresentor.super.ctor(self)
end

function QianliMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QianliMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/qianli/qianlimainview.prefab"
	}
end

function QianliMainViewPresentor:buildViews()
	return {
		QianliMainView.New()
	}
end

return QianliMainViewPresentor
