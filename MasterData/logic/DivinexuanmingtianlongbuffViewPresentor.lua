-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongbuffViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongbuffViewPresentor", package.seeall)

local DivinexuanmingtianlongbuffViewPresentor = class("DivinexuanmingtianlongbuffViewPresentor", ViewPresentor)

function DivinexuanmingtianlongbuffViewPresentor:ctor()
	DivinexuanmingtianlongbuffViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongbuffview.prefab"
	}
end

function DivinexuanmingtianlongbuffViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongbuffView.New()
	}
end

return DivinexuanmingtianlongbuffViewPresentor
