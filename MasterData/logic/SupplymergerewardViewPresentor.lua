-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplymergerewardViewPresentor.lua

module("logic.extensions.strength.view.SupplymergerewardViewPresentor", package.seeall)

local SupplymergerewardViewPresentor = class("SupplymergerewardViewPresentor", ViewPresentor)

function SupplymergerewardViewPresentor:ctor()
	SupplymergerewardViewPresentor.super.ctor(self)
end

function SupplymergerewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SupplymergerewardViewPresentor:dependWhatResources()
	return {
		"ui/views/strength/supplymergerewardview.prefab"
	}
end

function SupplymergerewardViewPresentor:buildViews()
	return {
		SupplymergerewardView.New()
	}
end

return SupplymergerewardViewPresentor
