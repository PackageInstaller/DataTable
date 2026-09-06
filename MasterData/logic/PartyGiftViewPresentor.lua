-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyGiftViewPresentor.lua

module("logic.extensions.partysummary.view.PartyGiftViewPresentor", package.seeall)

local PartyGiftViewPresentor = class("PartyGiftViewPresentor", ViewWithGuidePresentor)

function PartyGiftViewPresentor:ctor()
	PartyGiftViewPresentor.super.ctor(self)
end

function PartyGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PartyGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/partysummary/partygiftview.prefab",
		"effect/prefabs/ui/20220930/0930shengzhupaidui/0930shengzhupaidui-ui_p.prefab"
	}
end

function PartyGiftViewPresentor:buildViews()
	return {
		PartyGiftView.New()
	}
end

return PartyGiftViewPresentor
