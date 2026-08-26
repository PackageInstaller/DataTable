-- chunkname: @modules/logic/achievement/view/AchievementNamePlateLevelView.lua

module("modules.logic.achievement.view.AchievementNamePlateLevelView", package.seeall)

local AchievementNamePlateLevelView = class("AchievementNamePlateLevelView", BaseView)

AchievementNamePlateLevelView.BtnNormalAlpha = 1
AchievementNamePlateLevelView.BtnDisableAlpha = 0.3

function AchievementNamePlateLevelView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gocontainer = gohelper.findChild(self.viewGO, "#simage_bg/#go_container")
	self._txtpage = gohelper.findChildText(self.viewGO, "#txt_page")
	self._txtdesc = gohelper.findChildText(self.viewGO, "layout/#txt_desc")
	self._txtextradesc = gohelper.findChildText(self.viewGO, "layout/#txt_extradesc")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._btnprev = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_prev")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementNamePlateLevelView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnprev:AddClickListener(self._btnprevOnClick, self)
end

function AchievementNamePlateLevelView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnprev:RemoveClickListener()
end

function AchievementNamePlateLevelView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAchievementIcon("achievement_detailpanelbg"))
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	self._btnnextCanvasGroup = gohelper.onceAddComponent(self._btnnext.gameObject, typeof(UnityEngine.CanvasGroup))
	self._btnprevCanvasGroup = gohelper.onceAddComponent(self._btnprev.gameObject, typeof(UnityEngine.CanvasGroup))

	self:_initMainUI()

	self._txtTips = gohelper.findChildText(self.viewGO, "layout/#go_Tips/image_TipsBG/txt_Tips")
end

function AchievementNamePlateLevelView:_initMainUI()
	self.levelItemList = {}

	for i = 1, 3 do
		local item = {}

		item.go = gohelper.findChild(self._goIcon, "level" .. i)
		item.unlock = gohelper.findChild(item.go, "#go_UnLocked")
		item.lock = gohelper.findChild(item.go, "#go_Locked")
		item.gounlockbg = gohelper.findChild(item.unlock, "#simage_bg")
		item.simageunlocktitle = gohelper.findChildSingleImage(item.unlock, "#simage_title")
		item.txtunlocklevel = gohelper.findChildText(item.unlock, "#txt_level")
		item.simagelockbg = gohelper.findChildSingleImage(item.lock, "#simage_bg")
		item.simagelocktitle = gohelper.findChildSingleImage(item.lock, "#simage_title")
		item.txtlocklevel = gohelper.findChildText(item.lock, "#txt_level")

		gohelper.setActive(item.go, false)
		table.insert(self.levelItemList, item)
	end
end

function AchievementNamePlateLevelView:onDestroyView()
	NavigateMgr.instance:removeEscape(self.viewName)
	AchievementLevelController.instance:onCloseView()

	if self._items then
		for _, item in pairs(self._items) do
			if item.btnclick then
				item.btnclick:RemoveClickListener()
			end
		end

		self._items = nil
	end

	self._simagebg:UnLoadImage()
end

function AchievementNamePlateLevelView:onOpen()
	local achievementId = self.viewParam.achievementId
	local achievementIds = self.viewParam.achievementIds

	AchievementLevelController.instance:onOpenView(achievementId, achievementIds)

	self._newTaskCache = {}

	self.addEventCb(self, AchievementLevelController.instance, AchievementEvent.LevelViewUpdated, self.refreshUI, self)
	self.addEventCb(self, AchievementController.instance, AchievementEvent.UpdateAchievements, self.refreshUI, self)
	self:checkInitItems()
	self:refreshUI()
end

function AchievementNamePlateLevelView:onClose()
	return
end

function AchievementNamePlateLevelView:refreshUI()
	self:refreshInfo()
	self:refreshSelected()
	self:refreshMain()
end

function AchievementNamePlateLevelView:refreshInfo()
	local taskCO = AchievementLevelModel.instance:getCurrentTask()

	if not taskCO then
		self._txtdesc.text = ""
		self._txtextradesc.text = ""

		logError("cannot find AchievementTaskConfig, achievementId = " .. tostring(AchievementLevelModel.instance:getAchievement()))

		return
	end

	self._txtdesc.text = taskCO.desc
	self._txtextradesc.text = taskCO.extraDesc

	if AchievementLevelModel.instance:getCurPageIndex() and AchievementLevelModel.instance:getTotalPageCount() then
		self._txtpage.text = string.format("%s/%s", AchievementLevelModel.instance:getCurPageIndex(), AchievementLevelModel.instance:getTotalPageCount())
	else
		gohelper.setActive(self._txtpage.gameObject, false)
	end

	if AchievementLevelModel.instance:hasNext() then
		self._btnnextCanvasGroup.alpha = AchievementNamePlateLevelView.BtnNormalAlpha or AchievementNamePlateLevelView.BtnDisableAlpha
	end

	if AchievementLevelModel.instance:hasPrev() then
		self._btnprevCanvasGroup.alpha = AchievementNamePlateLevelView.BtnNormalAlpha or AchievementNamePlateLevelView.BtnDisableAlpha
	end
