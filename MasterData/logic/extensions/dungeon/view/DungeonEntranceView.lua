-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEntranceView.lua

module("logic.extensions.dungeon.view.DungeonEntranceView", package.seeall)

local M = class("DungeonEntranceView", ViewComponent)
local SYSTEM_OPEN_ENUMS = {
	GameEnum.SystemEnum.MatFightActivity,
	GameEnum.SystemEnum.ClimbTowerActivity,
	GameEnum.SystemEnum.TeachFightActivity,
	GameEnum.SystemEnum.RunGroupActivity,
	GameEnum.SystemEnum.EquipFightActivity,
	GameEnum.SystemEnum.MainLine
}
local AniState = {
	[1] = "_secret",
	[2] = "_normal"
}

function M:buildUI()
	local systemEnum = GameEnum.SystemEnum

	self._entryComps = {}

	local btnControlGo = self:getGo("fight_entry_view_302733677")

	self._entryComps[systemEnum.ControlAction] = {
		viewName = ViewName.ControlActionLogin,
		btn = self:getBtn("fight_entry_view_302733677"),
		imgDi = goutil.findChild(btnControlGo, "imgDi"),
		goLock = goutil.findChild(btnControlGo, "lock"),
		txtLock = goutil.findChildTextComponent(btnControlGo, "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(btnControlGo, "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(btnControlGo, "nameNormal"),
		nameSecret = goutil.findChild(btnControlGo, "nameSecret"),
		goTimeTips = goutil.findChild(btnControlGo, "timeTips"),
		txtTime = goutil.findChildComponent(btnControlGo, "timeTips/txtDec", UIComponentType.TextMeshProUGUI)
	}
	self._entryComps[systemEnum.MatFightActivity] = {
		viewName = ViewName.StableAreaEntryView,
		btn = self:getBtn("fight_entry_view_983257489"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_983257489"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_983257489"), "lock").gameObject,
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_983257489"), "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(self:getGo("fight_entry_view_983257489"), "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_983257489"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_983257489"), "nameSecret"),
		txtDesc = goutil.findChildComponent(self:getGo("fight_entry_view_983257489"), "txtDesc", UIComponentType.Text),
		sp = {
			txtCareer = goutil.findChild(self:getGo("fight_entry_view_983257489"), "Text1")
		}
	}
	self._entryComps[systemEnum.EquipFightActivity] = {
		viewName = ViewName.RedMistEntryView,
		btn = self:getBtn("fight_entry_view_1975808673"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_1975808673"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_1975808673"), "lock").gameObject,
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_1975808673"), "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(self:getGo("fight_entry_view_1975808673"), "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_1975808673"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_1975808673"), "nameSecret"),
		txtDesc = goutil.findChildComponent(self:getGo("fight_entry_view_1975808673"), "txtDesc", UIComponentType.Text)
	}
	self._entryComps[systemEnum.ClimbTowerActivity] = {
		viewName = ViewName.ClimbingTowerEntryView,
		btn = self:getBtn("fight_entry_view_446946760"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_446946760"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_446946760"), "lock").gameObject,
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_446946760"), "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(self:getGo("fight_entry_view_446946760"), "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_446946760"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_446946760"), "nameSecret"),
		sp = {
			txtProgess = self:getText("fight_entry_view_-744954293")
		}
	}
	self._entryComps[systemEnum.TeachFightActivity] = {
		viewName = ViewName.TeachingChapter,
		btn = self:getBtn("fight_entry_view_1861045551"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_1861045551"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_1861045551"), "lock").gameObject,
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_1861045551"), "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(self:getGo("fight_entry_view_1861045551"), "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_1861045551"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_1861045551"), "nameSecret"),
		txtDesc = goutil.findChildComponent(self:getGo("fight_entry_view_1861045551"), "txtDesc", UIComponentType.Text),
		sp = {
			txtProgress = self:getText("fight_entry_view_-747974726")
		}
	}
	self._entryComps[systemEnum.RunGroupActivity] = {
		viewName = ViewName.RogueFirstEntrance,
		btn = self:getBtn("fight_entry_view_376703456"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_376703456"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_376703456"), "lock").gameObject,
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_376703456"), "lock/Text1"),
		canvasGroupLock = goutil.findChildComponent(self:getGo("fight_entry_view_376703456"), "lock", ComponentType.CanvasGroup),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_376703456"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_376703456"), "nameSecret"),
		txtDesc = goutil.findChildComponent(self:getGo("fight_entry_view_376703456"), "txtDesc", UIComponentType.Text),
		sp = {
			txtProgress = self:getText("fight_entry_view_-729005796"),
			txtBackCount = goutil.findChildTextComponent(self:getGo("fight_entry_view_376703456"), "backCount/txtCount"),
			backCount = goutil.findChild(self:getGo("fight_entry_view_376703456"), "backCount")
		}
	}
	self._entryComps[systemEnum.MainLine] = {
		viewName = ViewName.MainlineDungeonView,
		btn = self:getBtn("fight_entry_view_1371363906"),
		imgDi = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "imgDi").gameObject,
		goLock = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "lock").gameObject,
		animLock = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "lock").gameObject:GetComponent(ComponentType.Animation),
		txtLock = goutil.findChildTextComponent(self:getGo("fight_entry_view_1371363906"), "lock/Text1"),
		nameNormal = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "nameNormal"),
		nameSecret = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "nameSecret"),
		txtEp = goutil.findChildTextComponent(self:getGo("fight_entry_view_1371363906"), "txtEp"),
		imagePart = goutil.findChildImageComponent(self:getGo("fight_entry_view_1371363906"), "ImagePart"),
		sp = {
			imgName = self:getUIComponent("fight_entry_view_-26659542", ComponentType.ImageLocalization)
		},
		btnCopy = UIComponentType.ButtonAdapter(goutil.findChild(self:getGo("fight_entry_view_1371363906"), "else_click"))
	}
	self._trClockHourNormal = goutil.findChildComponent(self.mainGO, "imgNormal/clock/shizhen", UIComponentType.RectTransform)
	self._trClockSecNormal = goutil.findChildComponent(self.mainGO, "imgNormal/clock/miaozhen", UIComponentType.RectTransform)
	self._trClockHourAirtight = goutil.findChildComponent(self.mainGO, "imgSecret/clock/shizhen", UIComponentType.RectTransform)
	self._trClockSecAirtight = goutil.findChildComponent(self.mainGO, "imgSecret/clock/miaozhen", UIComponentType.RectTransform)
	self._normalElse = {
		goutil.findChild(self:getGo("fight_entry_view_1975808673"), "nameNormal"),
		goutil.findChild(self:getGo("fight_entry_view_302733677"), "nameNormal"),
		goutil.findChild(self:getGo("fight_entry_view_557269436"), "nameNormal")
	}
	self._secretElse = {
		goutil.findChild(self:getGo("fight_entry_view_1975808673"), "nameSecret"),
		goutil.findChild(self:getGo("fight_entry_view_302733677"), "nameSecret"),
		goutil.findChild(self:getGo("fight_entry_view_557269436"), "nameSecret")
	}
	self._btnPre = self:getBtn("fight_entry_view_-1878830369")
	self._txtTypePre = goutil.findChildTextComponent(self._btnPre.gameObject, "Text1")
	self._txtIndexPre = goutil.findChildTextComponent(self._btnPre.gameObject, "Text2")
	self._leftContent = goutil.findChild(self.mainGO, "leftContent")
	self._scroll = goutil.findChild(self.mainGO, "entranceScroll"):GetComponent(UIComponentType.ScrollRect)
	self._particle = {
		goutil.findChild(self.mainGO, "imgNormal/yanwu"),
		goutil.findChild(self.mainGO, "imgNormal/UIParticle"),
		goutil.findChild(self.mainGO, "imgSecret/yanwu"),
		goutil.findChild(self.mainGO, "imgSecret/UIParticle")
	}
	self._mainlineGuideTip = goutil.findChild(self:getGo("fight_entry_view_1371363906"), "guide_circle")

	goutil.setActive(self._mainlineGuideTip, false)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))

	local btn_skill_bonusGo = goutil.findChild(self:getGo("fight_entry_view_1975808673"), "btn_skill_bonus")

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type5))
	goutil.setActive(self._btnSkillDown.gameObject, false)
