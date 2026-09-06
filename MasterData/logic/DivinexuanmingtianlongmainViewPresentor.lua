-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongmainViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongmainViewPresentor", package.seeall)

local DivinexuanmingtianlongmainViewPresentor = class("DivinexuanmingtianlongmainViewPresentor", ViewPresentor)

function DivinexuanmingtianlongmainViewPresentor:ctor()
	DivinexuanmingtianlongmainViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongmainview.prefab"
	}
end

function DivinexuanmingtianlongmainViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongmainView.New()
	}
end

return DivinexuanmingtianlongmainViewPresentor
