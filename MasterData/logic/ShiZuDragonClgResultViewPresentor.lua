-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgResultViewPresentor.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgResultViewPresentor", package.seeall)

local ShiZuDragonClgResultViewPresentor = class("ShiZuDragonClgResultViewPresentor", ViewPresentor)

function ShiZuDragonClgResultViewPresentor:ctor()
	ShiZuDragonClgResultViewPresentor.super.ctor(self)
end

function ShiZuDragonClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShiZuDragonClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/shizudragonclg/shizudragonclgresultview.prefab"
	}
end

function ShiZuDragonClgResultViewPresentor:buildViews()
	return {
		ShiZuDragonClgResultView.New()
	}
end

return ShiZuDragonClgResultViewPresentor
