-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanExtremeViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanExtremeViewPresentor", package.seeall)

local DivineCiYuanExtremeViewPresentor = class("DivineCiYuanExtremeViewPresentor", ViewPresentor)

function DivineCiYuanExtremeViewPresentor:ctor()
	DivineCiYuanExtremeViewPresentor.super.ctor(self)
end

function DivineCiYuanExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineCiYuanExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuanextremeview.prefab"
	}
end

function DivineCiYuanExtremeViewPresentor:buildViews()
	return {
		DivineCiYuanExtremeView.New()
	}
end

return DivineCiYuanExtremeViewPresentor
