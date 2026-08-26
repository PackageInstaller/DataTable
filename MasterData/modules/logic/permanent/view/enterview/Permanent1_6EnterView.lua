-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_6EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent1_6EnterView", package.seeall)

local Permanent1_6EnterView = class("Permanent1_6EnterView", BaseView)

function Permanent1_6EnterView:onInitView()
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

function Permanent1_6EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
end

function Permanent1_6EnterView:_btnEntranceRole1OnClick()
	ActQuNiangController.instance:enterActivity()
end

function Permanent1_6EnterView:_btnEntranceRole2OnClick()
	ActGeTianController.instance:enterActivity()
end

function Permanent1_6EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent1_6EnterView:_btnEntranceDungeonOnClick()
	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent1_6EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent1_6EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent1_6EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Role1)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Role2)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, VersionActivity1_6Enum.ActivityId.Role1)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, VersionActivity1_6Enum.ActivityId.Role2)
	end

	RedDotController.instance:addMultiRedDot(self._goReddot3, {
		{
			id = RedDotEnum.DotNode.V1a6DungeonTask
		},
		{
			id = RedDotEnum.DotNode.V1a6DungeonSkillPoint
		},
		{
			id = RedDotEnum.DotNode.V1a6DungeonBossReward
		}
	})
	self:modifyBgm()
end

function Permanent1_6EnterView:modifyBgm()
	local modifyBgmEpisodeId = DungeonEnum.ModifyBgmEpisodeId
	local pass = DungeonModel.instance:hasPassLevelAndStory(modifyBgmEpisodeId)

	if pass then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

function Permanent1_6EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent1_6EnterView
