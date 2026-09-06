-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgDailyBuffViewPresentor.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgBuffViewPresentor", package.seeall)

local DivineMiyaClgBuffViewPresentor = class("DivineMiyaClgBuffViewPresentor", ViewPresentor)

function DivineMiyaClgBuffViewPresentor:ctor()
	DivineMiyaClgBuffViewPresentor.super.ctor(self)
end

function DivineMiyaClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineMiyaClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiyaclg/divinemiyaclgbuffview.prefab"
	}
end

function DivineMiyaClgBuffViewPresentor:buildViews()
	return {
		DivineMiyaClgDailyBuffView.New()
	}
end

return DivineMiyaClgBuffViewPresentor
