-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenBossViewPresentor.lua

module("logic.extensions.dragonxiuer.view.YushenbossViewPresentor", package.seeall)

local YushenbossViewPresentor = class("YushenbossViewPresentor", ViewPresentor)

function YushenbossViewPresentor:ctor()
	YushenbossViewPresentor.super.ctor(self)
end

function YushenbossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YushenbossViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/copy/yushenbossview.prefab"
	}
end

function YushenbossViewPresentor:buildViews()
	return {
		YushenBossView.New()
	}
end

return YushenbossViewPresentor
