-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanresultViewPresentor.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanresultViewPresentor", package.seeall)

local OriginhuociyuanresultViewPresentor = class("OriginhuociyuanresultViewPresentor", ViewPresentor)

function OriginhuociyuanresultViewPresentor:ctor()
	OriginhuociyuanresultViewPresentor.super.ctor(self)
end

function OriginhuociyuanresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginhuociyuanresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originhuociyuan/originhuociyuanresultview.prefab"
	}
end

function OriginhuociyuanresultViewPresentor:buildViews()
	return {
		OriginhuociyuanresultView.New()
	}
end

return OriginhuociyuanresultViewPresentor
