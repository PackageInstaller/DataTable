-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotterySelectViewPresentor.lua

module("logic.extensions.petcardlottery.view.PetCardLotterySelectViewPresentor", package.seeall)

local PetCardLotterySelectViewPresentor = class("PetCardLotterySelectViewPresentor", ViewPresentor)

function PetCardLotterySelectViewPresentor:ctor()
	PetCardLotterySelectViewPresentor.super.ctor(self)
end

function PetCardLotterySelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetCardLotterySelectViewPresentor:dependWhatResources()
	return {
		"ui/views/petcardlottery/petcardlotteryselectview.prefab"
	}
end

function PetCardLotterySelectViewPresentor:buildViews()
	return {
		PetCardLotterySelectView.New()
	}
end

return PetCardLotterySelectViewPresentor
