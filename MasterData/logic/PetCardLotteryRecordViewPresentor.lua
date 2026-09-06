-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryRecordViewPresentor.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryRecordViewPresentor", package.seeall)

local PetCardLotteryRecordViewPresentor = class("PetCardLotteryRecordViewPresentor", ViewPresentor)

function PetCardLotteryRecordViewPresentor:ctor()
	PetCardLotteryRecordViewPresentor.super.ctor(self)
end

function PetCardLotteryRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetCardLotteryRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/petcardlottery/petcardlotteryrecordview.prefab"
	}
end

function PetCardLotteryRecordViewPresentor:buildViews()
	return {
		PetCardLotteryRecordView.New()
	}
end

return PetCardLotteryRecordViewPresentor
