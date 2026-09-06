-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalCpBuffViewPresentor.lua

module("logic.extensions.landlords.view.FalCpBuffViewPresentor", package.seeall)

local FalCpBuffViewPresentor = class("FalCpBuffViewPresentor", ViewPresentor)

function FalCpBuffViewPresentor:ctor()
	FalCpBuffViewPresentor.super.ctor(self)
end

function FalCpBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FalCpBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falcpbuffview.prefab"
	}
end

function FalCpBuffViewPresentor:buildViews()
	return {
		FalCpBuffView.New()
	}
end

return FalCpBuffViewPresentor
