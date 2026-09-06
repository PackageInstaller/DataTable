-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongcontrolViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongcontrolViewPresentor", package.seeall)

local DivinexuanmingtianlongcontrolViewPresentor = class("DivinexuanmingtianlongcontrolViewPresentor", ViewPresentor)

function DivinexuanmingtianlongcontrolViewPresentor:ctor()
	DivinexuanmingtianlongcontrolViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongcontrolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongcontrolViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongcontrolview.prefab"
	}
end

function DivinexuanmingtianlongcontrolViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongcontrolView.New()
	}
end

return DivinexuanmingtianlongcontrolViewPresentor
