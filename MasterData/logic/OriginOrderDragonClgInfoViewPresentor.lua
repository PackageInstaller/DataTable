-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgInfoViewPresentor.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgInfoViewPresentor", package.seeall)

local OriginOrderDragonClgInfoViewPresentor = class("OriginOrderDragonClgInfoViewPresentor", ViewPresentor)

function OriginOrderDragonClgInfoViewPresentor:ctor()
	OriginOrderDragonClgInfoViewPresentor.super.ctor(self)
end

function OriginOrderDragonClgInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginOrderDragonClgInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/originorderdragonclg/originorderdragonclginfoview.prefab"
	}
end

function OriginOrderDragonClgInfoViewPresentor:buildViews()
	return {
		OriginOrderDragonClgInfoView.New()
	}
end

return OriginOrderDragonClgInfoViewPresentor
