-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldMainViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldMainViewPresentor", package.seeall)

local HolyDragonFieldMainViewPresentor = class("HolyDragonFieldMainViewPresentor", ViewPresentor)

function HolyDragonFieldMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonFieldMainViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldmainview.prefab"
	}
end

function HolyDragonFieldMainViewPresentor:buildViews()
	return {
		HolyDragonFieldMainView.New()
	}
end

return HolyDragonFieldMainViewPresentor
