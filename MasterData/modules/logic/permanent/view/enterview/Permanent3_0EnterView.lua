-- chunkname: @modules/logic/permanent/view/enterview/Permanent3_0EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent3_0EnterView", package.seeall)

local Permanent3_0EnterView = class("Permanent3_0EnterView", BaseView)

function Permanent3_0EnterView:onInitView()
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

function Permanent3_0EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent3_0EnterView:_btnEntranceRole1OnClick()
	local actId = VersionActivity3_0Enum.ActivityId.KaRong
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	local config = ActivityConfig.instance:getActivityCo(actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		RoleActivityController.instance:enterActivity(actId)
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			RoleActivityController.instance:enterActivity(actId)
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				RoleActivityController.instance:enterActivity(actId)
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function Permanent3_0EnterView:_btnEntranceRole2OnClick()
	local actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	local config = ActivityConfig.instance:getActivityCo(actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		Activity201MaLiAnNaController.instance:enterLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			Activity201MaLiAnNaController.instance:enterLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				Activity201MaLiAnNaController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function Permanent3_0EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent3_0EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent3_0EnterView:_btnEntranceDungeonOnClick()
	VersionActivity3_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent3_0EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent3_0EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.KaRong)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.MaLiAnNa)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId)
	end

	self:_playVideo()
end

function Permanent3_0EnterView:_playVideo()
	self._videoComp = VersionActivityVideoComp.get(gohelper.findChild(self.viewGO, "#simage_FullBG"), self)

	self._videoComp:play(VersionActivity3_0Enum.EnterLoopVideoName, true)
end

function Permanent3_0EnterView:onDestroyView()
	Permanent3_0EnterView.super.onDestroyView(self)
	self._videoComp:destroy()
end

function Permanent3_0EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent3_0EnterView
