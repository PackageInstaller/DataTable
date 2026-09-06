-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanbuffViewPresentor.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanbuffViewPresentor", package.seeall)

local OriginhuociyuanbuffViewPresentor = class("OriginhuociyuanbuffViewPresentor", ViewPresentor)

function OriginhuociyuanbuffViewPresentor:ctor()
	OriginhuociyuanbuffViewPresentor.super.ctor(self)
end

function OriginhuociyuanbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginhuociyuanbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originhuociyuan/originhuociyuanbuffview.prefab"
	}
end

function OriginhuociyuanbuffViewPresentor:buildViews()
	return {
		OriginhuociyuanbuffView.New()
	}
end

return OriginhuociyuanbuffViewPresentor
