-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongforecastViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongforecastViewPresentor", package.seeall)

local DivinexuanmingtianlongforecastViewPresentor = class("DivinexuanmingtianlongforecastViewPresentor", ViewPresentor)

function DivinexuanmingtianlongforecastViewPresentor:ctor()
	DivinexuanmingtianlongforecastViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongforecastViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongforecastViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongforecastview.prefab"
	}
end

function DivinexuanmingtianlongforecastViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongforecastView.New()
	}
end

return DivinexuanmingtianlongforecastViewPresentor
