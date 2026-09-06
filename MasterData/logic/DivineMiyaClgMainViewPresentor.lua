-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgMainViewPresentor.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgMainViewPresentor", package.seeall)

local DivineMiyaClgMainViewPresentor = class("DivineMiyaClgMainViewPresentor", ViewPresentor)

function DivineMiyaClgMainViewPresentor:ctor()
	DivineMiyaClgMainViewPresentor.super.ctor(self)
end

function DivineMiyaClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiyaClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiyaclg/divinemiyaclgmainview.prefab"
	}
end

function DivineMiyaClgMainViewPresentor:buildViews()
	return {
		DivineMiyaClgMainView.New()
	}
end

return DivineMiyaClgMainViewPresentor
