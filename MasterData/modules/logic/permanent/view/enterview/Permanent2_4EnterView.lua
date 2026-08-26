-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_4EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_4EnterView", package.seeall)

local Permanent2_4EnterView = class("Permanent2_4EnterView", BaseView)

function Permanent2_4EnterView:onInitView()
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnEntranceRole3 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole3/#btn_EntranceRole3")
	self._goReddot3 = gohelper.findChild(self.viewGO, "Left/EntranceRole3/#go_Reddot3")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Play")
	self._goDungeonReddot3 = gohelper.findChild(self.viewGO, "Right/#go_Reddot3")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent2_4EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnEntranceRole3, self._btnEntranceRole3OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent2_4EnterView:_btnEntranceRole1OnClick()
	local actId = VersionActivity2_4Enum.ActivityId.MusicGame
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	Activity179Rpc.instance:sendGet179InfosRequest(actId, function()
		RoleActivityController.instance:enterActivity(actId)
	end)
end

function Permanent2_4EnterView:_btnEntranceRole2OnClick()
	local actId = VersionActivity2_4Enum.ActivityId.Pinball
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	RoleActivityController.instance:enterActivity(actId)
end

function Permanent2_4EnterView:_btnEntranceRole3OnClick()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.WuErLiXi)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	WuErLiXiController.instance:enterLevelView()
end

function Permanent2_4EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_4EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_4EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent2_4EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent2_4EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.MusicGame)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, act2MO.id)
	end

	RedDotController.instance:addRedDot(self._goReddot3, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	Activity178Rpc.instance:sendGetAct178Info(VersionActivity2_4Enum.ActivityId.Pinball)
end

function Permanent2_4EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent2_4EnterView
