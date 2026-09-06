-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabptEliRankrewardViewPresentor.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabptEliRankrewardViewPresentor", package.seeall)

local TabptEliRankrewardViewPresentor = class("TabptEliRankrewardViewPresentor", ViewPresentor)

function TabptEliRankrewardViewPresentor:ctor()
	TabptEliRankrewardViewPresentor.super.ctor(self)
end

function TabptEliRankrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabptEliRankrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/rewarddesc/tabptelirankrewardview.prefab"
	}
end

function TabptEliRankrewardViewPresentor:buildViews()
	return {
		TabptEliRankrewardView.New()
	}
end

return TabptEliRankrewardViewPresentor
