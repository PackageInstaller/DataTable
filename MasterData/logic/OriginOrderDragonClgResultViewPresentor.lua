-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgResultViewPresentor.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgResultViewPresentor", package.seeall)

local OriginOrderDragonClgResultViewPresentor = class("OriginOrderDragonClgResultViewPresentor", ViewPresentor)

function OriginOrderDragonClgResultViewPresentor:ctor()
	OriginOrderDragonClgResultViewPresentor.super.ctor(self)
end

function OriginOrderDragonClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginOrderDragonClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originorderdragonclg/originorderdragonclgresultview.prefab"
	}
end

function OriginOrderDragonClgResultViewPresentor:buildViews()
	return {
		OriginOrderDragonClgResultView.New()
	}
end

return OriginOrderDragonClgResultViewPresentor