end

function M:destroyUI()
	self._entryComps = nil
end

function M:bindEvents()
	for systemEnum, comps in pairs(self._entryComps) do
		comps.btn:AddClickListener(function()
			self:_onClickEntry(systemEnum)
		end, self)

		if comps.btnCopy then
			comps.btnCopy:AddClickListener(function()
				self:_onClickEntry(systemEnum)
			end, self)
		end
	end

	self._btnPre:AddClickListener(self._onClickBtnPre, self)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
end

function M:unbindEvents()
	for systemEnum, comps in pairs(self._entryComps or {}) do
		comps.btn:RemoveClickListener()

		if comps.btnCopy then
			comps.btnCopy:RemoveClickListener()
		end
	end

	self._btnPre:RemoveClickListener()
	self._btnSkillUp:RemoveClickListener()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
end

function M:_checkAirtightTime()
	local timeStatus = self:_updateClock()

	if timeStatus ~= self._isAirtightTime then
		self._isAirtightTime = timeStatus

		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("qiehuan" .. self:getAniState())
		self:showUnlock()
	end
end

function M:_updateClock()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo()
	local rotationHour = hour * -10 - 120
	local rotationSecond = second * 6 * -1
	local trHour = inAirtightTime and self._trClockHourAirtight or self._trClockHourNormal
	local trSec = inAirtightTime and self._trClockSecAirtight or self._trClockSecNormal

	Astral.TransformUtil.SetLocalRotation(trHour, 0, 0, rotationHour)
	Astral.TransformUtil.SetLocalRotation(trSec, 0, 0, rotationSecond)

	return inAirtightTime
