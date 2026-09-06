-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerShopViewPresnetor.lua

module("logic.extensions.summontower.view.SummontowerShopViewPresnetor", package.seeall)

local SummontowerShopViewPresnetor = class("SummontowerShopViewPresnetor", ViewPresentor)

function SummontowerShopViewPresnetor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerShopViewPresnetor:dependWhatResources()
	return {
		"ui/views/summontower/summontowershopview.prefab"
	}
end

function SummontowerShopViewPresnetor:buildViews()
	return {
		SummontowerShopView.New()
	}
end

return SummontowerShopViewPresnetor
