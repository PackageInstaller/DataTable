-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentPanel.lua

local HeroContentBaseInfoPanel = require("UI/Hero/ContentPanel/HeroContentBaseInfoPanel")
local HeroContentEquipPanel = require("UI/Hero/ContentPanel/HeroContentEquipPanel")
local HeroStepUpPanel = require("UI/Hero/ContentPanel/HeroStepUpPanel")
local HeroCrystalAchievePanel = require("UI/Hero/ContentPanel/HeroCrystalAchievePanel")
local HeroContentStickPanel = require("UI/Hero/ContentPanel/HeroContentStickPanel")
local EventConst = require("EventConst")
local ResWindowMoneyConfig = require("ClientData/ResWindowMoneyConfig")
local ResHeroCrystalStory = require("ClientData/ResHeroCrystalStory")
local HERO_STAGE_CAMERA_LEFT = {
	10.54,
	11.87,
	109.95
}
local strClassName = "HeroContentPanel"
local HeroContentPanel = Class(strClassName, UIControls.Panel)
local HERO_CONTENT_MAP = {
	{
		prefabPath = "System/Hero/HeroContentBaseInfoPanel",
		btnName = "BtnBaseInfo",
		luaTable = HeroContentBaseInfoPanel
	},
	{
		prefabPath = "System/Hero/HeroContentEquipPanel",
		btnName = "BtnEquip",
		luaTable = HeroContentEquipPanel,
		redDotFunc = {
			"checkHeroCanEquipOrSeasonRelic"
		}
	},
	{
		prefabPath = "System/Hero/HeroStageUp2Panel",
		btnName = "BtnStageUp",
		luaTable = HeroStepUpPanel,
		redDotFunc = {
			"checkHeroCanStepUp",
			"checkHeroCanSweepTower",
			"checkHeroCanSweepTowerAndPowerEnough"
		}
	},
	{
		prefabPath = "System/Hero/HeroContentArchivePanel",
		visibleFunc = "checkHeroCrystalVisible",
		enableFunc = "checkHeroCrystalEnable",
		btnName = "BtnArchive",
		luaTable = HeroCrystalAchievePanel
	},
	{
		prefabPath = "System/Hero/HeroContentWaxPanel",
		enableFunc = "checkHeroStickEnable",
		visibleFunc = "checkHeroStickVisible",
		btnName = "BtnHeroWax",
		luaTable = HeroContentStickPanel,
		redDotFunc = {
			"checkHeroStickCanLvUpByHero"
		}
	}
}

function HeroContentPanel:ctor()
	self:initUI()
end

function HeroContentPanel:initUI()
	self.btnTypeList = {}
	self.imgNewList = {}
	self.panelList = {}

	for i, v in ipairs(HERO_CONTENT_MAP) do
		if HERO_CONTENT_MAP[i].redDotFunc then
			local imgNew = UIControls.Image(self, self.mPath .. "/TabPanel/" .. HERO_CONTENT_MAP[i].btnName .. "/IconNew")

			self.imgNewList[i] = imgNew
		end

		local btn = UIControls.Button(self, self.mPath .. "/TabPanel/" .. HERO_CONTENT_MAP[i].btnName)

		btn.idx = i

		btn:addEventClick(self.onBtnTypeClick)
		table.insert(self.btnTypeList, btn)
	end

	self.btnSkinEntry = UIControls.Button(self, self.mPath .. "/BtnSkinEntry", "Text")
	self.imgSkinBtn = UIControls.Image(self, self.mPath .. "/BtnSkinEntry/Img")
	self.imgNewSkin = UIControls.Panel(self, self.mPath .. "/BtnSkinEntry/IconNew")

	self.btnSkinEntry:addEventClick(self.onBtnSkinClick)

	self.slot4RefreshData = Slot(self.refreshPower, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
end

function HeroContentPanel:_checkBtnEnable()
	self.starUpUnlocked = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_STARUP)

	if self.starUpUnlocked and not self.hintStarUp then
		self.hintStarUp = UIControls.RedDot(self, self.mPath .. "/OtherFunPanel/BtnStarUp/IconNew")

		self.hintStarUp:addHint({
			UIConst.RD_HINT_HERO_STAR_UP
		})
	elseif not self.starUpUnlocked and self.hintStarUp then
		self.hintStarUp:delHint(UIConst.RD_HINT_HERO_STAR_UP)

		self.hintStarUp = nil
	end
end

function HeroContentPanel:selectTab(idx)
	self:onBtnTypeClick(self.btnTypeList[idx], true)