end

function M:getAniState()
	local idx = self._isAirtightTime and 1 or 2

	return AniState[idx]
end

function M:onEnter()
	self._isAirtightTime = self:_updateClock()

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open" .. self:getAniState())
	self:setEvent(true)

	local chapterCfg = DungeonConfig.instance:getCfgMaterialChapter()

	self._chapterName = {}

	for _, cfg in ipairs(chapterCfg) do
		self._chapterName[cfg.chapterId] = cfg.name
	end

	RoguelikeAgent.instance:sendListTaskRequest()
	self:showUnlock()
	settimer(1, self._checkAirtightTime, self, true)

	for _, item in pairs(self._particle) do
		goutil.setActive(item, true)
	end

	self:_showMainlineAnim()

	self._clickEntry = false
	self._scroll.horizontalNormalizedPosition = 0
end

function M:onEnterFinished()
	self:_checkAnyTouch()
end

function M:onExit()
	self:setEvent(false)
	removetimer(self.showNextUnlockAnimation, self)
	removetimer(self._checkAirtightTime, self)
	self:_hideLongTimeTips()
end

function M:onExitFinished()
	return
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self.initLockStatus, self)
		GlobalDispatcher:addEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_GET_ALL_TASK, self._updateEntryRunGroup, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self.initLockStatus, self)
		GlobalDispatcher:removeEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_ALL_TASK, self._updateEntryRunGroup, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
	end
end

function M:_handleClimbingTowerDarkRoundChange(e)
	self:_updateEntryClimbingTower()
end

function M:_handleOnRodeoInfoChange(e)
	return
end

function M:_showMainlineAnim()
	local lockGO = self._entryComps[GameEnum.SystemEnum.MainLine].goLock

	if not DungeonMainLineChapterModel.instance:isFirstDungeonFinishGuide() then
		goutil.setActive(lockGO, true)

		local anim = self._entryComps[GameEnum.SystemEnum.MainLine].animLock

		AnimationUtils.ResetAnimation(anim, "fight_entry_view_lock_open")
		anim:Play("fight_entry_view_lock_open")
	else
		goutil.setActive(lockGO, false)
	end
end

function M:_setNameStatus(nameNormal, nameSecret, isOpen)
	goutil.setActive(nameNormal, not self._isAirtightTime)
	goutil.setActive(nameSecret, self._isAirtightTime)

	if not isOpen then
		nameNormal:GetComponent(ComponentType.CanvasGroup).alpha = 0.6
		nameSecret:GetComponent(ComponentType.CanvasGroup).alpha = 0.6
	end
end

function M:_updateEntryMatDungeon()
	local systemEnum = GameEnum.SystemEnum.MatFightActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum].sp

	if not unlock then
		goutil.setActive(comps.txtCareer, false)
	end
end

