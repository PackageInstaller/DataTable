-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanTrailViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanTrailViewPresentor", package.seeall)

local DivineCiYuanTrailViewPresentor = class("DivineCiYuanTrailViewPresentor", ViewPresentor)

function DivineCiYuanTrailViewPresentor:ctor()
	DivineCiYuanTrailViewPresentor.super.ctor(self)
end

function DivineCiYuanTrailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineCiYuanTrailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuantrailview.prefab"
	}
end

function DivineCiYuanTrailViewPresentor:buildViews()
	return {
		DivineCiYuanTrailView.New()
	}
end

return DivineCiYuanTrailViewPresentor
