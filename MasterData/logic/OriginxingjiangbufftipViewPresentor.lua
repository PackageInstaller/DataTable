-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangbufftipViewPresentor.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangbufftipViewPresentor", package.seeall)

local OriginxingjiangbufftipViewPresentor = class("OriginxingjiangbufftipViewPresentor", ViewPresentor)

function OriginxingjiangbufftipViewPresentor:ctor()
	OriginxingjiangbufftipViewPresentor.super.ctor(self)
end

function OriginxingjiangbufftipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginxingjiangbufftipViewPresentor:dependWhatResources()
	return {
		"ui/views/orixingjiang/originxingjiangbufftipview.prefab"
	}
end

function OriginxingjiangbufftipViewPresentor:buildViews()
	return {
		OriginxingjiangbufftipView.New()
	}
end

return OriginxingjiangbufftipViewPresentor
