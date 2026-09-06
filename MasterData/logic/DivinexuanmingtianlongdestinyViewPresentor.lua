-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongdestinyViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongdestinyViewPresentor", package.seeall)

local DivinexuanmingtianlongdestinyViewPresentor = class("DivinexuanmingtianlongdestinyViewPresentor", ViewPresentor)

function DivinexuanmingtianlongdestinyViewPresentor:ctor()
	DivinexuanmingtianlongdestinyViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongdestinyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongdestinyViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongdestinyview.prefab"
	}
end

function DivinexuanmingtianlongdestinyViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongdestinyView.New()
	}
end

return DivinexuanmingtianlongdestinyViewPresentor