function M:_updateEntryClimbingTower()
	local systemEnum = GameEnum.SystemEnum.ClimbTowerActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local txtProgress = self._entryComps[systemEnum].sp.txtProgess

	goutil.setActive(txtProgress.gameObject, unlock)

	local progress

	if unlock then
		local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
		local darkRoundCO
		local show = darkRound > 0

		if show then
			darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)
		end

		if darkRoundCO == nil then
			show = false
		end

		if show and darkRoundCO:isExpired() then
			show = false
		end

		if show then
			local maxStorey = darkRoundCO:getDungeonCount()
			local clearCount = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)

			progress = string.format("重置本进度\n<size=30><color=#e2e2e2>%s/%s</color></size>", clearCount, maxStorey)
		end
	end

	txtProgress.text = progress
end

function M:_updateEntryTeach()
	local systemEnum = GameEnum.SystemEnum.TeachFightActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local txtProgress = self._entryComps[systemEnum].sp.txtProgress
	local progress

	if unlock then
		local cur = 0
		local max = 0
		local chapterList = DungeonTeachingChapterModel.instance:getAllChapter()

		for k, chapterMo in pairs(chapterList) do
			local dungeonIds = chapterMo:getDungeonIds()

			max = max + #dungeonIds
			cur = cur + chapterMo:getPassedDungeonCount()
		end

		progress = string.format("总进度\n<size=30><color=#e2e2e2>%.0f%%</color></size>", 100 * cur / max)
	end

	txtProgress.text = progress
end

function M:_updateEntryAirWorkShop()
	local systemEnum = GameEnum.SystemEnum.PvpFightActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum].sp
	local redPoint = self._entryComps[systemEnum].goRedPoint
	local curGrade, state

	if unlock and isOnline then
		curGrade = AirWorkShopChallengeModel.instance:getCurLvGradeStr()
		state = unlock and AirWorkShopChallengeModel.instance:getLvState() or nil
	end

	comps.txtCurGrade.text = curGrade

	goutil.setActive(comps.txtCurGrade.gameObject, unlock)

	if state then
		local changeLv = AirWorkShopEnum.LvStateNum[state] or 0

		goutil.setActive(comps.goMarkUp, changeLv > 0)
		goutil.setActive(comps.goMarkKeep, changeLv == 0)
		goutil.setActive(comps.goMarkDown, changeLv < 0)

		local changeLvStr = changeLv == 0 and "" or math.abs(changeLv)

		comps.txtChangeGrade.text = changeLvStr
	end

	goutil.setActive(comps.txtChangeGrade.gameObject, state)
	goutil.setActive(comps.goGradeRoot, unlock and isOnline)
end

function M:_updateEntryRunGroup()
	local systemEnum = GameEnum.SystemEnum.RunGroupActivity
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)

	goutil.setActive(self._entryComps[systemEnum].imgDi, unlock)
	goutil.setActive(self._entryComps[systemEnum].txtDesc.gameObject, unlock)
	goutil.setActive(self._entryComps[systemEnum].sp.backCount.gameObject, unlock)

	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local txtProgress = self._entryComps[systemEnum].sp.txtProgress
	local txtTime = self._entryComps[systemEnum].sp.txtBackCount
	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueWeekly)

	if not tabId then
		return
	end

	local curTaskList = TaskModel.instance:getTaskList(tabId)
	local progress

	if curTaskList then
		local cur = TaskUtil.getFinishCount(curTaskList)

		progress = unlock and lang("tip_r_task_weekly") .. string.format("\n<size=30><color=#e2e2e2>%s/%s</color></size>", cur, #curTaskList) or nil
	end

	txtProgress.text = progress

	local limitTaskTime = RogueTaskView:getWeekLastTime()
	local tabTime = TextFormatter.formatFullTime(limitTaskTime, true)

	txtTime.text = tabTime
end

function M:_updateEntryMainLine()
	local systemEnum = GameEnum.SystemEnum.MainLine
	local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
	local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)
	local comps = self._entryComps[systemEnum].sp
	local latestChapterMo = DungeonMainLineChapterModel.instance:getLatestUnlockChapterMo(DungeonEnum.Difficulty.Easy)
	local dungeonCO = latestChapterMo:getChapterCO()
	local partImgName = DungeonEnum.MainLinePartImg[dungeonCO.chapterId]

	goutil.setActive(self._entryComps[systemEnum].imagePart.gameObject, partImgName)

	if partImgName then
		IconLoader.setSprite(self._entryComps[systemEnum].imagePart, IconType.DynSpriteAtlas_Dungeon, partImgName)
	end

	self._entryComps[systemEnum].txtEp.text = "EP " .. string.format("%02d", dungeonCO.chapterId)

	comps.imgName:SetSprite(dungeonCO.chapterNameRes)

	local chapterInfo = {}
	local info = Astral.LocalStorage.Instance:GetString("mainline_record")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	if id ~= PlayerModel.instance:getId() or string.nilorempty(info) or not DungeonMainLineChapterModel.instance:checkLocalStorageLastLevelIlegal(info) then
		info = string.split(info, ",")
		chapterInfo.chapterId = tonumber(info[1])
		chapterInfo.dungeonIndex = tonumber(info[2])
		chapterInfo.difficulty = tonumber(info[3])
	else
		chapterInfo.chapterId = latestChapterMo:getChapterId()
		chapterInfo.dungeonIndex = latestChapterMo:getLastUnlockDungeonIndex()
		chapterInfo.difficulty = latestChapterMo:getChapterDifficulty()
	end

	DungeonMainLineChapterModel.instance:recordDungeonSceneChpaterInfo(chapterInfo)
