-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/QianNiaoZhenShenViewPresentor.lua

module("logic.extensions.challenge.view.specialviews.QianNiaoZhenShenViewPresentor", package.seeall)

local QianNiaoZhenShenViewPresentor = class("QianNiaoZhenShenViewPresentor", ViewPresentor)

function QianNiaoZhenShenViewPresentor:ctor()
	QianNiaoZhenShenViewPresentor.super.ctor(self)
end

function QianNiaoZhenShenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QianNiaoZhenShenViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/choose/spmissionview/qianniaozhenshenview.prefab"
	}
end

function QianNiaoZhenShenViewPresentor:buildViews()
	return {
		QianNiaoZhenShenView.New()
	}
end

return QianNiaoZhenShenViewPresentor
