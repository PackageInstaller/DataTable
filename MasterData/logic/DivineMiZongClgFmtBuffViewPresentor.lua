-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgFmtBuffViewPresentor.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgFmtBuffViewPresentor", package.seeall)

local DivineMiZongClgFmtBuffViewPresentor = class("DivineMiZongClgFmtBuffViewPresentor", ViewPresentor)

function DivineMiZongClgFmtBuffViewPresentor:ctor()
	DivineMiZongClgFmtBuffViewPresentor.super.ctor(self)
end

function DivineMiZongClgFmtBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiZongClgFmtBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemizongclg/divinemizongclgfmtbuffview.prefab"
	}
end

function DivineMiZongClgFmtBuffViewPresentor:buildViews()
	return {
		DivineMiZongClgFmtBuffView.New()
	}
end

return DivineMiZongClgFmtBuffViewPresentor
