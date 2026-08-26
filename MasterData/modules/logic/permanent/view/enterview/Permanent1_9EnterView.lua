-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_9EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent1_9EnterView", package.seeall)

local Permanent1_9EnterView = class("Permanent1_9EnterView", BaseView)

function Permanent1_9EnterView:onInitView()
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "logo/#btn_Play")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent1_9EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent1_9EnterView:_btnEntranceRole1OnClick()
	RoleActivityController.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Lucy)
end

function Permanent1_9EnterView:_btnEntranceRole2OnClick()
	RoleActivityController.instance:enterActivity(VersionActivity1_9Enum.ActivityId.KaKaNia)
end

function Permanent1_9EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent1_9EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent1_9EnterView:_btnEntranceDungeonOnClick()
	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_7) then
		self:closeThis()

		local formMainView = true

		DungeonController.instance:enterDungeonView(true, formMainView)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_7), self.closeThis, self)
	end
end

function Permanent1_9EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)

	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_7) then
		self._simageBg:LoadImage("singlebg/reappear_mainactivity_singlebg/a9_reappear_mainactivity_fullbg2.png")
	else
		self._simageBg:LoadImage("singlebg/reappear_mainactivity_singlebg/a9_reappear_mainactivity_fullbg.png")
	end
end

function Permanent1_9EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.Lucy)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.KaKaNia)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, act2MO.id)
	end
end

function Permanent1_9EnterView:onClose()
	self._simageBg:UnLoadImage()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent1_9EnterView
