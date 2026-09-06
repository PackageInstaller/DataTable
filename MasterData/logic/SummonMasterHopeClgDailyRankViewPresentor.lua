-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgDailyRankViewPresentor.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgDailyRankViewPresentor", package.seeall)

local SummonMasterHopeClgDailyRankViewPresentor = class("SummonMasterHopeClgDailyRankViewPresentor", ViewPresentor)

function SummonMasterHopeClgDailyRankViewPresentor:ctor()
	SummonMasterHopeClgDailyRankViewPresentor.super.ctor(self)
end

function SummonMasterHopeClgDailyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterHopeClgDailyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterhopeclg/summonmasterhopeclgdailyrankview.prefab"
	}
end

function SummonMasterHopeClgDailyRankViewPresentor:buildViews()
	return {
		SummonMasterHopeClgDailyRankView.New()
	}
end

return SummonMasterHopeClgDailyRankViewPresentor
