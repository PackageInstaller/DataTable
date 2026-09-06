-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgFmtExtisonViewPresentor.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgFmtExtisonViewPresentor", package.seeall)

local DivineMiZongClgFmtExtisonViewPresentor = class("DivineMiZongClgFmtExtisonViewPresentor", ViewPresentor)

function DivineMiZongClgFmtExtisonViewPresentor:ctor()
	DivineMiZongClgFmtExtisonViewPresentor.super.ctor(self)
end

function DivineMiZongClgFmtExtisonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiZongClgFmtExtisonViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemizongclg/divinemizongclgfmtextisonview.prefab"
	}
end

function DivineMiZongClgFmtExtisonViewPresentor:buildViews()
	return {
		DivineMiZongClgFmtExtisonView.New()
	}
end

return DivineMiZongClgFmtExtisonViewPresentor
