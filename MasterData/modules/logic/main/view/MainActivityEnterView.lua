-- chunkname: @modules/logic/main/view/MainActivityEnterView.lua

module("modules.logic.main.view.MainActivityEnterView", package.seeall)

local MainActivityEnterView = class("MainActivityEnterView", BaseView)

function MainActivityEnterView:onInitView()
	self._goGuideFight = gohelper.findChild(self.viewGO, "right/go_fight/#go_guidefight")
	self._goActivityFight = gohelper.findChild(self.viewGO, "right/go_fight/#go_activityfight")
	self._goNormalFight = gohelper.findChild(self.viewGO, "right/go_fight/#go_normalfight")
	self.btnGuideFight = gohelper.findButtonWithAudio(self._goGuideFight)
	self.btnNormalFight = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/#go_normalfight/#btn_fight")
	self.btnJumpFight = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	self.btnActivityFight = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	self.btnEnterActivity = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/#go_activityfight/#btn_activefight")
	self.simageActivityIcon = gohelper.findChildSingleImage(self.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/icon")
	self.imageActivityIcon = self.simageActivityIcon:GetComponent(gohelper.Type_Image)
	self.goActivityRedDot = gohelper.findChild(self.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/#go_activityreddot")
	self.pckeyNormalFight1 = gohelper.findChild(self.btnNormalFight.gameObject, "1/#go_pcbtn")
	self.pckeyNormalFight2 = gohelper.findChild(self.btnNormalFight.gameObject, "2/#go_pcbtn")
	self.pckeyActivityFight = gohelper.findChild(self.btnEnterActivity.gameObject, "#go_pcbtn")
	self.pckeyEnterFight = gohelper.findChild(self.btnActivityFight.gameObject, "#go_pcbtn")
	self.pckeyJumpFight = gohelper.findChild(self.btnJumpFight.gameObject, "#go_pcbtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainActivityEnterView:addEvents()
	self.btnGuideFight:AddClickListener(self.btnGuideFightOnClick, self)
	self.btnNormalFight:AddClickListener(self.btnNormalFightOnClick, self)
	self.btnJumpFight:AddClickListener(self.btnJumpFightOnClick, self)
	self.btnActivityFight:AddClickListener(self.btnActivityFightOnClick, self)
	self.btnEnterActivity:AddClickListener(self.btnEnterActivityOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, self.OnNotifyEnterActivity, self)
end

function MainActivityEnterView:removeEvents()
	self.btnGuideFight:RemoveClickListener()
	self.btnNormalFight:RemoveClickListener()
	self.btnJumpFight:RemoveClickListener()
	self.btnActivityFight:RemoveClickListener()
	self.btnEnterActivity:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, self.OnNotifyEnterActivity, self)
end

MainActivityEnterView.ShowFightGroupEnum = {
	Normal = 2,
	Activity = 3,
	Guide = 1
}
MainActivityEnterView.notOpenColor = Color.New(0.32, 0.32, 0.32, 0.91)

function MainActivityEnterView:btnGuideFightOnClick()
	self:enterDungeonView()
end

function MainActivityEnterView:btnNormalFightOnClick()
	self:enterDungeonView()
end

function MainActivityEnterView:btnActivityFightOnClick()
	self:enterDungeonView()
end

function MainActivityEnterView:btnJumpFightOnClick()
	if self._jumpParam then
		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon(self._jumpParam)
	end
end

function MainActivityEnterView:enterDungeonView()
	TeachNoteModel.instance:setJumpEnter(false)

	local formMainView = true

	DungeonController.instance:enterDungeonView(true, formMainView)
end

function MainActivityEnterView:btnEnterActivityOnClick()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(self.showActivityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	local handleFunc = self:getActivityHandleFunc(self.showActivityId)

	if handleFunc then
		handleFunc(self)
	end
end

function MainActivityEnterView:OnNotifyEnterActivity()
	if self.showActivityId ~= nil then
		self:btnEnterActivityOnClick()
	end
end

function MainActivityEnterView:_editableInitView()
	gohelper.addUIClickAudio(self.btnGuideFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self.btnNormalFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self.btnActivityFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self.btnJumpFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self.btnEnterActivity.gameObject, AudioEnum.UI.play_ui_admission_open)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.refreshFastEnterDungeonUI, self)

	self.txtChapters = self:getUserDataTb_()

	for _, co in ipairs(lua_scene_ui.configList) do
		local skinId = co.id
		local name1 = string.format("right/go_fight/#go_normalfight/#btn_jumpfight/%s/#txt_chapter", skinId)
		local name2 = string.format("right/go_fight/#go_normalfight/#btn_jumpfight/%s/#txt_chaptername", skinId)
		local item = self:getUserDataTb_()

		item.txtChapter = gohelper.findChildText(self.viewGO, name1)
		item.txtChapterName = gohelper.findChildText(self.viewGO, name2)

		table.insert(self.txtChapters, item)
	end

	self._imageActivityIconChilds = self.imageActivityIcon.gameObject:GetComponentsInChildren(gohelper.Type_Image, true)
end

function MainActivityEnterView:onOpen()
	self:refreshUI()
end

function MainActivityEnterView:refreshUI()
	self:refreshShowFightGroupEnum()
	self:refreshFightBtnGroup()
	self:refreshRedDot()
	self:refreshFastEnterDungeonUI()
	self:refreshActivityIcon()
	self:showKeyTips()
end

function MainActivityEnterView:refreshShowFightGroupEnum()
	local isOpenFastDungeonBtn = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon)

	if not isOpenFastDungeonBtn then
		self.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Guide

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		self.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Normal

		return
	end

	for i = #ActivityEnum.VersionActivityIdList, 1, -1 do
		local activityId = ActivityEnum.VersionActivityIdList[i]
		local status = ActivityHelper.getActivityStatus(activityId)

		if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
			self.showActivityId = activityId
			self.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Activity

			return
		end
	end

	self.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Normal
end

function MainActivityEnterView:refreshFightBtnGroup()
	gohelper.setActive(self._goGuideFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Guide)
	gohelper.setActive(self._goNormalFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Normal)
	gohelper.setActive(self._goActivityFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Activity)
end

function MainActivityEnterView:refreshRedDot()
	if self.showFightGroupEnum ~= MainActivityEnterView.ShowFightGroupEnum.Activity then
		return
	end

	if self.addRedDotActivityId and self.addRedDotActivityId == self.showActivityId then
		return
	end

	RedDotController.instance:addRedDot(self.goActivityRedDot, RedDotEnum.DotNode.VersionActivityEnterRedDot, nil, self.activityRedDotRefreshFunc, self)

	self.addRedDotActivityId = self.showActivityId
end

function MainActivityEnterView:refreshFastEnterDungeonUI()
	if self.showFightGroupEnum ~= MainActivityEnterView.ShowFightGroupEnum.Normal then
		self._jumpParam = nil

		return
	end

	local config, _ = DungeonModel.instance:getLastEpisodeShowData()

	if config then
		local episodeId = config.id

		if episodeId == self._showEpisodeId then
			return
		end

		local chapterId = config.chapterId
		local chapterConfig = lua_chapter.configDict[chapterId]
		local episodeName = DungeonController.getEpisodeName(config)
		local chapterName = config.name

		for _, item in ipairs(self.txtChapters) do
			if item.txtChapter then
				item.txtChapter.text = episodeName
			end

			if item.txtChapterName then
				item.txtChapterName.text = chapterName
			end
		end

		self._jumpParam = self._jumpParam or {}
		self._jumpParam.chapterType = chapterConfig.type
		self._jumpParam.chapterId = chapterId
		self._jumpParam.episodeId = episodeId
		self._showEpisodeId = episodeId
	end
end

function MainActivityEnterView:activityRedDotRefreshFunc(redDotIcon)
	local enterViewActIdList = self:getEnterViewActIdList()

	if enterViewActIdList then
		local isHardModeNew = self:_isShowHardModeNewTag(enterViewActIdList)

		if ActivityStageHelper.checkActivityStageHasChange(enterViewActIdList) or isHardModeNew then
			redDotIcon.show = true

			redDotIcon:showRedDot(RedDotEnum.Style.ObliqueNewTag)
			redDotIcon:SetRedDotTrsWithType(RedDotEnum.Style.ObliqueNewTag, 40, -4.74)
			redDotIcon:setRedDotTranLocalRotation(RedDotEnum.Style.ObliqueNewTag, 0, 0, -9)

			return
		end
	else
		logWarn(string.format("not found enter actI : %s map actId list", self.showActivityId))
	end

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.5, 1.5)
	redDotIcon:defaultRefreshDot()
