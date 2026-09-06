-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgChallengeViewPresentor.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgChallengeViewPresentor", package.seeall)

local SummonMasterHopeClgChallengeViewPresentor = class("SummonMasterHopeClgChallengeViewPresentor", ViewPresentor)

function SummonMasterHopeClgChallengeViewPresentor:ctor()
	SummonMasterHopeClgChallengeViewPresentor.super.ctor(self)
end

function SummonMasterHopeClgChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterHopeClgChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterhopeclg/summonmasterhopeclgchallengeview.prefab"
	}
end

function SummonMasterHopeClgChallengeViewPresentor:buildViews()
	return {
		SummonMasterHopeClgChallengeView.New()
	}
end

return SummonMasterHopeClgChallengeViewPresentor
