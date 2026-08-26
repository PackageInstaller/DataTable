-- chunkname: @modules/logic/achievement/view/AchievementLevelView.lua

module("modules.logic.achievement.view.AchievementLevelView", package.seeall)

local AchievementLevelView = class("AchievementLevelView", BaseView)

function AchievementLevelView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "layout/#txt_desc")
	self._txtextradesc = gohelper.findChildText(self.viewGO, "layout/#txt_extradesc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._btnprev = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_prev")
	self._gocontainer = gohelper.findChild(self.viewGO, "#simage_bg/#go_container")
	self._txtpage = gohelper.findChildText(self.viewGO, "#txt_page")
	self._goTips = gohelper.findChild(self.viewGO, "layout/#go_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementLevelView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnprev:AddClickListener(self._btnprevOnClick, self)
end

function AchievementLevelView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnprev:RemoveClickListener()
end

function AchievementLevelView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_detailpanelbg"))
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	self._btnnextCanvasGroup = gohelper.onceAddComponent(self._btnnext.gameObject, typeof(UnityEngine.CanvasGroup))
	self._btnprevCanvasGroup = gohelper.onceAddComponent(self._btnprev.gameObject, typeof(UnityEngine.CanvasGroup))

	self:checkInitItems()

	self._txtTips = gohelper.findChildText(self.viewGO, "layout/#go_Tips/image_TipsBG/txt_Tips")
end

function AchievementLevelView:onDestroyView()
	NavigateMgr.instance:removeEscape(self.viewName)
	AchievementLevelController.instance:onCloseView()

	if self._items then
		for _, item in pairs(self._items) do
			item.icon:dispose()
		end

		self._items = nil
	end

	self._simagebg:UnLoadImage()
end

function AchievementLevelView:onOpen()
	local achievementId = self.viewParam.achievementId
	local achievementIds = self.viewParam.achievementIds

	AchievementLevelController.instance:onOpenView(achievementId, achievementIds)

	self._newTaskCache = {}

	self.addEventCb(self, AchievementLevelController.instance, AchievementEvent.LevelViewUpdated, self.refreshUI, self)
	self.addEventCb(self, AchievementController.instance, AchievementEvent.UpdateAchievements, self.refreshUI, self)
	self:refreshUI()
end

function AchievementLevelView:onClose()
	return
end

function AchievementLevelView:refreshUI()
	self:refreshInfo()
	self:refreshSelected()
end

AchievementLevelView.BtnNormalAlpha = 1
AchievementLevelView.BtnDisableAlpha = 0.3

function AchievementLevelView:refreshInfo()
	local taskCO = AchievementLevelModel.instance:getCurrentTask()

	if not taskCO then
		self._txtdesc.text = ""
		self._txtextradesc.text = ""

		logError("cannot find AchievementTaskConfig, achievementId = " .. tostring(AchievementLevelModel.instance:getAchievement()))

		return
	end

	self._txtdesc.text = taskCO.desc
	self._txtextradesc.text = taskCO.extraDesc

	local achievementCO = AchievementConfig.instance:getAchievement(taskCO.achievementId)

	if achievementCO then
		self._txtname.text = achievementCO.name

		self:updateUpGradeTipsVisible(taskCO.id, achievementCO.groupId)
	else
		self._txtname.text = ""
	end

	self._txtpage.text = string.format("%s/%s", AchievementLevelModel.instance:getCurPageIndex(), AchievementLevelModel.instance:getTotalPageCount())

	if AchievementLevelModel.instance:hasNext() then
		self._btnnextCanvasGroup.alpha = AchievementLevelView.BtnNormalAlpha or AchievementLevelView.BtnDisableAlpha
	end

	if AchievementLevelModel.instance:hasPrev() then
		self._btnprevCanvasGroup.alpha = AchievementLevelView.BtnNormalAlpha or AchievementLevelView.BtnDisableAlpha
	end
end

function AchievementLevelView:updateUpGradeTipsVisible(taskId, groupId)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	gohelper.setActive(self._goTips, (groupCfg and groupCfg.unLockAchievement == taskId or nil) and not AchievementModel.instance:isAchievementTaskFinished(taskId))

	self._txtTips.text = formatLuaLang("achievementlevelview_upgradetips", (groupCfg or nil) and (groupCfg.name or ""))
end

AchievementLevelView.UnFinishIconColor = "#4D4D4D"
AchievementLevelView.FinishIconColor = "#FFFFFF"

function AchievementLevelView:refreshSelected()
	local isLastTaskFinished = true

	for index, item in ipairs(self._items) do
		local taskCO = AchievementLevelModel.instance:getTaskByIndex(index)

		if taskCO then
			gohelper.setActive(item.go, true)
			item.icon:setData(taskCO)
			gohelper.setActive(item.goselect, taskCO == AchievementLevelModel.instance:getCurrentTask())

			local taskMO = AchievementModel.instance:getById(taskCO.id)
			local isTaskFinished = taskMO and taskMO.hasFinished

			gohelper.setActive(item.gounachieve, not isTaskFinished)
			gohelper.setActive(item.goachieve, isTaskFinished)
			gohelper.setActive(item.goarrow1, not isTaskFinished)
			gohelper.setActive(item.goarrow2, isTaskFinished)

			if not isTaskFinished then
				item.txtunachieve.text = self:getUnAchievementTip(taskMO, taskCO, isLastTaskFinished)
			else
				if taskMO.isNew then
					self._newTaskCache[taskMO.id] = true
				end

				if item.goarrow2Animator then
					local normalizedTime = self._newTaskCache[taskMO.id] and 0 or 1

					item.goarrow2Animator:Play("arrow_open", 0, normalizedTime)
				end
			end

			item.txttime.text = isTaskFinished and TimeUtil.localTime2ServerTimeString(taskMO.finishTime) or ""

			item.icon:setIconColor((isTaskFinished or nil) and (AchievementLevelView.FinishIconColor or AchievementLevelView.UnFinishIconColor))
			item.icon:setSelectIconVisible(false)

			isLastTaskFinished = isTaskFinished
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function AchievementLevelView:getUnAchievementTip(taskMO, taskCO, isLastTaskFinished)
	local tips = ""

	if isLastTaskFinished then
		if taskCO then
			if not taskCO.maxProgress then
				local taskMaxProgress = 0

				if taskMO then
					if not taskMO.progress then
						local taskCurProgress = 0
						local tag = {
							taskCurProgress,
							taskMaxProgress
						}

						tips = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementlevelview_taskprogress"), tag)
					end
				end
			end
		end
	else
		tips = luaLang("p_achievementlevelview_unget")
	end

	return tips
end

AchievementLevelView.MaxItemCount = 3

function AchievementLevelView:checkInitItems()
	if self._items then
		return
	end

	self._items = {}

	for i = 1, AchievementLevelView.MaxItemCount do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "#simage_bg/#go_container/#go_icon" .. tostring(i))
		item.goselect = gohelper.findChild(item.go, "go_select")
		item.goachieve = gohelper.findChild(item.go, "go_achieve")
		item.txttime = gohelper.findChildText(item.go, "go_achieve/txt_time")
		item.gounachieve = gohelper.findChild(item.go, "go_unachieve")
		item.txtunachieve = gohelper.findChildText(item.go, "go_unachieve/unachieve")
		item.goarrow1 = gohelper.findChild(item.go, "go_arrow/#go_arrow1")
		item.goarrow2 = gohelper.findChild(item.go, "go_arrow/#go_arrow2")
		item.goarrow2Animator = gohelper.onceAddComponent(item.goarrow2, gohelper.Type_Animator)

		local mainIconParent = gohelper.findChild(item.go, "go_pos")
		local goIcon = self:getResInst(AchievementEnum.MainIconPath, mainIconParent, "icon")

		item.icon = AchievementMainIcon.New()

		item.icon:init(goIcon)
		item.icon:setNameTxtVisible(false)
		item.icon:setClickCall(self.onClickIcon, self, i)

		self._items[i] = item
	end
end

function AchievementLevelView:onClickIcon(index)
	local taskCO = AchievementLevelModel.instance:getTaskByIndex(index)

	if taskCO then
		self._newTaskCache = {}

		AchievementLevelController.instance:selectTask(taskCO.id)
	end
end

function AchievementLevelView:_btncloseOnClick()
	self:closeThis()
end

function AchievementLevelView:_btnnextOnClick()
	self._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

function AchievementLevelView:_btnprevOnClick()
	self._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

return AchievementLevelView
