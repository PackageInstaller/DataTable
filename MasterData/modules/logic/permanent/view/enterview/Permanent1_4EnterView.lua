-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_4EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent1_4EnterView", package.seeall)

local Permanent1_4EnterView = class("Permanent1_4EnterView", BaseView)

function Permanent1_4EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Play")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	self._goReddot3 = gohelper.findChild(self.viewGO, "Right/#go_Reddot3")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent1_4EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
end

function Permanent1_4EnterView:_btnEntranceRole1OnClick()
	Activity130Controller.instance:enterActivity130()
end

function Permanent1_4EnterView:_btnEntranceRole2OnClick()
	Activity131Controller.instance:enterActivity131()
end

function Permanent1_4EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent1_4EnterView:_btnEntranceDungeonOnClick()
	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_5) then
		self:closeThis()
		DungeonController.instance:enterDungeonView(true, true)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_5), self.closeThis, self)
	end
end

function Permanent1_4EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent1_4EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent1_4EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role6)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId)
	end
end

function Permanent1_4EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent1_4EnterView
