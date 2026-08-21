-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuBg.lua

local ModelTool = require("Entity/ModelTool")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ARHelper = require("Helper/ARHelper")
local ARAnimBtn = require("UI/Social/ARAnimBtn")
local Hero = require("Common/Object/Hero")
local ResSubpackage = require("ClientData/ResSubpackage")
local SubpackageHelper = require("Helper/SubpackageHelper")
local ResModelAnimChange = require("ClientData/ResModelAnimChange")
local GyroUtils = Framework.Device.GyroUtils
local ModelFactory = Framework.Entity.ModelFactory
local LoaderMode = Framework.Resource.LoaderMode
local strClassName = "MainMenuBg"
local MainMenuBg = Class(strClassName, UIControls.Window)
local GENTLE_STATE_IDLE = 1
local GENTLE_STATE_DANCE = 2
local COMBO_DELAY_TIME = 0.2
local COMBO_TRIGGER_COUNT = 3
local COMBO_CD = 2
local BUTTON_CLICK_CD = 0.1
local FREQ_NOTICE_CD = 1
local InteractBtn = Class("InteractBtn", UIControls.Button)

function InteractBtn:ctor(...)
	self:addEventClick(Slot(self._onClickInteract, self), BUTTON_CLICK_CD)

	self.actTimer = Timer.New(Slot(self._actTimerBeat, self), COMBO_DELAY_TIME)
	self.holdBtn = UIControls.Button(self, self.mPath .. "/BtnHold")

	self.holdBtn:addEventClick(self._onClickHold)

	self.bgBullet = UIControls.UIAni(self, self.mPath .. "/BgSubtitle")
	self.txtBullet = UIControls.Label(self, self.mPath .. "/BgSubtitle/Text")
end

function InteractBtn:clear(...)
	self.actTimer:Stop()

	self.actTimer = nil
end

function InteractBtn:setInteractModel(modelStage, modelIndex)
	self.interactStage = modelStage
	self.interactIndex = modelIndex
end

function InteractBtn:_onClickInteract(...)
	if self.inGentleMode then
		if self.mParent.gentleModeState == GENTLE_STATE_DANCE then
			return
		end

		self.mParent:selectHoldHero(self.interactIndex)
	end

	local nowTime = Time.time

	if self.lastComboTime and nowTime - self.lastComboTime < COMBO_CD then
		if not self.lastNoticeTime or nowTime - self.lastNoticeTime > FREQ_NOTICE_CD then
			MsgManager.notice(Lang.get(45488))

			self.lastNoticeTime = nowTime
		end

		return
	end

	if self:_judgeCombo(nowTime) then
		self:_interact("Click02")
		self.actTimer:Stop()
	else
		self.actTimer:Restart()
	end
end

function InteractBtn:_judgeCombo(nowTime)
	if not self.comboCount then
		self.comboCount = 0
	end

	if not self.lastClickTime then
		self.lastClickTime = nowTime
	end

	if nowTime - self.lastClickTime > COMBO_DELAY_TIME then
		self.comboCount = 1
	else
		self.comboCount = self.comboCount + 1
	end

	local comboThisTime = false

	if self.comboCount >= COMBO_TRIGGER_COUNT then
		comboThisTime = true
		self.comboCount = 0
	end

	self.lastClickTime = nowTime

	return comboThisTime
end

function InteractBtn:_actTimerBeat()
	self:_interact("Click01")
end

function InteractBtn:_interact(animName)
	if not self.interactStage or not self.interactIndex then
		return
	end

	if self.interactIndex then
		self:realPlayInteractAnim(animName)
		self:setBulletShow(animName)
	end
end

