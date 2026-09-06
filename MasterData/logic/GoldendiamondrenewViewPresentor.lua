-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondrenewViewPresentor.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondrenewViewPresentor", package.seeall)

local GoldendiamondrenewViewPresentor = class("GoldendiamondrenewViewPresentor", ViewPresentor)

function GoldendiamondrenewViewPresentor:ctor()
	GoldendiamondrenewViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function GoldendiamondrenewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldendiamondrenewViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendiamondcard/goldendiamondrenewview.prefab"
	}
end

function GoldendiamondrenewViewPresentor:buildViews()
	return {
		GoldendiamondrenewView.New()
	}
end

return GoldendiamondrenewViewPresentor
