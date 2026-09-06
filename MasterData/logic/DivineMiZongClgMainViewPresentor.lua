-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgMainViewPresentor.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgMainViewPresentor", package.seeall)

local DivineMiZongClgMainViewPresentor = class("DivineMiZongClgMainViewPresentor", ViewPresentor)

function DivineMiZongClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiZongClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemizongclg/divinemizongclgmainview.prefab"
	}
end

function DivineMiZongClgMainViewPresentor:buildViews()
	return {
		DivineMiZongClgMainView.New()
	}
end

return DivineMiZongClgMainViewPresentor
