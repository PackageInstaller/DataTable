-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenBossFailViewPresentor.lua

module("logic.extensions.dragonxiuer.view.YushenBossFailViewPresentor", package.seeall)

local YushenBossFailViewPresentor = class("YushenBossFailViewPresentor", ViewPresentor)

function YushenBossFailViewPresentor:ctor()
	YushenBossFailViewPresentor.super.ctor(self)
end

function YushenBossFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YushenBossFailViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/copy/yushenbossfailview.prefab"
	}
end

function YushenBossFailViewPresentor:buildViews()
	return {
		YushenBossFailView.New()
	}
end

return YushenBossFailViewPresentor
