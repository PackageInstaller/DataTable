-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_2EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_2EnterView", package.seeall)

local Permanent2_2EnterView = class("Permanent2_2EnterView", BaseView)

function Permanent2_2EnterView:onInitView()
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

function Permanent2_2EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

local roleActId1 = VersionActivity2_2Enum.ActivityId.TianShiNaNa
local roleActId2 = VersionActivity2_2Enum.ActivityId.Lopera

function Permanent2_2EnterView:_btnEntranceRole1OnClick()
	Activity167Rpc.instance:sendGetAct167InfoRequest(roleActId1, function()
		RoleActivityController.instance:enterActivity(roleActId1)
	end)
end

function Permanent2_2EnterView:_btnEntranceRole2OnClick()
	Activity168Rpc.instance:sendGet168InfosRequest(roleActId2, function()
		RoleActivityController.instance:enterActivity(roleActId2)
	end)
end

function Permanent2_2EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_2EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_2EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_2DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent2_2EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent2_2EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(roleActId1)
	local act2MO = ActivityConfig.instance:getActivityCo(roleActId2)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, act2MO.id)
	end
end

function Permanent2_2EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent2_2EnterView
