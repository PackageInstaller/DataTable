-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgRankTabFrameViewPresentor.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgRankTabFrameViewPresentor", package.seeall)

local SummonMasterHopeClgRankTabFrameViewPresentor = class("SummonMasterHopeClgRankTabFrameViewPresentor", ViewPresentor)

function SummonMasterHopeClgRankTabFrameViewPresentor:ctor()
	SummonMasterHopeClgRankTabFrameViewPresentor.super.ctor(self)
end

function SummonMasterHopeClgRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterHopeClgRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterhopeclg/summonmasterhopeclgranktabframeview.prefab"
	}
end

function SummonMasterHopeClgRankTabFrameViewPresentor:buildViews()
	return {
		SummonMasterHopeClgRankTabFrameView.New()
	}
end

return SummonMasterHopeClgRankTabFrameViewPresentor