end

function M:_updateEntryElse()
	for i = 1, #self._normalElse do
		goutil.setActive(self._normalElse[i], not self._isAirtightTime)
		goutil.setActive(self._secretElse[i], self._isAirtightTime)
	end
end

function M:showUnlock()
	self._curShowUnlockIndex = 1

	local systemOpenCO

	for systemEnum, comps in pairs(self._entryComps) do
		local unlock = SystemOpenFacade.instance:isOpen(systemEnum)
		local isOnline = SystemOpenModel.instance:getSystemIsOnline(systemEnum, true)

		goutil.setActive(comps.imgDi, unlock and isOnline)

		if comps.txtDesc then
			goutil.setActive(comps.txtDesc.gameObject, unlock and isOnline)
		end

		local lockDesc

		if not unlock then
			systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemEnum)

			if systemOpenCO and not string.nilorempty(systemOpenCO:getUnlockText()) then
				lockDesc = systemOpenCO:getUnlockText()
			end
		end

		if not isOnline then
			lockDesc = nil
		end

		if comps.txtLock then
			comps.txtLock.text = lockDesc
		end

		self:_setNameStatus(comps.nameNormal, comps.nameSecret, unlock and isOnline)
		goutil.setActive(comps.goLock, not unlock or not isOnline)

		if systemEnum == GameEnum.SystemEnum.ControlAction then
			local isIn = AirtightRoomController.instance:getIsInAirtightTime()
			local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

			goutil.setActive(comps.goTimeTips, not isIn and not inSpTime and ControlActionUtil.isGuideFinished())

			local nowTime = AirtightRoomModel.instance:getServerTime()
			local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()
			local timeStr = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "h")
			local langStr = lang("tip_controlaction_monitor_time1")

			if timeStr == "00" then
				timeStr = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "m")
				langStr = lang("tip_controlaction_monitor_time3")
			end

			comps.txtTime.text = string.format(langStr, timeStr)
		end
	end

	self:_updateEntryMatDungeon()
	self:_updateEntryClimbingTower()
	self:_updateEntryTeach()
	self:_updateEntryMainLine()
	self:_updateBtnLast()
	self:_updateEntryElse()
end

function M:_updateBtnLast()
	local recordCfg = Astral.LocalStorage.Instance:GetString("dungeon_latest_type")
	local id = Astral.LocalStorage.Instance:GetString("dungeon_latest_id")

	self._recordCfg = string.split(recordCfg, ",")

	if id ~= PlayerModel.instance:getId() or string.nilorempty(recordCfg) then
		goutil.setActive(self._leftContent, false)

		return
	else
		goutil.setActive(self._leftContent, true)
	end

	local recordId = tonumber(self._recordCfg[2])
	local recordIndex = self._recordCfg[3]

	if tonumber(self._recordCfg[1]) == 1 then
		local dungeonCfg = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(recordId)

		if not dungeonCfg then
			goutil.setActive(self._leftContent, false)

			return
		end

		self._txtTypePre.text = dungeonCfg.name
		self._txtIndexPre.text = recordIndex
	else
		self._txtTypePre.text = self._chapterName[recordId]
		self._txtIndexPre.text = string.format("%s", recordIndex)
	end
end