function InteractBtn:setBulletShow(animName)
	self.bgBullet:setVisible(false)

	local heroId

	if self.mParent.sortedHeros and self.mParent.sortedHeros[self.interactIndex] then
		heroId = self.mParent.showHeros[self.interactIndex].id
	end

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end

	if not heroId or not animName then
		return
	end

	local interactType

	if animName == "Click01" then
		interactType = Const.HERO_VOCAL_INTER_TYPE_SINGKE_CLICK
	elseif animName == "Click02" then
		interactType = Const.HERO_VOCAL_INTER_TYPE_MULTIPLE_CLICK
	elseif animName == "Special_idle" then
		interactType = Const.HERO_VOCAL_INTER_TYPE_BACK_HOME
	end

	local voiceId = ClientUtils.getHeroVoicelByInteractType(heroId, interactType)

	if voiceId then
		local state, desc = ClientUtils.checkCanShowVoCalBullet(voiceId)

		if state then
			self.bgBullet:setVisible(true)
			self.bgBullet:startAni("ShowSubtitle")
			self.txtBullet:setText(desc)

			local function closeBullet(...)
				self.bgBullet:startAni("HideSubtitle")
			end

			if not self.bulletCloseTimer then
				self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 4, 1)
			end

			self.bulletCloseTimer:Restart()
		end
	end
end

function InteractBtn:animModelLoaded(animName, modelInstID, baseId)
	if baseId then
		ModelTool.addBaseModel(modelInstID, baseId, 1, Const.HERO_BASE_TYPE.Main)
	end

	self:realPlayInteractAnim(animName, modelInstID)
end

function InteractBtn:realPlayInteractAnim(animName, modelInstID)
	if modelInstID then
		self.interactStage:playAnimByModelInsId(modelInstID, animName)
	else
		self.interactStage:playAnimByIndex(self.interactIndex, animName)
	end

	self.mParent:restartSpecialIdleTimer()

	self.lastComboTime = Time.time
	self.lastNoticeTime = self.lastComboTime
end

function InteractBtn:switchGentleMode(isIn)
	if isIn then
		-- block empty
	else
		self:holdBtnVisible(false)
	end

	self.inGentleMode = isIn
end

function InteractBtn:holdBtnVisible(isSelected)
	self.holdBtn:setVisible(isSelected)
end

function InteractBtn:_onClickHold()
	if not self.inGentleMode or not self.mParent.showHeros[self.interactIndex] then
		return
	end

	self:holdBtnVisible(false)
	self.mParent:hideHoldModel(self.interactIndex)

	local holdDlg = UIManager.getUI("homeBgHoldDlg", true)

	holdDlg:setHoldHero(self.mParent.showHeros[self.interactIndex])
	self.bgBullet:startAni("HideSubtitle")

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end
end

local DANCE_MAX_NUM = 5

function MainMenuBg:ctor(...)
	self._slotOfModelLoaded = Slot(self.onModelLoaded, self)

	self:initUI()
end

function MainMenuBg:initUI(...)
	self.imgScreen = UIControls.RawImage(self, "ModelViewport")
	self.stage = ModelStageManager.createUIModelStage(self, Const.MAIN_MENU_MODEL_STAGE)

	self:setupBg()

	self.nowShowHeroInfo = {}
	self._heroModelIDs = {}
	self.interactBtns = {}

	for idx = 1, 3 do
		local interact = InteractBtn(self, "ModelControlPanel/BtnAnchor" .. idx)

		interact:setInteractModel(self.stage, idx)

		self.interactBtns[idx] = interact
	end

	self:initGentleModelUI()
end

function MainMenuBg:destroy(...)
	for _, interact in pairs(self.interactBtns) do
		interact:clear()
	end

	self:stopSpecialIdleTimer()
	self:clearBulletShow()
	MainMenuBg.super.destroy(self)
end

function MainMenuBg:onOpen(...)
	MainMenuBg.super.onOpen(self)
	self:switchGentleMode(false, true)
end

function MainMenuBg:onVisibleChanged(visible)
	MainMenuBg.super.onVisibleChanged(self, visible)
	self:setGyroActive(visible)
end

