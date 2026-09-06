-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryRuleViewPresentor.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryRuleViewPresentor", package.seeall)

local PetCardLotteryRuleViewPresentor = class("PetCardLotteryRuleViewPresentor", ViewPresentor)

function PetCardLotteryRuleViewPresentor:ctor()
	PetCardLotteryRuleViewPresentor.super.ctor(self)
end

function PetCardLotteryRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetCardLotteryRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/petcardlottery/petcardlotteryruleview.prefab"
	}
end

function PetCardLotteryRuleViewPresentor:buildViews()
	return {
		PetCardLotteryRuleView.New()
	}
end

return PetCardLotteryRuleViewPresentor
