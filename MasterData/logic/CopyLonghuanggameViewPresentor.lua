-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/longhuang/CopyLonghuanggameViewPresentor.lua

module("logic.extensions.suppressgame.view.game.longhuang.CopyLonghuanggameViewPresentor", package.seeall)

local CopyLonghuanggameViewPresentor = class("CopyLonghuanggameViewPresentor", ViewPresentor)

function CopyLonghuanggameViewPresentor:ctor()
	CopyLonghuanggameViewPresentor.super.ctor(self)
end

function CopyLonghuanggameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyLonghuanggameViewPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/copylonghuanggameview.prefab"
	}
end

function CopyLonghuanggameViewPresentor:buildViews()
	return {
		CopyLonghuanggameView.New()
	}
end

return CopyLonghuanggameViewPresentor