function M:_onClickBtnPre()
	local type = tonumber(self._recordCfg[1])
	local recordId = tonumber(self._recordCfg[2])
	local recordIndex = self._recordCfg[3]

	if type == 1 then
		local record = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local info = string.split(record, ",")
		local chapterInfo = {}

		chapterInfo.chapterId = tonumber(info[1])
		chapterInfo.dungeonIndex = tonumber(info[2])
		chapterInfo.difficulty = tonumber(info[3])
		chapterInfo.clickDungeon = true
		chapterInfo.needShowChapterSelect = true

		if not DungeonMainLineChapterModel.instance:checkLocalStorageLastLevelIlegal(record) then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
	elseif type == 2 then
		local info = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(tonumber(info))

		if not dungeonMo or not dungeonMo:getIsUnlock() then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(recordId, tonumber(recordIndex))
		ViewMgr.instance:open(ViewName.StableAreaChapterView)
	elseif type == 3 then
		local info = Astral.LocalStorage.Instance:GetString("dungeon_latest_info")
		local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(tonumber(info))

		if not dungeonMo or not dungeonMo:getIsUnlock() then
			FloatWordMgr.instance:show("跳转失败")

			return
		end

		DungeonEquipExploreChapterModel.instance:setClickChapterIdAndDungeonIndex(recordId, tonumber(info))
		ViewMgr.instance:open(ViewName.RedMistChapterView)
	end

	for _, item in pairs(self._particle) do
		goutil.setActive(item, false)
	end
end

function M:showEnterAnimation()
	if self._curShowUnlockIndex <= #SYSTEM_OPEN_ENUMS then
		local curSystemEnum = SYSTEM_OPEN_ENUMS[self._curShowUnlockIndex]
		local unlock = SystemOpenFacade.instance:isOpen(curSystemEnum)

		if unlock then
			settimer(0.3, self.showNextUnlockAnimation, self, false)
		else
			self:showNextUnlockAnimation()
		end
	end
end

function M:showNextUnlockAnimation()
	local curSystemEnum = SYSTEM_OPEN_ENUMS[self._curShowUnlockIndex]
	local unlock = SystemOpenFacade.instance:isOpen(curSystemEnum)
	local comps = self._entryComps[curSystemEnum]

	goutil.setActive(comps.goLock, not unlock)

	self._curShowUnlockIndex = self._curShowUnlockIndex + 1

	self:showEnterAnimation()
end

function M:initLockStatus()
	for systemEnum, comps in pairs(self._entryComps) do
		local unlock = SystemOpenFacade.instance:isOpen(systemEnum)

		goutil.setActive(comps.goLock, not unlock)

		if comps.canvasGroupLock then
			comps.canvasGroupLock.alpha = unlock and 0 or 1
		end
	end

	self:showUnlock()
end

function M:_onClickEntry(entrySystemEnum)
	if not SystemOpenFacade.instance:isOpen(entrySystemEnum, true) or self._clickEntry then
		return
	end

	if not SystemOpenModel.instance:getSystemIsOnline(entrySystemEnum, true) then
		FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

		return
	end

	self._clickEntry = true

	if entrySystemEnum == GameEnum.SystemEnum.MainLine then
		self:_onClickEntryMainline()
	elseif entrySystemEnum == GameEnum.SystemEnum.ControlAction and not ControlActionModel.instance:isShowLoginView() then
		ViewMgr.instance:open(ViewName.ControlAction)
	else
		local comps = self._entryComps[entrySystemEnum]

		ViewMgr.instance:open(comps.viewName)
	end

	for _, item in pairs(self._particle) do
		goutil.setActive(item, false)
	end
end

function M:_onClickEntryMainline()
	if DungeonMainLineChapterModel.instance:isLastUnlockChapterNeedShow() then
		ViewMgr.instance:open(ViewName.MainlineChapterSelectView)
	else
		local chapterInfo = DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo()

		chapterInfo.needShowChapterSelect = true

		DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterInfo)
	end
end

function M:_checkAnyTouch()
	if GuideController.instance:isGuiding() then
		return
	end

	self._longTimeTipsInfo = ConstConfig.instance:getNumValuesByKey("ShowBattleGuideTips")

	local hasPass = DungeonMainLineChapterModel.instance:hasDungeonPassed(self._longTimeTipsInfo[1])

	if not hasPass then
		self:_showLongTimeTips()
	end
end

function M:_showLongTimeTips()
	goutil.setActive(self._mainlineGuideTip, true)
end

function M:_hideLongTimeTips()
	goutil.setActive(self._mainlineGuideTip, false)
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type5

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M