end

function MainActivityEnterView:_isShowHardModeNewTag(enterViewActIdList)
	if enterViewActIdList then
		for _, id in ipairs(enterViewActIdList) do
			if VersionActivityFixedDungeonModel.instance:isTipHardModeUnlockOpen(id) then
				return true
			end
		end
	end
end

function MainActivityEnterView:_showNewTag(redDotIcon)
	return
end

function MainActivityEnterView:getEnterViewActIdList()
	self.enterActId2ActIdListDict = self.enterActId2ActIdListDict or {
		[ActivityEnum.VersionActivityIdDict.Activity1_1] = VersionActivityEnum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_2] = VersionActivity1_2Enum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_3] = VersionActivity1_3Enum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_41] = VersionActivity1_4Enum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_42] = VersionActivity1_4Enum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_51] = VersionActivity1_5Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity1_51],
		[ActivityEnum.VersionActivityIdDict.Activity1_52] = VersionActivity1_5Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity1_51],
		[ActivityEnum.VersionActivityIdDict.Activity1_6] = VersionActivity1_6Enum.EnterViewActIdList,
		[ActivityEnum.VersionActivityIdDict.Activity1_7] = VersionActivity1_7Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity1_8] = VersionActivity1_8Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity1_9] = VersionActivity1_9Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity2_7] = VersionActivity2_7Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity2_8] = VersionActivity2_8Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_0] = VersionActivity3_0Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_1] = VersionActivity3_1Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_2] = VersionActivity3_2Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_3] = VersionActivity3_3Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_4] = VersionActivity3_4Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_5] = VersionActivity3_5Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_6] = VersionActivity3_6Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_7] = VersionActivity3_7Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_8] = VersionActivity3_8Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity3_9] = VersionActivity3_9Enum.EnterViewActIdListWithRedDot,
		[ActivityEnum.VersionActivityIdDict.Activity_Assassin_1] = VersionActivity2_9Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity_Assassin_1],
		[ActivityEnum.VersionActivityIdDict.Activity_Assassin_2] = VersionActivity2_9Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity_Assassin_2]
	}

	return self.enterActId2ActIdListDict[self.showActivityId]
