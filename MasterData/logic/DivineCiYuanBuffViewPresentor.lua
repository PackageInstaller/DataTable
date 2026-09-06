-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanBuffViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanBuffViewPresentor", package.seeall)

local DivineCiYuanBuffViewPresentor = class("DivineCiYuanBuffViewPresentor", ViewPresentor)

function DivineCiYuanBuffViewPresentor:ctor()
	DivineCiYuanBuffViewPresentor.super.ctor(self)
end

function DivineCiYuanBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineCiYuanBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuanbuffview.prefab"
	}
end

function DivineCiYuanBuffViewPresentor:buildViews()
	return {
		DivineCiYuanBuffView.New()
	}
end

return DivineCiYuanBuffViewPresentor
