-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangextViewPresentor.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangextViewPresentor", package.seeall)

local OriginxingjiangextViewPresentor = class("OriginxingjiangextViewPresentor", ViewPresentor)

function OriginxingjiangextViewPresentor:ctor()
	OriginxingjiangextViewPresentor.super.ctor(self)
end

function OriginxingjiangextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginxingjiangextViewPresentor:dependWhatResources()
	return {
		"ui/views/orixingjiang/originxingjiangextview.prefab"
	}
end

function OriginxingjiangextViewPresentor:buildViews()
	return {
		OriginxingjiangextView.New()
	}
end

return OriginxingjiangextViewPresentor
