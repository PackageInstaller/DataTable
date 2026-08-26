-- chunkname: @modules/logic/activity/view/show/ActivityClassShowView.lua

module("modules.logic.activity.view.show.ActivityClassShowView", package.seeall)

local ActivityClassShowView = class("ActivityClassShowView", BaseView)

function ActivityClassShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "title/#txt_desc")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/rewardPreview/#scroll_reward")
	self._gorewardContent = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityClassShowView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

function ActivityClassShowView:removeEvents()
	self._btnjump:RemoveClickListener()
end

ActivityClassShowView.ShowCount = 1
ActivityClassShowView.unlimitDay = 42

function ActivityClassShowView:_btnjumpOnClick()
	local episodeConfig = DungeonModel.instance:getLastEpisodeShowData()

	if not episodeConfig then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		local jumpParam = {}
		local chapterId = episodeConfig.chapterId
		local chapterConfig = lua_chapter.configDict[chapterId]

		jumpParam.chapterType = chapterConfig.type
		jumpParam.chapterId = chapterId
		jumpParam.episodeId = episodeConfig.id

		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon(jumpParam)
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function ActivityClassShowView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_class_bg"))
	gohelper.setActive(self._gorewarditem, false)
end

function ActivityClassShowView:onUpdateParam()
	return
end

function ActivityClassShowView:onOpen()
	local parentGO = self.viewParam.parent

	self._actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)

	self._rewardItems = self:getUserDataTb_()

	self:refreshUI()
end

function ActivityClassShowView:refreshUI()
	self._config = ActivityConfig.instance:getActivityShowTaskList(self._actId, 1)
	self._txtdesc.text = self._config.actDesc

	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txttime.text = day > ActivityClassShowView.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), day, hour)

	local rewards = string.split(self._config.showBonus, "|")

	for i = 1, #rewards do
		local rewardItem = self._rewardItems[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewarditem, self._gorewardContent, "rewarditem" .. i)
			rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.go)

			table.insert(self._rewardItems, rewardItem)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:isShowCount(itemCo[4] == ActivityClassShowView.ShowCount)
		self._rewardItems[i].item:setCountFontSize(56)
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		self._rewardItems[i].item:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go, false)
	end
end

function ActivityClassShowView:_onOpenViewFinish(viewName)
	if viewName == ViewName.DungeonMapView then
		TeachNoteController.instance:enterTeachNoteView(nil, false)
		ViewMgr.instance:closeView(ViewName.ActivityWelfareView, true)
	end
end

function ActivityClassShowView:onClose()
	return
end

function ActivityClassShowView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return ActivityClassShowView