function MainMenuBg:setupBg()
	local bgInfo = UIConst.getBgChangeInfo("main")

	if bgInfo then
		if bgInfo.prefab_path and self.stage then
			self.stage:showModelByModelData(bgInfo.prefab_path, nil, nil, nil, nil, 1000, nil, true)
		end

		if bgInfo.change_bgm then
			CueManager.setBaseBGM(bgInfo.change_bgm)

			self.bgmChanged = true

			self:playLogicBGM(bgInfo.change_bgm)
		end
	end
end

function MainMenuBg:setGyroActive(enabled)
	if self.stage then
		local camera = self.stage:getCamera()

		if camera then
			local gameObject = camera.gameObject

			if gameObject then
				if enabled then
					GyroUtils.AddActorOnGameObject(gameObject, 1, 1, 0.3, 0.3)
					GyroUtils.SetMainMenuBehaviourParams(4, 4, 1, 1, 0.2, 0.2)
				else
					GyroUtils.SetActorActive(gameObject, false)
				end
			end
		end
	end
end

function MainMenuBg:onRefresh(...)
	if not self.conected then
		self.imgScreen:setVisible(true)
		self.stage:playCameraAnimator("main_initialcamera")
		self.stage:resetTimeline(0)
		self.stage:connectImage(self.imgScreen)

		self.conected = true
	end

	self:refreshModel()
end

function MainMenuBg:refreshModel()
	local heroIDs = {}
	local heros = {}

	self.unlockSpecialIndexs = {}

	if CurAvatar then
		local roleHeros = CurAvatar:getMyRoleInfoHeros()
		local showRoleHero = false

		if roleHeros and #roleHeros > 0 then
			showRoleHero = true

			for _, hero in ipairs(roleHeros) do
				table.insert(heros, hero)
			end
		else
			local heroGids = CurAvatar:getNowFormation()

			for gid, pos in pairs(heroGids) do
				local hero = CurAvatar.heroDic[gid]

				if hero then
					table.insert(heros, hero)
				end
			end

			local function sortHero(heroA, heroB)
				if heroA.star ~= heroB.star then
					return heroA.star > heroB.star
				elseif heroA.level ~= heroB.level then
					return heroA.level > heroB.level
				end

				return heroA.id < heroB.id
			end

			table.sort(heros, sortHero)
		end

		for i, hero in ipairs(heros) do
			table.insert(heroIDs, hero.id)

			if i < 4 and UIMiscConfig.HeroUnlockSpecialIdle(hero) then
				table.insert(self.unlockSpecialIndexs, i)
			end
		end

		if showRoleHero == false and next(heroIDs) == nil then
			heroIDs = ResHeroMisc[1].init_hero
		end
	end

	self.sortedHeros = heroIDs

	for pos = 1, 5 do
		self:setHero(pos, heroIDs[pos], heros[pos])
		self:checkAnimChange(self._heroModelIDs[pos], self.nowShowHeroInfo[pos].modelID, heros[pos])
	end

	self.showHeros = {}

	for i = 1, 3 do
		if #heros == 0 then
			if heroIDs[i] then
				local resid = heroIDs[i]

				for gid, hero in pairs(CurAvatar.heroDic) do
					if hero.id == resid then
						self.showHeros[i] = hero

						break
					end
				end
			end
		elseif heros[i] then
			self.showHeros[i] = heros[i]
		end
	end

	self:_checkAllModelLoaded()
	self:restartSpecialIdleTimer()
end

