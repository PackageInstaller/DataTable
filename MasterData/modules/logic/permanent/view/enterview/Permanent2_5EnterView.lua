-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_5EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_5EnterView", package.seeall)

local Permanent2_5EnterView = class("Permanent2_5EnterView", BaseView)

function Permanent2_5EnterView:onInitView()
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

function Permanent2_5EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self, LuaEventSystem.Low)
end

function Permanent2_5EnterView:_btnEntranceRole1OnClick()
	local actId = VersionActivity2_5Enum.ActivityId.LiangYue
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	LiangYueController.instance:enterLevelView(actId)
	self:closeBgmLeadSinger()
end

function Permanent2_5EnterView:_btnEntranceRole2OnClick()
	local actId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	FeiLinShiDuoGameController.instance:enterEpisodeLevelView(actId)

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_5Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function Permanent2_5EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_5EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_5EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView()
	self:closeBgmLeadSinger()
end

function Permanent2_5EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_5Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent2_5EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity2_5Enum.ActivityId.LiangYue)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity2_5Enum.ActivityId.FeiLinShiDuo)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, act2MO.id)
	end

	self:openBgmLeadSinger()
end

function Permanent2_5EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

function Permanent2_5EnterView:_onCloseView(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(VersionActivity2_5Enum.ActivityId.Dungeon)

		if AudioBgmManager.instance:getCurPlayingId() ~= bgmId then
			AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_5Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
		end

		self:openBgmLeadSinger()
	end
end

function Permanent2_5EnterView:_setAudioSwitchId()
	self.switchGroupId = self.switchGroupId or AudioMgr.instance:getIdFromString("music_vocal_filter")
	self.originalStateId = self.originalStateId or AudioMgr.instance:getIdFromString("original")
	self.accompanimentStateId = self.accompanimentStateId or AudioMgr.instance:getIdFromString("accompaniment")
end

function Permanent2_5EnterView:openBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.originalStateId)
end

function Permanent2_5EnterView:closeBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.accompanimentStateId)
end

return Permanent2_5EnterView
