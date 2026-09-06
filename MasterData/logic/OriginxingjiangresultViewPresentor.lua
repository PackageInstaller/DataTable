-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangresultViewPresentor.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangresultViewPresentor", package.seeall)

local OriginxingjiangresultViewPresentor = class("OriginxingjiangresultViewPresentor", ViewPresentor)

function OriginxingjiangresultViewPresentor:ctor()
	OriginxingjiangresultViewPresentor.super.ctor(self)
end

function OriginxingjiangresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginxingjiangresultViewPresentor:dependWhatResources()
	return {
		"ui/views/orixingjiang/originxingjiangresultview.prefab"
	}
end

function OriginxingjiangresultViewPresentor:buildViews()
	return {
		OriginxingjiangresultView.New()
	}
end

return OriginxingjiangresultViewPresentor
