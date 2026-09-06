-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewViewPresentor.lua

module("logic.extensions.treasurenew.view.TreasurenewViewPresentor", package.seeall)

local TreasurenewViewPresentor = class("TreasurenewViewPresentor", ViewPresentor)

function TreasurenewViewPresentor:ctor()
	TreasurenewViewPresentor.super.ctor(self)
end

function TreasurenewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasurenewViewPresentor:dependWhatResources()
	return {
		"ui/views/treasurenew/treasurenewview.prefab"
	}
end

function TreasurenewViewPresentor:getTempResources()
	return {
		GameUrl.getSpineUrl("30001_xunbao_gaotou")
	}
end

function TreasurenewViewPresentor:buildViews()
	return {
		TreasurenewView.New()
	}
end

return TreasurenewViewPresentor