end

function AchievementNamePlateLevelView:refreshSelected()
	local isLastTaskFinished = true

	for index, item in ipairs(self._items) do
		local taskCO = AchievementLevelModel.instance:getTaskByIndex(index)

		if taskCO then
			gohelper.setActive(item.go, true)
			gohelper.setActive(item.goselect, taskCO == AchievementLevelModel.instance:getCurrentTask())

			local taskMO = AchievementModel.instance:getById(taskCO.id)
			local isTaskFinished = taskMO and taskMO.hasFinished

			gohelper.setActive(item.gounachieve, not isTaskFinished)
			gohelper.setActive(item.goachieve, isTaskFinished)
			gohelper.setActive(item.goarrow1, not isTaskFinished)
			gohelper.setActive(item.goarrow2, isTaskFinished)

			if not isTaskFinished then
				item.txtunachieve.text = self:getUnAchievementTip(taskCO, isLastTaskFinished)
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
			isLastTaskFinished = isTaskFinished
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function AchievementNamePlateLevelView:getUnAchievementTip(taskCO, isLastTaskFinished)
	local tips = ""

	if isLastTaskFinished then
		local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)
		local taskMaxProgress, taskCurProgress
		local listenerType = taskCO.listenerType
		local selfMaxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
		local num

		if listenerType and listenerType == "TowerPassLayer" then
			if taskCO.listenerParam and not string.nilorempty(taskCO.listenerParam) then
				local temp = string.split(taskCO.listenerParam, "#")

				num = temp and temp[3]
				num = num * 10
			end
		else
			num = taskCO and taskCO.maxProgress
		end

		taskMaxProgress = num
		taskCurProgress = num < selfMaxProgress and num or selfMaxProgress

		local tag = {
			taskCurProgress,
			taskMaxProgress
		}

		tips = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementlevelview_taskprogress"), tag)
	else
		tips = luaLang("p_achievementlevelview_unget")
	end

	return tips
end

function AchievementNamePlateLevelView:refreshMain()
	local index = AchievementLevelModel.instance:getCurrentSelectIndex()
	local taskCO = AchievementLevelModel.instance:getCurrentTask()
	local levelItem = self.levelItemList[index]
	local bgName, prefabName, titlebgName
	local taskMO = AchievementModel.instance:getById(taskCO.id)
	local taskHasFinished = taskMO and taskMO.hasFinished

	gohelper.setActive(levelItem.unlock, taskHasFinished)
	gohelper.setActive(levelItem.lock, not taskHasFinished)

	if taskCO.image and not string.nilorempty(taskCO.image) then
		local temp = string.split(taskCO.image, "#")

		prefabName = temp[1]
		titlebgName = temp[2]
		bgName = temp[3]
	end

	if taskHasFinished then
		local function callback()
			local go = levelItem._bgLoader:getInstGO()
		end

		levelItem._bgLoader = PrefabInstantiate.Create(levelItem.gounlockbg)

		levelItem._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(prefabName), callback, self)
		levelItem.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
	else
		levelItem.simagelockbg:LoadImage(ResUrl.getAchievementIcon(bgName))
		levelItem.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
	end

	local listenerType = taskCO.listenerType
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)
	local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
	local num

	if listenerType and listenerType == "TowerPassLayer" then
		if taskCO.listenerParam and not string.nilorempty(taskCO.listenerParam) then
			local temp = string.split(taskCO.listenerParam, "#")

			num = temp and temp[3]
			num = num * 10
		end
	else
		num = taskCO and taskCO.maxProgress
	end

	if taskHasFinished then
		levelItem.txtunlocklevel.text = num < maxProgress and maxProgress or num
		levelItem.txtlocklevel.text = num < maxProgress and maxProgress or num
	else
		levelItem.txtunlocklevel.text = num < maxProgress and num or maxProgress
		levelItem.txtlocklevel.text = num < maxProgress and num or maxProgress
	end

	for i, item in ipairs(self.levelItemList) do
		if index == i then
			gohelper.setActive(item.go, true)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