end

function MainActivityEnterView:refreshActivityIcon()
	if self.showFightGroupEnum ~= MainActivityEnterView.ShowFightGroupEnum.Activity then
		return
	end

	self.simageActivityIcon:LoadImage(ResUrl.getMainActivityIcon(ActivityEnum.MainIcon[self.showActivityId]))

	local status = ActivityHelper.getActivityStatus(self.showActivityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		self.imageActivityIcon.color = MainActivityEnterView.notOpenColor

		gohelper.setAsFirstSibling(self.btnEnterActivity.gameObject)

		if self._imageActivityIconChilds then
			for i = 0, self._imageActivityIconChilds.Length - 1 do
				local image = self._imageActivityIconChilds[i]

				image.color = MainActivityEnterView.notOpenColor
			end
		end
	else
		self.imageActivityIcon.color = Color.white

		gohelper.setAsFirstSibling(self.btnEnterActivity.gameObject)

		if self._imageActivityIconChilds then
			for i = 0, self._imageActivityIconChilds.Length - 1 do
				local image = self._imageActivityIconChilds[i]

				image.color = Color.white
			end
		end
	end
end

function MainActivityEnterView:getActivityHandleFunc(activityId)
	self.activityHandleFuncDict = self.activityHandleFuncDict or {
		[ActivityEnum.VersionActivityIdDict.Activity1_1] = self.enterVersionActivity1_1,
		[ActivityEnum.VersionActivityIdDict.Activity1_2] = self.enterVersionActivity1_2,
		[ActivityEnum.VersionActivityIdDict.Activity1_3] = self.enterVersionActivity1_3,
		[ActivityEnum.VersionActivityIdDict.Activity1_41] = self.enterVersionActivity1_4,
		[ActivityEnum.VersionActivityIdDict.Activity1_42] = self.enterVersionActivity1_4,
		[ActivityEnum.VersionActivityIdDict.Activity1_51] = self.enterVersionActivity1_5,
		[ActivityEnum.VersionActivityIdDict.Activity1_52] = self.enterVersionActivity1_5,
		[ActivityEnum.VersionActivityIdDict.Activity1_6] = self.enterVersionActivity1_6,
		[ActivityEnum.VersionActivityIdDict.Activity1_7] = self.enterVersionActivity1_7
	}

	return self.activityHandleFuncDict[activityId] or self.commonEnterVersionActivity
end

function MainActivityEnterView:getActivityEnterHandleFunc(activityId)
	self._activityEnterHandleFuncDict = self._activityEnterHandleFuncDict or {
		[ActivityEnum.VersionActivityIdDict.Activity_sp02] = VersionActivity3_10EnterController.instance
	}

	return self._activityEnterHandleFuncDict[activityId]
end

function MainActivityEnterView:getCurEnterController()
	local controller = self:getActivityEnterHandleFunc(self.showActivityId)

	controller = controller or VersionActivityFixedHelper.getVersionActivityEnterController().instance

	return controller
end

function MainActivityEnterView:enterVersionActivity1_1()
	VersionActivityController.instance:openVersionActivityEnterView()
end

function MainActivityEnterView:enterVersionActivity1_2()
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()
end

function MainActivityEnterView:enterVersionActivity1_3()
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()
end

function MainActivityEnterView:enterVersionActivity1_4()
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()
end

function MainActivityEnterView:enterVersionActivity1_5()
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()
end

function MainActivityEnterView:enterVersionActivity1_6()
	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, nil, nil, true)
end

function MainActivityEnterView:enterVersionActivity1_7()
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()
end

function MainActivityEnterView:commonEnterVersionActivity()
	self:getCurEnterController():openVersionActivityEnterView()
end

function MainActivityEnterView:onRefreshActivityState()
	self:refreshUI()
end

function MainActivityEnterView:onUpdateDungeonInfo()
	self:refreshUI()
end

function MainActivityEnterView:onClose()
	return
end

function MainActivityEnterView:onDestroyView()
	self.simageActivityIcon:UnLoadImage()
end

function MainActivityEnterView:showKeyTips()
	PCInputController.instance:showkeyTips(self.pckeyActivityFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.activityCenter)
	PCInputController.instance:showkeyTips(self.pckeyEnterFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
	PCInputController.instance:showkeyTips(self.pckeyNormalFight1, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
	PCInputController.instance:showkeyTips(self.pckeyNormalFight2, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
end

return MainActivityEnterView
