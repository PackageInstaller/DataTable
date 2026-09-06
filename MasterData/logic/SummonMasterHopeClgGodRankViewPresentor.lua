-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgGodRankViewPresentor.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgGodRankViewPresentor", package.seeall)

local SummonMasterHopeClgGodRankViewPresentor = class("SummonMasterHopeClgGodRankViewPresentor", ViewPresentor)

function SummonMasterHopeClgGodRankViewPresentor:ctor()
	SummonMasterHopeClgGodRankViewPresentor.super.ctor(self)
end

function SummonMasterHopeClgGodRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterHopeClgGodRankViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterhopeclg/summonmasterhopeclggodrankview.prefab"
	}
end

function SummonMasterHopeClgGodRankViewPresentor:buildViews()
	return {
		SummonMasterHopeClgGodRankView.New()
	}
end

return SummonMasterHopeClgGodRankViewPresentor
