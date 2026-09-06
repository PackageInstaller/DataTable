-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgBuffViewPresentor.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgBuffViewPresentor", package.seeall)

local DivineMiZongClgBuffViewPresentor = class("DivineMiZongClgBuffViewPresentor", ViewPresentor)

function DivineMiZongClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineMiZongClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemizongclg/divinemizongclgbuffview.prefab"
	}
end

function DivineMiZongClgBuffViewPresentor:buildViews()
	return {
		DivineMiZongClgBuffView.New()
	}
end

return DivineMiZongClgBuffViewPresentor
