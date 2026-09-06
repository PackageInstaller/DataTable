-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerWishViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerWishViewPresentor", package.seeall)

local SummontowerWishViewPresentor = class("SummontowerWishViewPresentor", ViewPresentor)

function SummontowerWishViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerWishViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowwishview.prefab"
	}
end

function SummontowerWishViewPresentor:buildViews()
	return {
		SummontowerWishView.New()
	}
end

return SummontowerWishViewPresentor
