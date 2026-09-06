-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgMainViewPresentor.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgMainViewPresentor", package.seeall)

local SummonMasterHopeClgMainViewPresentor = class("SummonMasterHopeClgMainViewPresentor", ViewPresentor)

function SummonMasterHopeClgMainViewPresentor:ctor()
	SummonMasterHopeClgMainViewPresentor.super.ctor(self)
end

function SummonMasterHopeClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummonMasterHopeClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/summonmasterhopeclg/summonmasterhopeclgmainview.prefab"
	}
end

function SummonMasterHopeClgMainViewPresentor:buildViews()
	return {
		SummonMasterHopeClgMainView.New()
	}
end

return SummonMasterHopeClgMainViewPresentor