end

function HeroContentPanel:initSelectTab()
	if not self.curShowTab then
		self:selectTab(1)
	else
		self:selectTab(self.curShowTab)
	end
end

function HeroContentPanel:refreshContentPanel(heroGid)
	local lastGid = self.hero and self.hero.gid or "0"

	self.hero = heroGid and CurAvatar.heroDic[heroGid] or self.mWindow.selectedHero
	self.modelInsId = self.mWindow.curModelInsId

	local needrefreshScrollContentPos = self.hero.gid ~= lastGid
	local needSwitchPage = false

	for index, config in ipairs(HERO_CONTENT_MAP) do
		if config.visibleFunc then
			if self[config.visibleFunc](self) then
				self.btnTypeList[index]:setVisible(true)
			else
				self.btnTypeList[index]:setVisible(false)

				if self.panelList[index] and self.panelList[index]:getVisible() then
					needSwitchPage = true
				end
			end
		end

		if self.panelList[index] and self.panelList[index]:getVisible() and config.enableFunc and not self[config.enableFunc](self) then
			needSwitchPage = true
		end
	end

	if needSwitchPage then
		self:selectTab(1)
	else
		for k, v in pairs(self.panelList) do
			if self.panelList[k]:getVisible() then
				if k == Const.HERO_CONTENT_PANEL.STAGE_UP then
					if needrefreshScrollContentPos then
						self.panelList[k]:setHero(self.hero)
					else
						self.panelList[k]:setHero(self.hero, true)
					end
				else
					self.panelList[k]:setHero(self.hero)

					if self.timerRefreshHeroDlg then
						self.timerRefreshHeroDlg:Stop()

						self.timerRefreshHeroDlg = nil
					end
				end
			end
		end
	end

	self:refreshContentRedDot()
end

function HeroContentPanel:showStickEfx()
	for k, v in pairs(self.panelList) do
		if k == Const.HERO_CONTENT_PANEL.STICK and self.panelList[k]:getVisible() then
			self.panelList[k]:playLevelUpEfx()
		end
	end
end

function HeroContentPanel:refreshContentRedDot()
	for k, contentInfo in ipairs(HERO_CONTENT_MAP) do
		if contentInfo.redDotFunc then
			if k == Const.HERO_CONTENT_PANEL.STAGE_UP then
				local imgNewG = UIControls.Image(self, self.mPath .. "/TabPanel/" .. HERO_CONTENT_MAP[k].btnName .. "/IconNewG")

				self.imgNewList[k]:setVisible(CurAvatar[contentInfo.redDotFunc[1]](CurAvatar, self.hero))

				if not self.imgNewList[k]:getVisible() then
					self.imgNewList[k]:setVisible(CurAvatar[contentInfo.redDotFunc[3]](CurAvatar, self.hero))
				end

				imgNewG:setVisible(not self.imgNewList[k]:getVisible() and CurAvatar[contentInfo.redDotFunc[2]](CurAvatar, self.hero))
			else
				for _, func in ipairs(contentInfo.redDotFunc) do
					if CurAvatar[func](CurAvatar, self.hero) then
						self.imgNewList[k]:setVisible(true)

						break
					else
						self.imgNewList[k]:setVisible(false)
					end
				end
			end
		end
	end

	local newSkin = false

	if CurAvatar.canNewBaseUnlockDic[self.hero.gid] or CurAvatar.canNewSkinUnlockDic[self.hero.gid] then
		newSkin = true
	end

	self.imgNewSkin:setVisible(newSkin)
end

function HeroContentPanel:refreshPower(itemId)
	if itemId == Const.MONEY_ID_POWER then
		CurAvatar:refreshHeroDetail()
	end
end