function MainMenuBg:setHero(tgtPos, heroID, hero)
	if tgtPos == nil then
		return
	end

	if heroID then
		hero = hero or BaseObject.GetObject(heroID)
	end

	local modelResID, baseId

	if hero then
		modelResID = hero:getShowModelId()
		baseId = hero:getShowBaseModelId()
	end

	local preModelResID = self.nowShowHeroInfo[tgtPos]

	if not preModelResID or preModelResID.modelID ~= modelResID or preModelResID.baseId ~= baseId then
		local modelID = self._heroModelIDs[tgtPos]

		if modelID then
			self.stage:delModel(modelID)
			self:clearAnimChange(modelID)
		end

		self.nowShowHeroInfo[tgtPos] = {}
		self.nowShowHeroInfo[tgtPos].modelID = modelResID
		self.nowShowHeroInfo[tgtPos].baseId = baseId

		if modelResID then
			local lodLv = Const.MODEL_LOD_LV1

			if tgtPos > 3 then
				lodLv = Const.MODEL_LOD_LV2
			end

			self._heroModelIDs[tgtPos] = self.stage:showHeroByModId(modelResID, Const.MODEL_TYPE.ShowMain, tgtPos, self._slotOfModelLoaded, lodLv, baseId)
		end

		if ClientUtils.hasSkinShowState(modelResID) and tgtPos <= 3 then
			self.nowShowHeroInfo[tgtPos].skinMode = true
			self.nowShowHeroInfo[tgtPos].showSkin = true
		end
	end
end

function MainMenuBg:onModelLoaded(modelInstID, baseId)
	if baseId then
		ModelTool.addBaseModel(modelInstID, baseId, 1, Const.HERO_BASE_TYPE.Main)
	end

	self:_checkAllModelLoaded()

	for i = 4, 5 do
		if self._heroModelIDs[i] == modelInstID then
			local modelAux = self.stage:getModel(modelInstID)

			if modelAux then
				modelAux:SetMaterialKeyword("CUSTOM_AMBIENT", false)
			end
		end
	end
end

function MainMenuBg:checkAnimChange(modelInsId, modelResID, hero)
	if not ResModelAnimChange[modelResID] then
		return
	end

	local changeDict = {}
	local hasChanged = false

	for reason, changeData in pairs(ResModelAnimChange[modelResID]) do
		if reason == 1 and hero and hero.star >= 9 then
			changeDict[changeData.src_name] = changeData.tgt_anim
			hasChanged = true
		end
	end

	if hasChanged then
		ModelTool.changeModelAnim(modelInsId, changeDict)
	else
		ModelTool.clearModelAnim(modelInsId)
	end
end

function MainMenuBg:clearAnimChange(modelInsId)
	ModelTool.clearModelAnim(modelInsId)
end

function MainMenuBg:_checkAllModelLoaded()
	local allLoaded = true

	for posIdx, _ in ipairs(self.sortedHeros) do
		local modelInsId = self._heroModelIDs[posIdx]

		if not modelInsId then
			allLoaded = false

			break
		end

		local modelAux = self.stage:getModel(modelInsId)

		if not modelAux then
			allLoaded = false

			break
		end
	end

	if allLoaded then
		self:_onAllModelLoaded()
	end
end

function MainMenuBg:_onAllModelLoaded()
	local homeState = GameFsm.getState(Const.STATE_MAIN_HOME)

	if homeState and homeState.riskToHome then
		self:playWelcomeVocal()

		homeState.riskToHome = nil
	end
end

function MainMenuBg:restartSpecialIdleTimer()
	self:stopSpecialIdleTimer()

	if #self.unlockSpecialIndexs == 0 then
		return
	end

	self.specialIdleTimer = Timer.New(Slot(self.onSpecialIdleTimerBeat, self), math.random(UIMiscConfig.SPECIAL_SHOW_MIN_THRESHOLD, UIMiscConfig.SPECIAL_SHOW_MAX_THRESHOLD))

	self.specialIdleTimer:Start()
end

function MainMenuBg:onSpecialIdleTimerBeat()
	if self.inGentleMode then
		return
	end

	local unlockCount = #self.unlockSpecialIndexs
	local idx

	if unlockCount == 1 then
		idx = self.unlockSpecialIndexs[1]
	else
		idx = self.unlockSpecialIndexs[math.random(1, unlockCount)]
	end

	if idx <= 3 then
		self.stage:playAnimByIndex(idx, "Special_idle")
	end

	self:restartSpecialIdleTimer()
end

function MainMenuBg:stopSpecialIdleTimer(...)
	if self.specialIdleTimer then
		self.specialIdleTimer:Stop()

		self.specialIdleTimer = nil
	end
end

