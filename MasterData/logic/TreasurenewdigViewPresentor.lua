-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewdigViewPresentor.lua

module("logic.extensions.treasurenew.view.TreasurenewdigViewPresentor", package.seeall)

local TreasurenewdigViewPresentor = class("TreasurenewdigViewPresentor", ViewPresentor)

function TreasurenewdigViewPresentor:ctor()
	TreasurenewdigViewPresentor.super.ctor(self)
end

function TreasurenewdigViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasurenewdigViewPresentor:dependWhatResources()
	return {
		"ui/views/treasurenew/treasurenewdigview.prefab"
	}
end

function TreasurenewdigViewPresentor:getTempResources()
	return {
		GameUrl.getSpineUrl("30001_xunbao_gaotou")
	}
end

function TreasurenewdigViewPresentor:buildViews()
	return {
		TreasurenewDigView.New()
	}
end

return TreasurenewdigViewPresentor
