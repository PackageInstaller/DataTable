-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongposViewPresentor.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongposViewPresentor", package.seeall)

local DivinexuanmingtianlongposViewPresentor = class("DivinexuanmingtianlongposViewPresentor", ViewPresentor)

function DivinexuanmingtianlongposViewPresentor:ctor()
	DivinexuanmingtianlongposViewPresentor.super.ctor(self)
end

function DivinexuanmingtianlongposViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexuanmingtianlongposViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexuanmingtianlong/divinexuanmingtianlongposview.prefab"
	}
end

function DivinexuanmingtianlongposViewPresentor:buildViews()
	return {
		DivinexuanmingtianlongposView.New()
	}
end

function DivinexuanmingtianlongposViewPresentor:setGrayMaskGO(grayMaskGO)
	DivinexuanmingtianlongposViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return DivinexuanmingtianlongposViewPresentor
