-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanNationalViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanNationalViewPresentor", package.seeall)

local DivineCiYuanNationalViewPresentor = class("DivineCiYuanNationalViewPresentor", ViewPresentor)

function DivineCiYuanNationalViewPresentor:ctor()
	DivineCiYuanNationalViewPresentor.super.ctor(self)
end

function DivineCiYuanNationalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineCiYuanNationalViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuannationalview.prefab"
	}
end

function DivineCiYuanNationalViewPresentor:buildViews()
	return {
		DivineCiYuanNationalView.New()
	}
end

return DivineCiYuanNationalViewPresentor
