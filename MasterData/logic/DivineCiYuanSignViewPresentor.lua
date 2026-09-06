-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanSignViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanSignViewPresentor", package.seeall)

local DivineCiYuanSignViewPresentor = class("DivineCiYuanSignViewPresentor", ViewPresentor)

function DivineCiYuanSignViewPresentor:ctor()
	DivineCiYuanSignViewPresentor.super.ctor(self)
end

function DivineCiYuanSignViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineCiYuanSignViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuansignview.prefab"
	}
end

function DivineCiYuanSignViewPresentor:buildViews()
	return {
		DivineCiYuanSignView.New()
	}
end

return DivineCiYuanSignViewPresentor
