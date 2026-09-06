-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/powersurge/PowerSurgeRankViewPresentor.lua

module("logic.extensions.bonus.view.powersurge.PowerSurgeRankViewPresentor", package.seeall)

local PowerSurgeRankViewPresentor = class("PowerSurgeRankViewPresentor", ViewPresentor)

function PowerSurgeRankViewPresentor:ctor()
	PowerSurgeRankViewPresentor.super.ctor(self)
end

function PowerSurgeRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerSurgeRankViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/powersurge/powersurgerankview.prefab"
	}
end

function PowerSurgeRankViewPresentor:buildViews()
	return {
		PowerSurgeRankView.New()
	}
end

return PowerSurgeRankViewPresentor
