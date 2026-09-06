-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanmainViewPresentor.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanmainViewPresentor", package.seeall)

local OriginhuociyuanmainViewPresentor = class("OriginhuociyuanmainViewPresentor", ViewPresentor)

function OriginhuociyuanmainViewPresentor:ctor()
	OriginhuociyuanmainViewPresentor.super.ctor(self)
end

function OriginhuociyuanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginhuociyuanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originhuociyuan/originhuociyuanmainview.prefab"
	}
end

function OriginhuociyuanmainViewPresentor:buildViews()
	return {
		OriginhuociyuanmainView.New()
	}
end

return OriginhuociyuanmainViewPresentor
