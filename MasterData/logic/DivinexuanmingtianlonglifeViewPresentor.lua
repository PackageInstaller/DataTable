-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlonglifeViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlonglifeViewPresentor", package.seeall)

local DivinexuanmingtianlonglifeViewPresentor = class("DivinexuanmingtianlonglifeViewPresentor", ViewPresentor)

function DivinexuanmingtianlonglifeViewPresentor:ctor()
	DivinexuanmingtianlonglifeViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlonglifeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlonglifeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlonglifeview.prefab"
	}
end

function DivinexuanmingtianlonglifeViewPresentor:buildViews()
	return {
		DivinexuanmingtianlonglifeView.New()
	}
end

return DivinexuanmingtianlonglifeViewPresentor
