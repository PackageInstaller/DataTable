-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DrawcardresultPresentor.lua

module("logic.extensions.lottery.view.DrawcardresultPresentor", package.seeall)

local DrawcardresultPresentor = class("DrawcardresultPresentor", ViewPresentor)

function DrawcardresultPresentor:ctor()
	DrawcardresultPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.StoryViewPriority
end

function DrawcardresultPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawcardresultPresentor:dependWhatResources()
	return {
		"ui/views/lottery/drawcardresultview.prefab"
	}
end

function DrawcardresultPresentor:buildViews()
	return {
		DrawcardresultView.New()
	}
end

function DrawcardresultPresentor:closeCallBack()
	LotteryController.instance:SetPetCurFaceList(nil)
	LotteryController.instance:SetPetRareList(nil)
end

return DrawcardresultPresentor
