-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originanangel/view/OriginAnAngelMainViewPresentor.lua

module("logic.extensions.originanangel.view.OriginAnAngelMainViewPresentor", package.seeall)

local OriginAnAngelMainViewPresentor = class("OriginAnAngelMainViewPresentor", ViewPresentor)

function OriginAnAngelMainViewPresentor:ctor()
	OriginAnAngelMainViewPresentor.super.ctor(self)
end

function OriginAnAngelMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnAngelMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originanangel/originanangelmainview.prefab"
	}
end

function OriginAnAngelMainViewPresentor:buildViews()
	return {
		OriginAnAngelMainView.New()
	}
end

return OriginAnAngelMainViewPresentor
