-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgViewPresentor.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgViewPresentor", package.seeall)

local OriginOrderDragonClgViewPresentor = class("OriginOrderDragonClgViewPresentor", ViewPresentor)

function OriginOrderDragonClgViewPresentor:ctor()
	OriginOrderDragonClgViewPresentor.super.ctor(self)
end

function OriginOrderDragonClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginOrderDragonClgViewPresentor:dependWhatResources()
	return {
		"ui/views/originorderdragonclg/originorderdragonclgview.prefab"
	}
end

function OriginOrderDragonClgViewPresentor:buildViews()
	return {
		OriginOrderDragonClgView.New()
	}
end

return OriginOrderDragonClgViewPresentor
