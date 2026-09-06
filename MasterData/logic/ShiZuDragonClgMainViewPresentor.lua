-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgMainViewPresentor.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgMainViewPresentor", package.seeall)

local ShiZuDragonClgMainViewPresentor = class("ShiZuDragonClgMainViewPresentor", ViewPresentor)

function ShiZuDragonClgMainViewPresentor:ctor()
	ShiZuDragonClgMainViewPresentor.super.ctor(self)
end

function ShiZuDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShiZuDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/shizudragonclg/shizudragonclgmainview.prefab"
	}
end

function ShiZuDragonClgMainViewPresentor:buildViews()
	return {
		ShiZuDragonClgMainView.New()
	}
end

return ShiZuDragonClgMainViewPresentor
