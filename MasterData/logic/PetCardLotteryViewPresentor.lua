-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryViewPresentor.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryViewPresentor", package.seeall)

local PetCardLotteryViewPresentor = class("PetCardLotteryViewPresentor", ViewPresentor)

function PetCardLotteryViewPresentor:ctor()
	PetCardLotteryViewPresentor.super.ctor(self)
end

function PetCardLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetCardLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/petcardlottery/petcardlotteryview.prefab"
	}
end

function PetCardLotteryViewPresentor:buildViews()
	return {
		PetCardLotteryView.New()
	}
end

return PetCardLotteryViewPresentor
