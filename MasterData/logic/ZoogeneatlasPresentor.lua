-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogeneatlasPresentor.lua

module("logic.extensions.zoo.view.ZoogeneatlasPresentor", package.seeall)

local ZoogeneatlasPresentor = class("ZoogeneatlasPresentor", ViewPresentor)

function ZoogeneatlasPresentor:ctor()
	ZoogeneatlasPresentor.super.ctor(self)
end

function ZoogeneatlasPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoogeneatlasPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoogeneatlasview.prefab",
		ItemGene.ResPath
	}
end

function ZoogeneatlasPresentor:buildViews()
	return {
		ZoogeneatlasView.New()
	}
end

return ZoogeneatlasPresentor
