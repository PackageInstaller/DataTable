-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooDigViewPresentor.lua

module("logic.extensions.zoo.view.ZooDigViewPresentor", package.seeall)

local ZooDigViewPresentor = class("ZooDigViewPresentor", ViewPresentor)

function ZooDigViewPresentor:ctor()
	ZooDigViewPresentor.super.ctor(self)
end

function ZooDigViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZooDigViewPresentor:dependWhatResources()
	return {
		"ui/views/treasurenew/treasurenewdigview.prefab"
	}
end

function ZooDigViewPresentor:getTempResources()
	return {
		GameUrl.getSpineUrl("30001_xunbao_gaotou")
	}
end

function ZooDigViewPresentor:buildViews()
	return {
		ZooDigView.New()
	}
end

return ZooDigViewPresentor
