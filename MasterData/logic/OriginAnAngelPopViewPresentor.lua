-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originanangel/view/OriginAnAngelPopViewPresentor.lua

module("logic.extensions.originanangel.view.OriginAnAngelPopViewPresentor", package.seeall)

local OriginAnAngelPopViewPresentor = class("OriginAnAngelPopViewPresentor", ViewPresentor)

function OriginAnAngelPopViewPresentor:ctor()
	OriginAnAngelPopViewPresentor.super.ctor(self)
end

function OriginAnAngelPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnAngelPopViewPresentor:dependWhatResources()
	return {
		"ui/views/originanangel/originanangelpopview.prefab"
	}
end

function OriginAnAngelPopViewPresentor:buildViews()
	return {
		OriginAnAngelPopView.New()
	}
end

return OriginAnAngelPopViewPresentor
