-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanextViewPresentor.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanextViewPresentor", package.seeall)

local OriginhuociyuanextViewPresentor = class("OriginhuociyuanextViewPresentor", ViewPresentor)

function OriginhuociyuanextViewPresentor:ctor()
	OriginhuociyuanextViewPresentor.super.ctor(self)
end

function OriginhuociyuanextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginhuociyuanextViewPresentor:dependWhatResources()
	return {
		"ui/views/originhuociyuan/originhuociyuanextview.prefab"
	}
end

function OriginhuociyuanextViewPresentor:buildViews()
	return {
		OriginhuociyuanextView.New()
	}
end

return OriginhuociyuanextViewPresentor
