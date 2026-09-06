-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/qianli/QianliPassruleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.qianli.QianliPassruleViewPresentor", package.seeall)

local QianliPassruleViewPresentor = class("QianliPassruleViewPresentor", ViewPresentor)

function QianliPassruleViewPresentor:ctor()
	QianliPassruleViewPresentor.super.ctor(self)
end

function QianliPassruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function QianliPassruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmpassruleview.prefab"
	}
end

function QianliPassruleViewPresentor:buildViews()
	return {
		QianliPassruleView.New()
	}
end

return QianliPassruleViewPresentor
