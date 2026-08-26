-- chunkname: @modules/logic/permanent/view/enterview/Permanent3_1EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent3_1EnterView", package.seeall)

local Permanent3_1EnterView = class("Permanent3_1EnterView", BaseView)

function Permanent3_1EnterView:onInitView()
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

function Permanent3_1EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent3_1EnterView:_btnEntranceRole1OnClick()
	local actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	local config = ActivityConfig.instance:getActivityCo(actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		YeShuMeiController.instance:enterLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			YeShuMeiController.instance:enterLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				YeShuMeiController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function Permanent3_1EnterView:_btnEntranceRole2OnClick()
	local actId = VersionActivity3_1Enum.ActivityId.GaoSiNiao
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	local config = ActivityConfig.instance:getActivityCo(actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		GaoSiNiaoController.instance:enterLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			GaoSiNiaoController.instance:enterLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				GaoSiNiaoController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function Permanent3_1EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent3_1EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent3_1EnterView:_btnEntranceDungeonOnClick()
	VersionActivityFixedDungeonController.instance:openVersionActivityReactivityDungeonMapView(3, 1)
end

function Permanent3_1EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)

	self._gobg = gohelper.findChild(self.viewGO, "#simage_FullBG1")
	self._videoComp = VersionActivityVideoComp.get(self._gobg, self)
end

function Permanent3_1EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.YeShuMei)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.GaoSiNiao)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId)
	end
end

function Permanent3_1EnterView:onOpenFinish()
	self._videoPath = VersionActivity3_1Enum.EnterLoopVideoName

	self._videoComp:play(self._videoPath, true)
end

function Permanent3_1EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

function Permanent3_1EnterView:onDestroyView()
	self._videoComp:destroy()
end

return Permanent3_1EnterView
