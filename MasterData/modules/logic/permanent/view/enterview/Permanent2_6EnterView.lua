-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_6EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_6EnterView", package.seeall)

local Permanent2_6EnterView = class("Permanent2_6EnterView", BaseView)

function Permanent2_6EnterView:onInitView()
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Play")
	self._goDungeonReddot3 = gohelper.findChild(self.viewGO, "Right/#go_Reddot3")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent2_6EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent2_6EnterView:_btnEntranceRole1OnClick()
	local actId = VersionActivity2_6Enum.ActivityId.Xugouji
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	XugoujiController.instance:openXugoujiLevelView()
end

function Permanent2_6EnterView:_btnEntranceRole2OnClick()
	local actId = VersionActivity2_6Enum.ActivityId.DiceHero
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	RoleActivityController.instance:enterActivity(actId)
end

function Permanent2_6EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_6EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_6EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent2_6EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent2_6EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.Xugouji)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.DiceHero)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId)
	end
end

function Permanent2_6EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent2_6EnterView