AchievementNamePlateLevelView.MaxItemCount = 3

function AchievementNamePlateLevelView:checkInitItems()
	if self._items then
		return
	end

	self._items = {}

	for i = 1, AchievementNamePlateLevelView.MaxItemCount do
		local item = self:getUserDataTb_()
		local taskCO = AchievementLevelModel.instance:getTaskByIndex(i)

		item.taskCO = taskCO
		item.go = gohelper.findChild(self.viewGO, "#simage_bg/#go_container/#go_icon" .. tostring(i))
		item.golevel = gohelper.findChild(item.go, "go_icon/level" .. i)
		item.unlock = gohelper.findChild(item.golevel, "#go_UnLocked")
		item.gounlockbg = gohelper.findChild(item.unlock, "#simage_bg")
		item.simageunlocktitle = gohelper.findChildSingleImage(item.unlock, "#simage_title")
		item.txtunlocklevel = gohelper.findChildText(item.unlock, "#txt_level")
		item.goselect = gohelper.findChild(item.go, "go_select")
		item.goachieve = gohelper.findChild(item.go, "go_achieve")
		item.txttime = gohelper.findChildText(item.go, "go_achieve/txt_time")
		item.gounachieve = gohelper.findChild(item.go, "go_unachieve")
		item.txtunachieve = gohelper.findChildText(item.go, "go_unachieve/unachieve")
		item.lock = gohelper.findChild(item.gounachieve, "#go_Locked")
		item.simagelockbg = gohelper.findChildSingleImage(item.lock, "#simage_bg")
		item.simagelocktitle = gohelper.findChildSingleImage(item.lock, "#simage_title")
		item.txtlocklevel = gohelper.findChildText(item.lock, "#txt_level")
		item.goarrow1 = gohelper.findChild(item.go, "go_arrow/#go_arrow1")
		item.goarrow2 = gohelper.findChild(item.go, "go_arrow/#go_arrow2")
		item.goarrow2Animator = gohelper.onceAddComponent(item.goarrow2, gohelper.Type_Animator)
		item.btnclick = gohelper.findChildButton(item.go, "#btn_click")

		item.btnclick:AddClickListener(self.onClickIcon, self, i)

		self._items[i] = item

		if taskCO then
			local bgName, titlebgName, prefabName

			if taskCO.image and not string.nilorempty(taskCO.image) then
				local temp = string.split(taskCO.image, "#")

				prefabName = temp[1]
				titlebgName = temp[2]
				bgName = temp[3]
			end

			local taskMO = AchievementModel.instance:getById(taskCO.id)
			local taskHasFinished = taskMO and taskMO.hasFinished

			gohelper.setActive(item.unlock, taskHasFinished)
			gohelper.setActive(item.lock, not taskHasFinished)

			if taskHasFinished then
				local function callback()
					local go = item._bgLoader:getInstGO()
				end

				item._bgLoader = PrefabInstantiate.Create(item.gounlockbg)

				item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(prefabName), callback, self)
				item.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
			else
				item.simagelockbg:LoadImage(ResUrl.getAchievementIcon(bgName))
				item.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
			end

			local listenerType = taskCO.listenerType
			local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)
			local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
			local num

			if listenerType and listenerType == "TowerPassLayer" then
				if taskCO.listenerParam and not string.nilorempty(taskCO.listenerParam) then
					local temp = string.split(taskCO.listenerParam, "#")

					num = temp and temp[3]
					num = num * 10
				end
			else
				num = taskCO and taskCO.maxProgress
			end

			if taskHasFinished then
				item.txtunlocklevel.text = num < maxProgress and maxProgress or num
				item.txtlocklevel.text = num < maxProgress and maxProgress or num
			else
				item.txtunlocklevel.text = num < maxProgress and num or maxProgress
				item.txtlocklevel.text = num < maxProgress and num or maxProgress
			end
		end
	end
end

function AchievementNamePlateLevelView:onClickIcon(index)
	local taskCO = AchievementLevelModel.instance:getTaskByIndex(index)

	if taskCO then
		self._newTaskCache = {}

		AchievementLevelController.instance:selectTask(taskCO.id)
	end
end

function AchievementNamePlateLevelView:_btncloseOnClick()
	self:closeThis()
end

function AchievementNamePlateLevelView:_btnnextOnClick()
	self._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

function AchievementNamePlateLevelView:_btnprevOnClick()
	self._newTaskCache = {}

	AchievementLevelController.instance:scrollTask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
end

return AchievementNamePlateLevelView