function HeroContentPanel:onBtnTypeClick(sender, notResetModelStage)
	if not notResetModelStage then
		self.mWindow.modelStage:moveCameraSmooth(HERO_STAGE_CAMERA_LEFT, 0.5)
	end

	local config = HERO_CONTENT_MAP[sender.idx]
	local limitId = config.limitId

	if limitId then
		local isLocked = ConditionLimitManager.inLimitState(limitId)

		if isLocked then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(limitId))

			return
		end
	end

	if config.enableFunc then
		local enable, nInfo = self[config.enableFunc](self)

		if not enable then
			MsgManager.notice(nInfo)

			return
		end
	end

	for i, v in ipairs(self.btnTypeList) do
		if v == sender then
			if self.panelList[i] then
				self.panelList[i]:setVisible(true)
			else
				self.panelList[i] = HERO_CONTENT_MAP[i].luaTable(self, self.mPath, HERO_CONTENT_MAP[i].prefabPath, 0, 0, true)
			end

			self.curShowTab = i

			self.panelList[i]:setHero(self.hero or self.mWindow.selectedHero)

			if i == Const.HERO_CONTENT_PANEL.STAGE_UP then
				self.panelList[i].uiAni:startAni("ShowHeroStageUpWindow")

				self.panelList[i].showSkill = false

				self.mWindow.panelFund:settingFund({
					Const.MONEY_ID_GOLD,
					Const.MONEY_ID_POWER,
					Const.MONEY_ID_DIAMOND
				})
			else
				self.mWindow.btnHeroNext:setPosition(-160.2)

				if self.timerRefreshHeroDlg then
					self.timerRefreshHeroDlg:Stop()

					self.timerRefreshHeroDlg = nil
				end

				if ResWindowMoneyConfig[self.mWindow.mUIName] then
					self.mWindow.panelFund:settingFund(ResWindowMoneyConfig[self.mWindow.mUIName].moneys)
				end
			end

			if HERO_CONTENT_MAP[i].btnName == "BtnStageUp" then
				BeginnerManager.ShowHeroGrowPanel(self.hero or self.mWindow.selectedHero)
			end
		elseif self.panelList[i] then
			self.panelList[i]:setVisible(false)
		end

		v:setEnable(v ~= sender)
	end

	self.mWindow.passCheckCryFlag = nil

	self:refreshContentRedDot()
end

function HeroContentPanel:onBtnHandBookClick()
	JumpGuideManager.jump(Const.HANDBOOK_JUMP_HERO_ID, "", self.hero.id)
end

function HeroContentPanel:onBtnSkinClick()
	self.mWindow:showSkinPanel()
end

function HeroContentPanel:playSkillUpEfx(skillIdx)
	for k, contentInfo in ipairs(HERO_CONTENT_MAP) do
		if k == Const.HERO_CONTENT_PANEL.STAGE_UP and self.panelList[k]:getVisible() and self.panelList[k].cells[skillIdx] then
			local stepUpCell = self.panelList[k].cells[skillIdx]
			local isShowSkill = stepUpCell.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.SKILL
			local effectName = isShowSkill and "efx_ui_shaoguan_01.prefab" or "efx_ui_shaoguan_02.prefab"
			local effectPath = "Effects/UI/" .. effectName

			stepUpCell.skillPanel.panelSkillEfx:playEffectByPath(effectPath)
			stepUpCell.skillPanel.panelSkillEfx:setVisible(true)
			stepUpCell.skillPanel:setHero(self.hero, skillIdx)

			if skillIdx < self.hero:getMaxStep() and self.panelList[k].cells[skillIdx + 1] then
				self.panelList[k].cells[skillIdx + 1]:setHero(self.hero, skillIdx + 1)
			end

			if not self.showSkill then
				-- block empty
			end
		end
	end

	self.timerRefreshHeroDlg = Timer.New(Slot(self.refreshHeroDlg, self), 0.6, 1)

	self.timerRefreshHeroDlg:Restart()
end

function HeroContentPanel:delayPlaySkillUpEfx(skillIdx)
	self.timerDelayPlaySkillUpEfx = Timer.New(Functor(self.playSkillUpEfx, self, skillIdx), 0.4, 1)

	self.timerDelayPlaySkillUpEfx:Start()
end

function HeroContentPanel:refreshHeroDlg()
	CurAvatar:checkCanStepUpInTeamHeros()

	if self.curShowTab == Const.HERO_CONTENT_PANEL.STAGE_UP then
		CurAvatar:refreshHeroDetail(self.hero.gid)
	end
end

function HeroContentPanel:checkHeroCrystalVisible()
	return CurAvatar:isCrystalSecondPartNew() and Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE
end

function HeroContentPanel:checkHeroCrystalEnable()
	if self.hero and ResHeroCrystalStory[self.hero.id] then
		return true
	else
		return false, Lang.get(61550)
	end
end

function HeroContentPanel:checkHeroStickVisible()
	return CurAvatar:checkHasStick(self.hero.id)
end

function HeroContentPanel:checkHeroStickEnable()
	return true
end

function HeroContentPanel:onDlgDestroy()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
end

function HeroContentPanel:onPanelClose()
	for i, v in ipairs(self.btnTypeList) do
		if self.panelList[i] then
			self.panelList[i]:setVisible(false)
		end
	end
end

return HeroContentPanel
