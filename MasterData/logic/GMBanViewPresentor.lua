-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMBanViewPresentor.lua

module("logic.extensions.gm.view.GMBanViewPresentor", package.seeall)

local GMBanViewPresentor = class("GMBanViewPresentor", ViewPresentor)

function GMBanViewPresentor:ctor()
	GMBanViewPresentor.super.ctor(self)
end

function GMBanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GMBanViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmbanview.prefab"
	}
end

function GMBanViewPresentor:buildViews()
	return {
		GMBanView.New()
	}
end

return GMBanViewPresentor
