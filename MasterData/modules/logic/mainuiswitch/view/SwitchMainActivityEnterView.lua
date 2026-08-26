-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainActivityEnterView.lua

module("modules.logic.mainuiswitch.view.SwitchMainActivityEnterView", package.seeall)

local SwitchMainActivityEnterView = class("SwitchMainActivityEnterView", BaseView)

function SwitchMainActivityEnterView:onInitView()
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
	self.pckeyNormalFight = gohelper.findChild(self.btnNormalFight.gameObject, "#go_pcbtn")
	self.pckeyActivityFight = gohelper.findChild(self.btnEnterActivity.gameObject, "#go_pcbtn")
	self.pckeyEnterFight = gohelper.findChild(self.btnActivityFight.gameObject, "#go_pcbtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SwitchMainActivityEnterView:addEvents()
	return
end

function SwitchMainActivityEnterView:removeEvents()
	return
end

function SwitchMainActivityEnterView:_editableInitView()
	self.txtChapters = self:getUserDataTb_()

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local name1 = string.format("right/go_fight/#go_normalfight/#btn_jumpfight/%s/#txt_chapter", skinId)
		local name2 = string.format("right/go_fight/#go_normalfight/#btn_jumpfight/%s/#txt_chaptername", skinId)
		local item = self:getUserDataTb_()

		item.txtChapter = gohelper.findChildText(self.viewGO, name1)
		item.txtChapterName = gohelper.findChildText(self.viewGO, name2)

		table.insert(self.txtChapters, item)
	end

	self._imageActivityIconChilds = self.imageActivityIcon.gameObject:GetComponentsInChildren(gohelper.Type_Image, true)
end

function SwitchMainActivityEnterView:onOpen()
	self:refreshUI()
end

function SwitchMainActivityEnterView:refreshUI()
	self:refreshShowFightGroupEnum()
	self:refreshFightBtnGroup()
	self:refreshFastEnterDungeonUI()
	self:refreshActivityIcon()
end

function SwitchMainActivityEnterView:refreshActivityIcon()
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

		gohelper.setAsLastSibling(self.btnEnterActivity.gameObject)

		if self._imageActivityIconChilds then
			for i = 0, self._imageActivityIconChilds.Length - 1 do
				local image = self._imageActivityIconChilds[i]

				image.color = Color.white
			end
		end
	end
end

function SwitchMainActivityEnterView:refreshFightBtnGroup()
	gohelper.setActive(self._goGuideFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Guide)
	gohelper.setActive(self._goNormalFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Normal)
	gohelper.setActive(self._goActivityFight, self.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Activity)
end

function SwitchMainActivityEnterView:refreshFastEnterDungeonUI()
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

		self._showEpisodeId = episodeId
	end
end

function SwitchMainActivityEnterView:refreshShowFightGroupEnum()
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

function SwitchMainActivityEnterView:onClose()
	return
end

function SwitchMainActivityEnterView:onDestroyView()
	self.simageActivityIcon:UnLoadImage()
end

return SwitchMainActivityEnterView