function MainMenuBg:playGoRiskVocal()
	if not self.sortedHeros or #self.sortedHeros == 0 then
		return
	end

	local heroCount = math.min(#self.sortedHeros, 3)
	local heroId = self.sortedHeros[math.random(1, heroCount)]

	CueManager.stopVocal()
	CueManager.playHeroVocal(heroId, Const.HERO_VOCAL_RISK)
end

function MainMenuBg:playWelcomeVocal(...)
	if not self.sortedHeros or #self.sortedHeros == 0 then
		return
	end

	local heroCount = math.min(#self.sortedHeros, 3)
	local idx = math.random(1, heroCount)
	local heroId = self.sortedHeros[idx]

	CueManager.stopVocal()
	CueManager.playHeroVocal(heroId, Const.HERO_VOCAL_HOME)

	if idx <= 3 then
		self.stage:playAnimByIndex(idx, "Special_idle")

		if self.interactBtns[idx] then
			self.interactBtns[idx]:setBulletShow("Special_idle")
		end
	end

	self:restartSpecialIdleTimer()
end

function MainMenuBg:initGentleModelUI()
	self.gentleModeBlockBtn = UIControls.Button(self, "BtnOther")

	self.gentleModeBlockBtn:addEventClick(self._onClickGentleBlock)

	self.gentleModePanel = UIControls.Panel(self, "InteractPanel")
	self.gentleQuitBtn = UIControls.Button(self, "InteractPanel/BtnBack")

	self.gentleQuitBtn:addEventClick(self._onClickGentleQuit)

	self.gentleARBtn = UIControls.Button(self, "InteractPanel/BtnAR")

	self.gentleARBtn:addEventClick(self._onClickGentleAR)

	self.miniGameBtn = UIControls.Button(self, "InteractPanel/BtnMiniGame")

	self.miniGameBtn:addEventClick(self._onClickMiniGame)
	self.miniGameBtn:setVisible(CurAvatar:miniGameEnable())

	self.miniGameIconNew = UIControls.RedDot(self, "InteractPanel/BtnMiniGame/IconNew")

	self.miniGameIconNew:addHint({
		UIConst.RD_HINT_MINI_GAME
	})

	self.sharePanel = ShareAchievePanel(self, "InteractPanel/SharePanel")

	self.sharePanel:setNoAwardInfo("homeBg")
	self.sharePanel:setShareVisible(true)

	self.dancePlayingPanel = UIControls.Panel(self, "InteractPanel/PlayingPanel")
	self.danceNameTxt = UIControls.Label(self, "InteractPanel/PlayingPanel/TextName")
	self.danceProgressSlider = UIControls.Slider(self, "InteractPanel/PlayingPanel/Slider")
	self.danceQuitBtn = UIControls.Button(self, "InteractPanel/PlayingPanel/BtnStop")

	self.danceQuitBtn:addEventClick(self._onClickQuitDance)

	self.dancePanel = UIControls.Panel(self, "InteractPanel/MoveModePanel")
	self.danceBtns = {}

	for index = 1, DANCE_MAX_NUM do
		local newBtn = ARAnimBtn(self, "InteractPanel/MoveModePanel", "System/AR/BtnMove")

		newBtn.danceMode = true

		table.insert(self.danceBtns, newBtn)
	end

	self._slotOfDanceModelLoaded = Slot(self._onDanceModelLoaded, self)
	self.btnSeason = UIControls.Button(self, "ModelControlPanel/BtnSeason")

	self.btnSeason:addEventClick(self.onBtnSeasonClick)
	self:_updateARBtn()
	self:refreSeasonPart()
end

function MainMenuBg:refreSeasonPart(...)
	local iconNew
	local root = UnityEngine.GameObject.Find("ModelStage_NewDisplayModelStage")

	if root then
		iconNew = root.transform:Find("ModelRoot/Anchor1000/IconNew")
		iconNew = iconNew and iconNew.gameObject
	end

	local activity = CurAvatar:getSeasonPlayActivity(true)

	if activity and not self.inGentleMode then
		self.btnSeason:setVisible(true)

		if iconNew then
			iconNew:SetActive(CurAvatar:checkSeasonPlayMainMenuBgRedDot())
		end
	else
		if iconNew then
			iconNew:SetActive(false)
		end

		self.btnSeason:setVisible(not self.inGentleMode)
	end
end

function MainMenuBg:onBtnSeasonClick()
	local activity = CurAvatar:getSeasonPlayActivity(true)

	if activity then
		local isConLimit, desc = activity:isInConditionLimit()

		if isConLimit then
			MsgManager.notice(desc)

			return
		end

		if activity:inCloseState() then
			MsgManager.notice(Lang.get(117169))

			return
		end

		CurAvatar:jumpToShowActivity(activity.actId)
	else
		MsgManager.notice(Lang.get(117169))
	end
end

function MainMenuBg:_updateARBtn()
	return
end

function MainMenuBg:switchGentleMode(isIn, skipOpenMainMenu)
	self.inGentleMode = isIn

	self.gentleModeBlockBtn:setVisible(isIn)
	self.gentleModePanel:setVisible(isIn)
	self:refreSeasonPart()

	for i, btn in ipairs(self.interactBtns) do
		btn:switchGentleMode(isIn)
	end

	if isIn then
		local mainMenu = UIManager.getUI("mainMenu", nil, false)

		if mainMenu then
			mainMenu:setVisible(false, false)
		end

		self.gentleModeState = GENTLE_STATE_IDLE

		self:initDanceBtns()
	else
		if self.gentleModeState == GENTLE_STATE_DANCE then
			self:stopDance()
		end

		self.gentleModeState = nil

		if not skipOpenMainMenu then
			UIManager.getUI("mainMenu", true)
		end
	end

	MsgManager.showMsgOnScreen(not isIn)
end

function MainMenuBg:selectHoldHero(idx)
	if not self.inGentleMode then
		return
	end

	for i, btn in ipairs(self.interactBtns) do
		if self.showHeros[i] then
			btn:holdBtnVisible(i == idx)
		else
			btn:holdBtnVisible(false)
		end
	end
end

local COMMON_DANCE_LIST = {
	7,
	8,
	9
}
local SPECIAL_DANCE_LIST = {
	10,
	11
}
local ResArActConfig = require("ClientData/ResArActConfig")
local ResCommonModel = require("ClientData/ResCommonModel")

function MainMenuBg:initDanceBtns()
	local allActKey = utils.deepcopy(COMMON_DANCE_LIST)

	self.hasActKey = {}

	for _, hero in ipairs(self.showHeros) do
		local modelId = hero:getShowModelId()
		local heroInfo = ResCommonModel[modelId]
		local heroDanceList = heroInfo.ar_dance_act

		if heroDanceList then
			for _, actId in ipairs(heroDanceList) do
				self.hasActKey[actId] = true

				local alreadyHas = false

				for _, danceId in ipairs(allActKey) do
					if danceId == actId then
						alreadyHas = true

						break
					end
				end

				if not alreadyHas then
					table.insert(allActKey, actId)
				end
			end
		end
	end

	table.sort(allActKey)

	for index, btn in ipairs(self.danceBtns) do
		local danceId = allActKey[index]

		if danceId then
			btn:setVisible(true)
			btn:setSelected(false)
			btn:setData(danceId, not self.hasActKey[danceId])
		else
			btn:setVisible(false)
		end
	end
end

function MainMenuBg:dance(danceId)
	if not self.inGentleMode then
		return
	end

	self.gentleModeState = GENTLE_STATE_DANCE

	self:selectHoldHero(-1)
	self.dancePanel:setVisible(false)
	self.dancePlayingPanel:setVisible(true)

	local danceInfo = ResArActConfig[danceId]

	if not danceInfo then
		return
	end

	self.danceNameTxt:setText(danceInfo.name)
	self.danceProgressSlider:setValue(0, 0, true)

	self.curDanceId = danceId

	self:_checkDanceLoaded()
end

function MainMenuBg:_realPlayDance()
	if not self.curDanceId then
		return
	end

	local danceInfo = ResArActConfig[self.curDanceId]

	if not danceInfo then
		return
	end

	local danceInfo = ResArActConfig[self.curDanceId]

	self.danceProgressSlider:setValue(1, danceInfo.dance_time)

	if danceInfo.dance_bgm then
		CueManager.stopBGM()
		CueManager.playAvgBGM(danceInfo.dance_bgm)
		CueManager.setBGMLoop(false)
	end

	for i, hero in ipairs(self.showHeros) do
		if self.posInDancing[i] then
			local id = hero.modelData.id
			local danceModelInsId = self.danceModelInsIds[i]
			local modelInsId = self._heroModelIDs[i]

			if danceModelInsId and modelInsId then
				self.stage:setModelVisible(modelInsId, false)
				self.stage:setModelVisible(danceModelInsId, true)
				ModelTool.restModelPosition(danceModelInsId, -0.02)
				self.stage:playAnimByModelInsId(danceModelInsId, danceInfo.ani_name)
			end
		else
			MsgManager.notice(string.format(Lang.get(30758), hero.name))
			self.stage:playAnimByIndex(i, "anim_12003_main_idle")
		end
	end

	self.curDanceId = nil
end

function MainMenuBg:stopDance()
	if self.gentleModeState ~= GENTLE_STATE_DANCE or not self.posInDancing then
		return
	end

	CueManager.stopAvgBGM()

	for i, hero in ipairs(self.showHeros) do
		if self.posInDancing[i] and self._heroModelIDs[i] and self.danceModelInsIds[i] then
			local danceModelInsId = self.danceModelInsIds[i]
			local modelInsId = self._heroModelIDs[i]

			self.stage:setModelVisible(modelInsId, true)
			self.stage:setModelVisible(danceModelInsId, false)
			self.stage:playAnimByIndex(i, "anim_12003_main_idle")
		end
	end

	self.posInDancing = nil
	self.gentleModeState = GENTLE_STATE_IDLE

	self.danceProgressSlider:setValue(0)
	self.dancePlayingPanel:setVisible(false)
	self.dancePanel:setVisible(true)

	for _, btn in ipairs(self.danceBtns) do
		btn:setSelected(false)
	end
end

function MainMenuBg:ensureDanceModel()
	for i, _ in pairs(self.posInDancing) do
		local hero = self.showHeros[i]
		local modelId = hero:getShowModelId()

		if self.danceModelIds[i] and self.danceModelIds[i] ~= modelId then
			local oldModelInsId = self.danceModelInsIds[i]

			if oldModelInsId then
				self.stage:delModel(oldModelInsId)
			end

			self.danceModelInsIds[i] = nil
		end

		self.danceModelIds[i] = modelId

		if not self.danceModelInsIds[i] then
			local modelResID = hero:getShowModelId()

			if modelResID then
				local lodLv = Const.MODEL_LOD_LV0
				local modelData = ModelTool.analyzeModelData({
					model_type = Const.MODEL_TYPE.ARAct,
					model_id = modelResID,
					use_lod = lodLv
				})
				local id = hero.modelData.id
				local heroInfo = ResCommonModel[id]
				local danceAnimator = heroInfo.dance_animator

				if danceAnimator then
					modelData.animator = "Animators/Home/" .. danceAnimator .. ".overrideController"
				end

				self.danceModelInsIds[i] = self.stage:showModelByModelDataDirect(modelData, i, self._slotOfDanceModelLoaded, lodLv)
			end
		end
	end

	self:_checkAllDanceModelLoaded()
end

function MainMenuBg:_onDanceModelLoaded(modelInstID, baseId)
	if not self:_checkAllDanceModelLoaded() and modelInstID then
		self.stage:setModelVisible(modelInstID, false)
	end
end

function MainMenuBg:_checkAllDanceModelLoaded()
	local allLoaded = true

	for posIdx, _ in pairs(self.posInDancing) do
		local modelInsId = self.danceModelInsIds[posIdx]

		if not modelInsId then
			allLoaded = false

			break
		end

		local modelAux = self.stage:getModel(modelInsId)

		if not modelAux then
			allLoaded = false

			break
		end
	end

	if allLoaded and self.curDanceId then
		self:_realPlayDance()
	end

	return allLoaded
end

function MainMenuBg:_checkDanceLoaded()
	if not self.curDanceId then
		return
	end

	if not self.danceModelInsIds then
		self.danceModelInsIds = {}
	end

	if not self.danceModelIds then
		self.danceModelIds = {}
	end

	self.posInDancing = {}

	for i, hero in ipairs(self.showHeros) do
		local modelId = hero:getShowModelId()
		local heroInfo = ResCommonModel[modelId]
		local hasAnim = false

		if heroInfo.ar_dance_act then
			for _, actId in ipairs(heroInfo.ar_dance_act) do
				if actId == self.curDanceId then
					hasAnim = true

					break
				end
			end
		end

		if hasAnim then
			self.posInDancing[i] = true
		end
	end

	local danceInfo = ResArActConfig[self.curDanceId]

	if not danceInfo then
		return
	end

	local jobName = self.curDanceId
	local downloadPaths = {}

	for i, hero in ipairs(self.showHeros) do
		if self.posInDancing[i] then
			local id = hero.modelData.id
			local match = "_lazy_" .. tostring(id) .. "_dance"

			jobName = jobName .. tostring(id)

			table.insert(downloadPaths, match)
		end
	end

	local allLoaded, subJob = SubpackageHelper.checkDownloadFileByMultiPath(jobName, downloadPaths)

	if not allLoaded then
		local desc = Lang.get(42729)

		SubpackageHelper.tryDownloadJob(subJob, Slot(self.ensureDanceModel, self), Slot(self.stopDance, self), desc)
	else
		self:ensureDanceModel()
	end
end

function MainMenuBg:onBtnActClick(sender)
	if not self.hasActKey[sender.arActId] then
		MsgManager.notice(Lang.get(31300))

		return
	end

	CueManager.stopAvgBGM()

	for i, btn in ipairs(self.danceBtns) do
		btn:setSelected(btn == sender)
	end

	self:clearBulletShow()
	self:dance(sender.arActId)
end

function MainMenuBg:_onClickQuitDance()
	if self.gentleModeState ~= GENTLE_STATE_DANCE then
		return
	end

	self:stopDance()
end

function MainMenuBg:_onClickGentleBlock(...)
	if self.gentleModeState == GENTLE_STATE_IDLE then
		self:selectHoldHero(-1)
	elseif self.gentleModeState == GENTLE_STATE_DANCE then
		-- block empty
	end
end

function MainMenuBg:_onClickGentleQuit()
	self:switchGentleMode(false)
end

function MainMenuBg:_onClickGentleAR()
	ARHelper.tryOpenARDlg(nil, true, self.showHeros)
	self:clearBulletShow()
end

function MainMenuBg:_onClickMiniGame()
	UIManager.getUI("miniGameMainDlg", true):setData()
end

function MainMenuBg:hideHoldModel(idx)
	self.stage:setModelVisible(self._heroModelIDs[idx], false)

	self.hideModelIdx = idx
end

function MainMenuBg:reshowHoldModel()
	if self.hideModelIdx then
		self.stage:setModelVisible(self._heroModelIDs[self.hideModelIdx], true)

		self.hideModelIdx = nil
	end

	self.stage:setLightHide(false)
end

function MainMenuBg:clearBulletShow(...)
	for index = 1, 3 do
		if self.interactBtns[index] and self.interactBtns[index].bulletCloseTimer then
			self.interactBtns[index].bulletCloseTimer:Stop()
		end

		if self.interactBtns[index].bgBullet then
			self.interactBtns[index].bgBullet:setVisible(false)
		end
	end
end

return MainMenuBg
