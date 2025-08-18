-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleMainBase.lua

local BattleBossBloodPart = require("UI/Battle/BattleBossBloodPart")
local BattleConst = require("Common/FrameBattle/BattleConst")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleKillComboChild = Class("BattleKillComboChild", UIControls.Child)

function BattleKillComboChild:ctor()
	self:initUI()
end

function BattleKillComboChild:initUI()
	self.imgBg = UIControls.Image(self, "Bg")
	self.imgKill = UIControls.Image(self, "IconKill")
	self.imgDesc = UIControls.Image(self, "IconDes")
	self.textNum = UIControls.Label(self, "NumPanel/TextNum")
end

function BattleKillComboChild:setData(killNum)
	self.textNum:setText(killNum)

	if killNum <= 4 then
		self.imgBg:setImage("Atlas/BattleAtlas/BattleKillAtlas", "BgKill" .. killNum)
		self.imgKill:setImage("Atlas/BattleAtlas/BattleKillAtlas", "IconKill" .. killNum)
		self.imgDesc:setImage("Atlas/BattleAtlas/BattleKillAtlas", "TxtKill" .. killNum)
		self:playAni("ShowBattleCombo", nil, true)
	else
		self.imgBg:setImage("Atlas/BattleAtlas/BattleKillAtlas", "BgKill5")
		self.imgKill:setImage("Atlas/BattleAtlas/BattleKillAtlas", "IconKill5")
		self.imgDesc:setImage("Atlas/BattleAtlas/BattleKillAtlas", "TxtKill5")
		self:playAni("ShowBattleComboMore", nil, true)
	end
end

local BattleDlgPetPanel = Class("BattleDlgPetPanel", UIControls.Panel)

function BattleDlgPetPanel:ctor()
	self:initUI()
end

function BattleDlgPetPanel:initUI()
	self.btnUsePetSkill = UIControls.Button(self, self.mPath)

	self.btnUsePetSkill:addEventClick(self.onUsePetSkillClick)

	self.panelEnergyDis = UIControls.Panel(self, self.mPath .. "/BarEnergyDis")
	self.imgProgress = UIControls.MaterialProgress(self, self.mPath .. "/BarEnergy/Fill")
	self.imgPet = UIControls.Image(self, self.mPath .. "/ImgPetHead")
	self.panelManaFull = UIControls.Panel(self, self.mPath .. "/EfxBtn")
	self.aniRelease = UIControls.UIAni(self, self.mPath .. "/ReleasePanel")

	self.aniRelease:addEventFinish(self.onReleaseAniOver)

	self.iconRelease1 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1")
	self.iconRelease2 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1/IconHero2")
	self.iconRelease3 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1/IconHero3")
end

function BattleDlgPetPanel:onUsePetSkillClick()
	if Const.BEGINNER_LOCK_SKILL then
		return
	end

	if not self.mParent.inManual then
		return
	end

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	if self.obj and self.obj.camp == BattleConst.CAMP_PLAYER then
		local state = GameFsm.getCurState()

		state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_USE_SKILL, self.entityId)
		self:setState(STATE_WAIT)
	end
end

function BattleDlgPetPanel:setData(petUnit)
	self.obj = petUnit
	self.entityId = petUnit.id
	self.camp = petUnit.camp

	self:setState(STATE_NORMAL)
	self:onSetMana(petUnit.mana, 100)

	local path = petUnit.pet:getIconPath()

	if path then
		self.imgPet:setImage(path[1], path[2])
		self.iconRelease1:setImage(path[1], path[2])
		self.iconRelease2:setImage(path[1], path[2])
		self.iconRelease3:setImage(path[1], path[2])
	end

	self.aniRelease:setVisible(false)
	self:attachListener()
end

function BattleDlgPetPanel:onSetMana(mana, maxMana, manaSpeed)
	if self.obj.isOver then
		return
	end

	if manaSpeed == nil then
		manaSpeed = self.obj.mana_gen
	end

	if maxMana <= mana or manaSpeed <= 0 then
		self.imgProgress:setValue(mana / maxMana)

		if maxMana <= mana and self.state == STATE_NORMAL and not self.obj:manualWaitingSkill() then
			self:setState(STATE_FULL)
		end

		if mana < maxMana and self.obj.mana_gen == 0 then
			self:setState(STATE_NORMAL)
		end
	else
		self.imgProgress:setValueEx(mana / maxMana, 1, (maxMana - mana) / manaSpeed)

		if self.state ~= STATE_NORMAL and self.state ~= STATE_DEAD then
			self:setState(STATE_NORMAL)
		end
	end
end

BattleDlgPetPanel.listenerFuncConfig = {
	onSkillEnd = BattleConst.MATRIX_EVENT_ENTITY_SKILL_END,
	SkillHide = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE,
	SkillBegin = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN,
	SkillHideCancel = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL,
	refreshCellMana = BattleConst.MATRIX_EVENT_ENTITY_SETMANA,
	onUseSkill = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN
}

function BattleDlgPetPanel:onUseSkill(skillID, skillType, cameraPrepare, cameraPrepareDuration, cardId)
	self.aniRelease:setVisible(true)
	self.aniRelease:startAni("BattleBtnPetRelease")
end

function BattleDlgPetPanel:onReleaseAniOver()
	self.aniRelease:setVisible(false)
end

function BattleDlgPetPanel:refreshState()
	self.panelManaFull:setVisible(self.state == STATE_FULL)
	self.btnUsePetSkill:setEnable(self.state == STATE_FULL)

	if self.state == STATE_DEAD then
		self.panelEnergyDis:setVisible(true)
		self.imgProgress:setValue(0)
	else
		self.panelEnergyDis:setVisible(false)
	end
end

function BattleDlgPetPanel:attachListener()
	EventCenter.addEventListenerGroup(self, self.listenerFuncConfig, self.entityId)
end

function BattleDlgPetPanel:detachListener()
	EventCenter.removeEventListenerGroup(self, self.listenerFuncConfig, self.entityId)
end

function BattleDlgPetPanel:clear()
	EventCenter.removeEventListenerGroup(self, self.listenerFuncConfig, self.entityId)

	self.obj = nil
	self.inSkillPause = false
end

function BattleDlgPetPanel:destroy()
	self:detachListener()
end

function BattleDlgPetPanel:clear()
	if self.obj then
		EventCenter.removeEventListenerGroup(self, self.listenerFuncConfig, self.entityId)

		self.obj = nil
	end

	self.inSkillPause = false
end

function BattleDlgPetPanel:SkillHide(skillSelf, targets)
	self.inSkillPause = true

	self:refreshCellMana()
end

function BattleDlgPetPanel:SkillHideCancel()
	self.inSkillPause = false

	self:refreshCellMana()
end

function BattleDlgPetPanel:refreshCellMana()
	if self.obj then
		if self.inSkillPause or self.mParent.actionEnd then
			self:onSetMana(self.obj.mana, 100, 0)
		else
			self:onSetMana(self.obj.mana, 100)
		end

		if self.obj.isOver then
			self:setState(STATE_DEAD)
		end
	end
end

function BattleDlgPetPanel:onSkillEnd()
	if self.obj.isOver then
		self:setState(STATE_DEAD)
	end
end

function BattleDlgPetPanel:onSelfReborn()
	self:setState(STATE_NORMAL)

	if self.obj then
		self.sliderHp:setValue(self.obj.hp / self.obj.mhp, 0.5, true)
		self:onSetMana(self.obj.mana, 100, 0)
	end
end

function BattleDlgPetPanel:setState(state)
	self.state = state

	self:refreshState()
end

local BattleDlgTargetCell = Class("BattleDlgTargetCell", UIControls.Panel)

function BattleDlgTargetCell:ctor()
	self:initUI()
end

function BattleDlgTargetCell:initUI()
	self.textTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.panelEnough = UIControls.Panel(self, self.mPath .. "/TargetWin")
	self.panelNotEnough = UIControls.Panel(self, self.mPath .. "/TargetLose")
	self.aniSelf = UIControls.UIAni(self, self.mPath)
end

function BattleDlgTargetCell:initData(oneTarget)
	self.textTitle:setText(oneTarget.desc or "")
end

function BattleDlgTargetCell:refreshState(stateDict, forceUpdate)
	local nowState = stateDict[1]

	if not forceUpdate and nowState == self.nowState then
		return false
	end

	self.nowState = nowState

	if self.nowState then
		self.panelEnough:setVisible(true)
		self.panelNotEnough:setVisible(false)
		self.aniSelf:startAni("TargetWin", true)
	elseif self.nowState == false then
		self.panelEnough:setVisible(false)
		self.panelNotEnough:setVisible(true)
		self.aniSelf:startAni("TargetLose", true)
	else
		self.panelEnough:setVisible(false)
		self.panelNotEnough:setVisible(false)
		self.aniSelf:startAni("TargetNml", true)
	end

	return true
end

local strClassName = "BattleMainBase"
local BattleMainBase = Class(strClassName, UIControls.Window)
local BattleHeroCellBase = Class("BattleHeroCellBase", UIControls.Panel)

function BattleHeroCellBase:ctor()
	self:initUI()
end

function BattleHeroCellBase:initUI()
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onClickSensor)

	self.bgHero = UIControls.Image(self, self.mPath .. "/BgHero")
	self.imgHero = UIControls.Image(self, self.mPath .. "/IconHero")
	self.sliderHp = UIControls.Slider(self, self.mPath .. "/BarBlood")
	self.sliderMana = UIControls.Slider(self, self.mPath .. "/BarEnergy")
	self.imgDead = UIControls.Image(self, self.mPath .. "/ImgDead")
	self.panelManaFull = UIControls.Panel(self, self.mPath .. "/ImgEnergyFull")
	self.textManaFull = UIControls.Label(self, self.mPath .. "/ImgEnergyFull/Text")
	self.imgWaiting = UIControls.Image(self, self.mPath .. "/ImgWaiting")
	self.efxHero = UIControls.Panel(self, self.mPath .. "/EfxHero")
	self.efxBtn = UIControls.Panel(self, self.mPath .. "/EfxBtn")
	self.bgBlood = UIControls.Panel(self, self.mPath .. "/BgBlood")
	self.imgShield = UIControls.Panel(self, self.mPath .. "/BgShield")
	self.sliderShield = UIControls.Slider(self, self.mPath .. "/BgShield/BarShield")
	self.preShield = 0
	self.maxShield = 0

	if UIControls.checkControlFunc(self, self.mPath .. "/ReleasePanel") then
		self.aniRelease = UIControls.UIAni(self, self.mPath .. "/ReleasePanel")

		self.aniRelease:addEventFinish(self.onReleaseAniOver)

		self.iconRelease1 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1")
		self.iconRelease2 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1/IconHero2")
		self.iconRelease3 = UIControls.Image(self, self.mPath .. "/ReleasePanel/IconHero1/IconHero3")
	end
end

function BattleHeroCellBase:onClickSensor(sender)
	if Const.BEGINNER_LOCK_SKILL then
		return
	end

	if not self.mParent.inManual then
		return
	end

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	local state = GameFsm.getCurState()

	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_USE_SKILL, self.entityId)
	self:setState(STATE_WAIT)
end

BattleHeroCellBase.listenerFuncConfig = {
	onHpChange = BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE,
	onSelfDead = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
	refreshCellMana = BattleConst.MATRIX_EVENT_ENTITY_SETMANA,
	SkillHide = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE,
	SkillHideCancel = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL,
	onShieldChange = BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE,
	onRaiseSomething = BattleConst.MATRIX_EVENT_ENTITY_SOMETHING,
	onSelfReborn = BattleConst.MATRIX_EVENT_REBORN_ENTITY,
	onUseSkill = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN
}

function BattleHeroCellBase:onRaiseSomething(immuneType, arg1, arg2)
	if immuneType == BattleConst.ENTITY_SOMETHING_KILL_SOMEONE and not self.mParent.isZombieBattle then
		self:_onKillRaise(arg1, arg2)
	end
end

function BattleHeroCellBase:onUseSkill(skillID, skillType, cameraPrepare, cameraPrepareDuration, cardId)
	if skillType == BattleConst.ATTACK_SKILL then
		self.aniRelease:setVisible(true)
		self.aniRelease:startAni("BattleBtnHeroRelease")
	end
end

function BattleHeroCellBase:onReleaseAniOver()
	if self.aniRelease then
		self.aniRelease:setVisible(false)
	end
end

function BattleHeroCellBase:_onKillRaise(victimId, realFrame)
	if self.preKillFrame and realFrame <= self.preKillFrame + 60 then
		self.preKillFrame = realFrame
		self.preKillNum = self.preKillNum + 1

		if self.preKillNum >= 2 then
			if not self.killComboPanel then
				self.killComboPanel = BattleKillComboChild(self, self.mPath .. "/ComboPanel", "System/Battle/BattleField/BattleComboPanel")
			end

			self.killComboPanel:setVisible(true)
			self.killComboPanel:setData(self.preKillNum)
		end
	else
		self.preKillFrame = realFrame
		self.preKillNum = 1
	end
end

function BattleHeroCellBase:initObj(obj)
	if self.obj then
		self:detachListener()
	end

	self.inSkillPause = false
	self.obj = obj
	self.entityId = obj.id

	self:attachListener()
	self:setState(STATE_NORMAL)

	local iconPath

	if obj.hero then
		iconPath = obj.hero:getIconPath()

		if iconPath then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end
	elseif obj.monsterID then
		iconPath = UIConst.getMonsterIconPath(obj.monsterID)

		if iconPath then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end
	end

	local modelData

	if self.obj.hero then
		modelData = self.obj.hero.modelData
	else
		modelData = utils.getCommonModelData(self.obj.battleCommonData.model)
	end

	if modelData and modelData.skill_ui_eff then
		self.manaFullEff = "Effects/UI/" .. modelData.skill_ui_eff .. ".prefab"
	else
		self.manaFullEff = nil
	end

	if modelData and modelData.skill_dialog then
		self.manaFullSkillDialog = modelData.skill_dialog
	end

	self.sliderHp:setValue(obj.hp / obj.mhp, nil, true)
	self:onShieldChange(obj.shield)
	self:onSetMana(obj.mana, 100)

	if self.aniRelease then
		self.aniRelease:setVisible(false)

		if iconPath then
			self.iconRelease1:setImage(iconPath[1], iconPath[2])
			self.iconRelease2:setImage(iconPath[1], iconPath[2])
			self.iconRelease3:setImage(iconPath[1], iconPath[2])
		end
	end

	if not self.obj:isAlive() then
		self:onSelfDead()
	end
end

function BattleHeroCellBase:refreshState()
	self.imgDead:setVisible(self.state == STATE_DEAD)
	self.panelManaFull:setVisible(self.state == STATE_FULL)
	self.btnSensor:setEnable(self.state == STATE_FULL)
	self.imgWaiting:setVisible(self.state == STATE_WAIT)
	self.efxBtn:setVisible(self.state == STATE_FULL)

	if self.state == STATE_FULL and self.manaFullEff then
		self.efxHero:setVisible(true)
	else
		self.efxHero:setVisible(false)
	end

	if self.state == STATE_DEAD then
		self.bgHero:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroDis")
		self.bgBlood:setVisible(false)
		self.sliderHp:setVisible(false)
		self.sliderMana:setVisible(false)
		self.imgHero:setImageGray(true)
		self.imgShield:setVisible(false)
	else
		self.bgBlood:setVisible(true)
		self.sliderHp:setVisible(true)
		self.sliderMana:setVisible(true)
		self.imgHero:setImageGray(false)

		if self.state == STATE_FULL then
			self.bgHero:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroSel")

			if self.manaFullEff then
				self.efxHero:playEffect(self.manaFullEff)
			end

			if self.manaFullSkillDialog then
				self.textManaFull:setText(self.manaFullSkillDialog)
			end
		elseif self.state == STATE_WAIT then
			self.bgHero:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroNml")
		else
			self.bgHero:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroNml")
		end
	end
end

function BattleHeroCellBase:attachListener()
	EventCenter.addEventListenerGroup(self, self.listenerFuncConfig, self.entityId)
end

function BattleHeroCellBase:detachListener()
	EventCenter.removeEventListenerGroup(self, self.listenerFuncConfig, self.entityId)
end

function BattleHeroCellBase:clear()
	EventCenter.removeEventListenerGroup(self, self.listenerFuncConfig, self.entityId)

	self.obj = nil
	self.preKillFrame = nil

	if self.killComboPanel then
		self.killComboPanel:setVisible(false)
	end

	self.inSkillPause = false
end

function BattleHeroCellBase:destroy()
	self:detachListener()
end

function BattleHeroCellBase:onHpChange(hp, mhp)
	self.sliderHp:setValue(hp / mhp, 0.5)
end

function BattleHeroCellBase:onShieldChange(shield)
	if not self.obj:isAlive() then
		return
	end

	if shield > self.preShield then
		if self.preShield == 0 then
			self.imgShield:setVisible(true)
		end

		self.sliderShield:setValue(1)

		self.preShield = shield
		self.maxShield = shield
	else
		self.sliderShield:setValue(shield / self.maxShield, 0.3)

		self.preShield = shield

		if shield == 0 then
			self.imgShield:setVisible(false)
		end
	end
end

function BattleHeroCellBase:SkillHide(skillSelf, targets)
	self.inSkillPause = true

	self:refreshCellMana()
end

function BattleHeroCellBase:SkillHideCancel()
	self.inSkillPause = false

	self:refreshCellMana()
end

function BattleHeroCellBase:refreshCellMana()
	if self.obj then
		if self.inSkillPause or self.mParent.actionEnd then
			self:onSetMana(self.obj.mana, 100, 0)
		else
			self:onSetMana(self.obj.mana, 100)
		end
	end
end

function BattleHeroCellBase:onSelfDead()
	self:setState(STATE_DEAD)
	self.sliderMana:setValue(self.obj.mana / 100)
end

function BattleHeroCellBase:onSelfReborn()
	self:setState(STATE_NORMAL)

	if self.obj then
		self.sliderHp:setValue(self.obj.hp / self.obj.mhp, 0.5, true)
		self:onSetMana(self.obj.mana, 100, 0)
	end
end

function BattleHeroCellBase:onSetMana(mana, maxMana, manaSpeed)
	if not self.obj:isAlive() then
		return
	elseif manaSpeed == nil then
		manaSpeed = self.obj.mana_gen
	end

	if maxMana <= mana or manaSpeed == 0 then
		self.sliderMana:setValue(mana / maxMana)

		if maxMana <= mana and self.state == STATE_NORMAL and not self.obj:manualWaitingSkill() then
			self:setState(STATE_FULL)
		end

		if mana < maxMana and self.obj.mana_gen == 0 then
			self:setState(STATE_NORMAL)
		end
	elseif manaSpeed < 0 then
		self.sliderMana:setValue(mana / maxMana)
		self.sliderMana:setValue(0, mana / -manaSpeed)

		if self.state ~= STATE_NORMAL and self.state ~= STATE_DEAD then
			self:setState(STATE_NORMAL)
		end
	else
		self.sliderMana:setValue(mana / maxMana)
		self.sliderMana:setValue(1, (maxMana - mana) / manaSpeed)

		if self.state ~= STATE_NORMAL and self.state ~= STATE_DEAD then
			self:setState(STATE_NORMAL)
		end
	end
end

function BattleHeroCellBase:setState(state)
	self.state = state

	self:refreshState()
end

BattleMainBase.BattleHeroCellBase = BattleHeroCellBase

function BattleMainBase:ctor()
	self:setDlgConfig()
	self:initUI()
end

function BattleMainBase:setDlgConfig()
	self.heroNum = 5
	self.heroCellClass = BattleHeroCellBase
end

function BattleMainBase:initUI()
	self.btnAuto = UIControls.Button(self, "BattleFuncPanel/BtnAuto")

	self.btnAuto:addEventClick(self.onAutoClick)

	self.textAuto = UIControls.Label(self, "BattleFuncPanel/BtnAuto/Text")
	self.imgAuto = UIControls.Panel(self, "BattleFuncPanel/BtnAuto/ImgAuto")
	self.btnSpeed = UIControls.Button(self, "BattleFuncPanel/BtnSpeed")

	self.btnSpeed:addEventClick(self.onSpeedClick)

	self.textSpeed = UIControls.Label(self, "BattleFuncPanel/BtnSpeed/Text")
	self.btnExtraSpeed = UIControls.Button(self, "BattleFuncPanel/BtnSpeed2", "Text")

	self.btnExtraSpeed:addEventClick(self.onExtraSpeedClick)
	self.btnExtraSpeed:setVisible(false)

	self.btnShortSkill = UIControls.Button(self, "BattleFuncPanel/BtnCamera", "Text")

	self.btnShortSkill:addEventClick(self.onShortSkillClick)

	self.btnInfo = UIControls.Button(self, "BattleFuncPanel/BtnInfo", "Text")

	self.btnInfo:addEventClick(self.onInfoClick)

	self.btnQuit = UIControls.Button(self, "OtherFuncPanel/BtnQuit")

	self.btnQuit:addEventClick(self.onClickQuit)
	self:onCreateHeroCell()

	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.btnPlayerCampEnhance = UIControls.Button(self, "BgTime/BtnGroupBuffSelf")

	self.btnPlayerCampEnhance:addEventClick(self.onPlayerCampEnhanceClick)

	self.imgPlayerCampEnhance = UIControls.Image(self, "BgTime/BtnGroupBuffSelf/Icon")
	self.btnMonsterCampEnhance = UIControls.Button(self, "BgTime/BtnGroupBuffEnemy")

	self.btnMonsterCampEnhance:addEventClick(self.onMonsterCampEnhanceClick)

	self.imgMonsterCampEnhance = UIControls.Image(self, "BgTime/BtnGroupBuffEnemy/Icon")
	self.btnSensor = UIControls.Button(self, "BtnSensor")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.panelCampEnhance = CampEnhanceInfoPanel(self, "GroupBuffInfoPanel")
	self.btnToWatchMode = UIControls.Button(self, "BattleFuncPanel/BtnMode")

	self.btnToWatchMode:addEventClick(self.onBattleToWatchModeClick)

	self.btnToNormalMode = UIControls.Button(self, "BattleFuncPanel2/BtnMode")

	self.btnToNormalMode:addEventClick(self.onBattleToNormalModeClick)

	self.panelHero = UIControls.Panel(self, "HeroFuncPanel")
	self.panelFunc = UIControls.Panel(self, "BattleFuncPanel")
	self.panelFunc2 = UIControls.Panel(self, "BattleFuncPanel2")

	self:adaptNotchBottom()

	if UIControls.checkControlFunc(self, "TargetPanel") then
		self.btnBattleTarget = UIControls.Button(self, "TargetPanel")

		self.btnBattleTarget:addEventClick(self.onBtnBattleTargetClick)

		self.imgTargetArrow = UIControls.Image(self, "TargetPanel/TargetTitle/Img")
		self.panelBattleTarget = UIControls.Panel(self, "TargetPanel/AllPanel")
		self.battleTargetCells = {}

		for index = 1, 3 do
			local newCell = BattleDlgTargetCell(self, "TargetPanel/AllPanel/Target" .. index)

			table.insert(self.battleTargetCells, newCell)
		end

		self.timerBattleTargetCheck = Timer.New(Slot(self.checkBattleTarget, self), 1, -1)
	end

	if UIControls.checkControlFunc(self, "BossBloodPanel/AttackAwardPanel") then
		self.aniClanBoss = UIControls.UIAni(self, "BossBloodPanel/AttackAwardPanel")
		self.labelClanBoss = UIControls.Label(self, "BossBloodPanel/AttackAwardPanel/Text")
	end

	if UIControls.checkControlFunc(self, "PetFuncPanel") then
		self.panelPet = UIControls.Panel(self, "PetFuncPanel")
		self.panelSelfPet = BattleDlgPetPanel(self, "PetFuncPanel/BtnPet01")
		self.panelEnemyPet = BattleDlgPetPanel(self, "PetFuncPanel/BtnPet02")
	end

	if UIControls.checkControlFunc(self, "SneakBattleTargetPanel") then
		self.sneakBattleTargetPanel = UIControls.Button(self, "SneakBattleTargetPanel")

		self.sneakBattleTargetPanel:addEventClick(self.onSneakBattleTargetPanelClick)

		self.txtFinishTitle = UIControls.Label(self, "SneakBattleTargetPanel/AllPanel/TargetFinish/TextTitle")
		self.txtPerfectTitle = UIControls.Label(self, "SneakBattleTargetPanel/AllPanel/TargetPerfect/TextTitle")
		self.targetFinishLose = UIControls.Image(self, "SneakBattleTargetPanel/AllPanel/TargetFinish/TargetLose")
		self.targetPerfectLose = UIControls.Image(self, "SneakBattleTargetPanel/AllPanel/TargetPerfect/TargetLose")
		self.timerSneakBattleTargetCheck = Timer.New(Slot(self.checkSneakBattleTarget, self), 1, -1)
		self.imgSneakTargetArrow = UIControls.Image(self, "SneakBattleTargetPanel/TargetTitle/Img")
		self.panelSneakBattleTargetAll = UIControls.Panel(self, "SneakBattleTargetPanel/AllPanel")
	end
end

function BattleMainBase:initSpecialBattleConfig()
	local state = GameFsm.getCurState()

	if self.btnBattleTarget then
		local bObjMgr = state.mMatrixInstance.bObjMgr

		if bObjMgr.battleTargetData then
			if state.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
				self.timerBattleTargetCheck:Stop()
				self.timerSneakBattleTargetCheck:Restart()
				self.btnBattleTarget:setVisible(false)
				self.panelBattleTarget:setVisible(true)
				self.sneakBattleTargetPanel:setVisible(true)

				local targets = bObjMgr.battleTargetData.targets or {}

				if targets then
					if targets[1] then
						self.txtPerfectTitle:setText(targets[1].desc or "")
					end

					if targets[2] then
						self.txtFinishTitle:setText(targets[2].desc or "")
					end
				end
			else
				self.timerBattleTargetCheck:Restart()

				if self.timerSneakBattleTargetCheck then
					self.timerSneakBattleTargetCheck:Stop()
				end

				if self.sneakBattleTargetPanel then
					self.sneakBattleTargetPanel:setVisible(false)
				end

				self.btnBattleTarget:setVisible(true)

				local targets = bObjMgr.battleTargetData.targets or {}

				for index, cell in ipairs(self.battleTargetCells) do
					local oneTarget = targets[index]

					if oneTarget then
						cell:setVisible(true)
						cell:initData(oneTarget)
					else
						cell:setVisible(false)
					end
				end

				self.battleTargetShow = -1

				self.panelBattleTarget:setVisible(true)
				self.imgTargetArrow:setRotate(0)
				self:checkBattleTarget(true)
			end
		else
			if self.timerSneakBattleTargetCheck then
				self.timerSneakBattleTargetCheck:Stop()
			end

			if self.sneakBattleTargetPanel then
				self.sneakBattleTargetPanel:setVisible(false)
			end

			self.timerBattleTargetCheck:Stop()
			self.btnBattleTarget:setVisible(false)
		end
	end

	if self.aniClanBoss then
		if not self.timerCheckClanBoss then
			self.timerCheckClanBoss = Timer.New(Slot(self.onCheckClanBoss, self), 2, -1)
		end

		if state:isClanBossBattle() then
			self.aniClanBoss:setVisible(true)
			self.aniClanBoss:stopAni("ShowAttackAward")

			self.aniClanBossPlayed = false

			self.labelClanBoss:setText(ResClientNotice[515].notice)
			self.timerCheckClanBoss:Restart()
		else
			self.aniClanBoss:setVisible(false)
			self.timerCheckClanBoss:Stop()
		end
	end
end

function BattleMainBase:onCheckClanBoss()
	local state = GameFsm.getCurState()

	if state and state.mMatrixInstance then
		local bObjMgr = state.mMatrixInstance.bObjMgr
		local loseHp = bObjMgr:getMonsterLoseHpPercent()

		self.labelClanBoss:setText(ResClientNotice[515].notice .. string.format("%.2f%%", loseHp * 100))

		if not self.aniClanBossPlayed and loseHp >= ResClanBattleMisc[1].boss_hp_percent * 0.0001 then
			self.aniClanBoss:startAni("ShowAttackAward")

			self.aniClanBossPlayed = true
		end
	end
end

function BattleMainBase:onBtnBattleTargetClick()
	if self.battleTargetShow and self.battleTargetShow <= 5 and self.battleTargetShow >= 1 then
		self.battleTargetShow = 6

		self.panelBattleTarget:setVisible(false)
		self.imgTargetArrow:setRotate(180)
	elseif self.battleTargetShow and self.battleTargetShow < 1 then
		-- block empty
	else
		self.battleTargetShow = -1

		self.panelBattleTarget:setVisible(true)
		self.imgTargetArrow:setRotate(0)
		self:checkBattleTarget()
	end
end

function BattleMainBase:onSneakBattleTargetPanelClick()
	local showState = not self.panelSneakBattleTargetAll:getVisible()

	self.panelSneakBattleTargetAll:setVisible(showState)

	if showState then
		self.imgSneakTargetArrow:setRotate(0)
	else
		self.imgSneakTargetArrow:setRotate(180)
	end
end

function BattleMainBase:checkSneakBattleTarget(...)
	local state = GameFsm.getCurState()

	if state and state.mMatrixInstance then
		local bObjMgr = state.mMatrixInstance.bObjMgr
		local okNum, states = bObjMgr:getBattleTargetState()

		if states[1] then
			if states[1][1] == false then
				self.targetPerfectLose:setVisible(true)
			else
				self.targetPerfectLose:setVisible(false)
			end
		end

		if states[2] then
			if states[2][1] == false then
				self.targetFinishLose:setVisible(true)
			else
				self.targetFinishLose:setVisible(false)
			end
		end
	end
end

function BattleMainBase:checkBattleTarget(fromInit)
	if self.battleTargetShow then
		self.battleTargetShow = self.battleTargetShow + 1
	end

	local state = GameFsm.getCurState()

	if state and state.mMatrixInstance then
		local bObjMgr = state.mMatrixInstance.bObjMgr
		local okNum, states = bObjMgr:getBattleTargetState()

		for index, cell in ipairs(self.battleTargetCells) do
			local state = states[index]

			if state and cell:refreshState(state, fromInit) then
				self.battleTargetShow = 0

				self.panelBattleTarget:setVisible(true)
				self.imgTargetArrow:setRotate(0)
			end
		end
	end

	if self.battleTargetShow == 5 then
		self.panelBattleTarget:setVisible(false)
		self.imgTargetArrow:setRotate(180)
	end
end

function BattleMainBase:onCreateHeroCell()
	self.btnHeros = {}

	for index = 1, self.heroNum do
		local newBtn = self.heroCellClass(self, "HeroFuncPanel/BtnHero" .. index)

		table.insert(self.btnHeros, newBtn)
	end
end

function BattleMainBase:initConfig()
	local state = GameFsm.getCurState()
	local bObjMgr = state.mMatrixInstance.bObjMgr
	local pathPlayer = UIConst.CAMP_ENHANCE_BTN_IMG[bObjMgr.playerCampMaxNum] or UIConst.CAMP_ENHANCE_BTN_IMG[0]

	self.imgPlayerCampEnhance:setImage(pathPlayer[1], pathPlayer[2])

	local pathMonster = UIConst.CAMP_ENHANCE_BTN_IMG[bObjMgr.monsterCampMaxNum] or UIConst.CAMP_ENHANCE_BTN_IMG[0]

	self.imgMonsterCampEnhance:setImage(pathMonster[1], pathMonster[2])
	self:_initBtnConfig()
	self:setVisible(true)
	self:initBattleBlood()
	self:initSpecialBattleConfig()

	self.isZombieBattle = state:isZombieBattle()

	self:initPlayers(state)
	self:initPetConfig(bObjMgr)
end

function BattleMainBase:initPlayers(state)
	local players = state:getPlayers()
	local orderPlayers = self:_getOrderPlayers(players)

	for index, btn in ipairs(self.btnHeros) do
		local obj = orderPlayers[index]

		if obj then
			btn:initObj(obj)
			btn:setVisible(true)
		else
			btn:setVisible(false)
		end
	end
end

function BattleMainBase:_getOrderPlayers(players)
	local orderPlayers = {}

	for i = 12, 1, -1 do
		if players[i] and not players[i]:attackNear() then
			table.insert(orderPlayers, players[i])
		end
	end

	for i = 12, 1, -1 do
		if players[i] and players[i]:attackNear() then
			table.insert(orderPlayers, players[i])
		end
	end

	return orderPlayers
end

function BattleMainBase:_initBtnConfig()
	local state = GameFsm.getCurState()
	local config = ResBattleConfig[state.battleNo] or {}

	self.needExtraSpeed, self.maxSpeed = state:needExtraSpeed()

	self.btnExtraSpeed:setVisible(self.needExtraSpeed)

	self.infoLevel = UserData.loadCommonData(BattleConst.INFO_LEVEL_KEY) or BattleConst.INFO_LEVEL_DEFAULT

	if self.infoLevel == "" then
		self.infoLevel = BattleConst.INFO_LEVEL_DEFAULT
	end

	state:refreshInfoLevel(self.infoLevel)
	self:_refreshInfoLevelBtn()

	if state.stateName == Const.STATE_DEMO then
		self.inManual = false
	elseif config.enter_auto then
		self.inManual = false
	elseif state.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		self.inManual = false
	elseif ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_AUTO) then
		UserData.saveCommonData(BattleConst.MANUAL_KEY, "1")

		self.inManual = true
	else
		self.inManual = UserData.loadCommonData(BattleConst.MANUAL_KEY) == "1"
	end

	self:_refreshAutoBtn()
	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SPEED) then
		self.speed = BattleConst.SPEED_NORMAL

		UserData.saveCommonData(BattleConst.SPEED_KEY, self.speed)
	else
		local speed = UserData.loadCommonData(BattleConst.SPEED_KEY) or BattleConst.SPEED_NORMAL

		if self.needExtraSpeed then
			local extraSpeed = UserData.loadCommonData(BattleConst.EXTRA_SPEED_KEY) or BattleConst.SPEED_NORMAL

			if extraSpeed == self:getExtraSpeed() then
				self.speed = extraSpeed
			else
				self.speed = speed
			end
		else
			self.speed = speed
		end
	end

	if self.speed == "" then
		self.speed = BattleConst.SPEED_NORMAL
	end

	self:_refreshSpeedBtn()

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) then
		UserData.saveCommonData(BattleConst.SHORT_SKILL_KEY, "0")
	else
		self.inSkillShort = UserData.loadCommonData(BattleConst.SHORT_SKILL_KEY) == "1"
	end

	self:_refreshShortSkillBtn()
	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_SHORT, self.inSkillShort and 1 or 0)

	if state.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		local towerData = state.battlePreInfo.battleSourceData

		if towerData and towerData.wave_num then
			if not self.panelBox then
				self.panelBox = UIControls.Panel(self, "AwardPanel")
				self.bgBox = UIControls.Image(self, "AwardPanel/IconAward")
				self.textBoxNum = UIControls.Label(self, "AwardPanel/TextNum")
			end

			self.towerType = towerData.type

			if CurAvatar then
				self.gotBoxNum = CurAvatar:getChallengeBossAwardNum(self.towerType)
			else
				self.gotBoxNum = 0
			end

			self.maxBoxNum = towerData.wave_num

			self.panelBox:setVisible(true)
			self.bgBox:setImage("Atlas/BattleAtlas/BattleBossBoxAtlas" .. self.towerType, "BgSurprise")
			self.textBoxNum:setText("0")
		end
	end

	if state.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND and not self.panelBox then
		self.panelBox = UIControls.Panel(self, "AwardPanel")

		self.panelBox:setVisible(false)
	end

	if state.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		-- block empty
	end

	local saveCameraMode = UserData.loadCommonData(BattleConst.BATTLE_CAMERA_MODE_KEY)

	self.disableCameraMode = config.disable_camera_mode == 1

	if not self.disableCameraMode and saveCameraMode == "1" and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_CAMERA) then
		local anglesStr = UserData.loadCommonData(BattleConst.BATTLE_CAMERA_MODE_RECORD) or ""

		anglesStr = utils.splitString(anglesStr, ",")

		CameraModeManager.battleToActMode(0.8, anglesStr[1], anglesStr[2])
		self:getController():SetInAnimName("ShowBattleMainModeWatch")

		self.inWatchCameraMode = true
		self.cameraModeCacheArgs = {
			self.inManual,
			self.speed,
			self.inSkillShort
		}

		if self.inManual then
			self.inManual = false

			self:_refreshAutoBtn()
			state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
		end

		if self.speed == BattleConst.SPEED_NORMAL then
			if self.needExtraSpeed then
				self.speed = self:getExtraSpeed()
			else
				self.speed = BattleConst.SPEED_UP1
			end

			self:_refreshSpeedBtn()
		end

		if not self.inSkillShort then
			self.inSkillShort = true

			self:_refreshShortSkillBtn()
		end
	else
		self:getController():SetInAnimName("ShowBattleMainModeBattle")

		self.inWatchCameraMode = false

		if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_CAMERA) then
			self.btnToWatchMode:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBattleLock")
		else
			self.btnToWatchMode:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBattle")
		end
	end

	state:setWatchMode(self.inWatchCameraMode)
end

function BattleMainBase:initPetConfig(bObjMgr)
	if self.panelPet then
		local pets = bObjMgr.pets
		local selfPet, enemyPet

		for _, pet in pairs(pets) do
			if pet.camp == BattleConst.CAMP_MONSTER then
				enemyPet = pet
			else
				selfPet = pet
			end
		end

		if selfPet or enemyPet then
			self.panelPet:setVisible(true)

			if selfPet then
				self.panelSelfPet:setVisible(true)
				self.panelSelfPet:setData(selfPet)
			else
				self.panelSelfPet:setVisible(false)
			end

			if enemyPet then
				self.panelEnemyPet:setVisible(true)
				self.panelEnemyPet:setData(enemyPet)
			else
				self.panelEnemyPet:setVisible(false)
			end
		else
			self.panelPet:setVisible(false)
		end
	end
end

function BattleMainBase:initBattleBlood()
	local boss
	local focus = {}
	local num, focusObj
	local state = GameFsm.getCurState()

	if state.mActorMgr and state.mActorMgr.actors then
		if state.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER and not state:isZombieBattle() or state:isClanBossBattle() then
			for _, actor in pairs(state.mActorMgr.actors) do
				if actor.camp == BattleConst.CAMP_MONSTER then
					boss = actor

					table.insert(focus, actor)
				end
			end

			if state.battlePreInfo.battleSourceData and state.battlePreInfo.battleSourceData.wave_num then
				num = state.battlePreInfo.battleSourceData.wave_num
			elseif state:isClanBossBattle() then
				num = 20

				if state.speData and state.speData.clanData and state.speData.clanData.monsterData then
					num = state.speData.clanData.monsterData.blood_number or 20
				end
			end
		elseif self:isMultiBossBloodMode(state) then
			for _, actor in pairs(state.mActorMgr.actors) do
				if actor.camp == BattleConst.CAMP_MONSTER then
					table.insert(focus, actor)

					if actor.battleCommonData.blood_number then
						boss = actor
						focusObj = actor
						num = boss.battleCommonData.blood_number
					end
				end
			end
		else
			for _, actor in pairs(state.mActorMgr.actors) do
				if actor.battleCommonData.blood_number then
					boss = actor
					focus = {
						actor
					}
					num = boss.battleCommonData.blood_number

					break
				end
			end
		end
	end

	if boss and num then
		self.panelBossBlood = BattleBossBloodPart(self, "BossBloodPanel")

		self.panelBossBlood:setVisible(true)
		self.panelBossBlood:setBossConfig(boss, num, focus, focusObj)
		self.panelBossBlood:refreshInfoLevel(self.infoLevel)

		if state.mActorMgr and state.mActorMgr.specialDamageArgs then
			self.panelBossBlood:onSpecialDamageRecord(true, state.mActorMgr.specialDamageArgs)

			state.mActorMgr.specialDamageArgs = nil
		end
	elseif self.panelBossBlood then
		self.panelBossBlood:setVisible(false)
	end
end

function BattleMainBase:isMultiBossBloodMode(state)
	if state.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		return true
	elseif state.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and state.speData and state.speData.seasonTowerData and state.speData.seasonTowerData.bossConfig then
		return true
	end
end

function BattleMainBase:onPlayerCampEnhanceClick()
	local state = GameFsm.getCurState()

	if state and state.mMatrixInstance and state.mMatrixInstance.bObjMgr then
		self.btnSensor:setVisible(true)
		self.panelCampEnhance:setVisible(true)
		self.panelCampEnhance:onShow(state.mMatrixInstance.bObjMgr.playerCampMaxNum, state.mMatrixInstance.bObjMgr.specCampInfo[1], state.mMatrixInstance.bObjMgr.specCampInfo[2])
	end
end

function BattleMainBase:onMonsterCampEnhanceClick()
	local state = GameFsm.getCurState()

	if state and state.mMatrixInstance and state.mMatrixInstance.bObjMgr then
		if not BattleConst.PVP_BATTLE_DICT[state.battleType] then
			MsgManager.notice(Lang.get(30129))
		else
			self.btnSensor:setVisible(true)
			self.panelCampEnhance:setVisible(true)
			self.panelCampEnhance:onShow(state.mMatrixInstance.bObjMgr.monsterCampMaxNum, state.mMatrixInstance.bObjMgr.specCampInfo[3], state.mMatrixInstance.bObjMgr.specCampInfo[4])
		end
	end
end

function BattleMainBase:onBattleToWatchModeClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_CAMERA) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_CAMERA))

		return
	end

	if self.disableCameraMode then
		MsgManager.clientNotice(274)

		return
	end

	if not self.inWatchCameraMode then
		self.inWatchCameraMode = true

		CameraModeManager.battleToActMode(0.8)
		UserData.saveCommonData(BattleConst.BATTLE_CAMERA_MODE_KEY, "1")
		self:playAni("ChangeModeToWatch", nil, true)

		self.cameraModeCacheArgs = {
			self.inManual,
			self.speed,
			self.inSkillShort
		}

		local state = GameFsm.getCurState()

		if self.inManual then
			self.inManual = false

			self:_refreshAutoBtn()
			state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
		end

		if self.speed == BattleConst.SPEED_NORMAL then
			if self.needExtraSpeed then
				self.speed = self:getExtraSpeed()
			else
				self.speed = BattleConst.SPEED_UP1
			end

			self:_refreshSpeedBtn()
		end

		if not self.inSkillShort then
			self.inSkillShort = true

			self:_refreshShortSkillBtn()
		end

		if state.setWatchMode then
			state:setWatchMode(self.inWatchCameraMode)
		end
	end
end

function BattleMainBase:onBattleToNormalModeClick()
	if self.inWatchCameraMode then
		self.inWatchCameraMode = false

		CameraModeManager.battleToDefaultMode(0.8)
		UserData.saveCommonData(BattleConst.BATTLE_CAMERA_MODE_KEY, "0")
		self:playAni("ChangeModeToBattle", nil, true)

		if self.cameraModeCacheArgs then
			if self.inManual ~= self.cameraModeCacheArgs[1] then
				self.inManual = self.cameraModeCacheArgs[1]

				self:_refreshAutoBtn()

				local state = GameFsm.getCurState()

				state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
			end

			if self.speed ~= self.cameraModeCacheArgs[2] then
				self.speed = self.cameraModeCacheArgs[2]

				self:_refreshSpeedBtn()
			end

			if self.inSkillShort ~= self.cameraModeCacheArgs[3] then
				self.inSkillShort = self.cameraModeCacheArgs[3]

				self:_refreshShortSkillBtn()
			end
		end

		local state = GameFsm.getCurState()

		if state.setWatchMode then
			state:setWatchMode(self.inWatchCameraMode)
		end
	end
end

function BattleMainBase:onClickSensor()
	self.btnSensor:setVisible(false)
	self.panelCampEnhance:setVisible(false)
end

function BattleMainBase:onBattleTime(battleTime)
	self.textTime:setText(utils.calcTimeTxt(battleTime, true))
end

function BattleMainBase:_refreshAutoBtn()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_AUTO) then
		self.btnAuto:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnAutomaticLock")
		self.textAuto:setText(Lang.get(195))
		self.textAuto:setFontColor(ResColor.GREYMIDDLE)
		self.imgAuto:setVisible(false)
	elseif self.inManual then
		self.btnAuto:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnManual")
		self.textAuto:setText(Lang.get(30130))
		self.textAuto:setFontColor(ResColor.WHITE)
		self.imgAuto:setVisible(false)
	else
		self.btnAuto:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnAutomatic")
		self.textAuto:setText(Lang.get(417))
		self.textAuto:setFontColor(ResColor.WHITE)
		self.imgAuto:setVisible(true)
	end
end

function BattleMainBase:_refreshSpeedBtn()
	local btnFontColor = ResColor.WHITE

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SPEED) then
		self.btnSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeedLock")
		self.textSpeed:setText(Lang.get(195))
		self.imgAuto:setVisible(false)

		if GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_BEGINNER then
			UnityEngine.Time.timeScale = 1.6

			CueManager.setSfxSpeed(1.6)
		else
			UnityEngine.Time.timeScale = 1.25

			CueManager.setSfxSpeed(1.25)
		end

		if self.needExtraSpeed then
			self.btnExtraSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeedLock")
			self.btnExtraSpeed:setText(Lang.get(195))
		end

		btnFontColor = ResColor.GREYMIDDLE
	elseif self.speed == BattleConst.SPEED_UP1 then
		UnityEngine.Time.timeScale = 1.55

		CueManager.setSfxSpeed(1.55)
		self:_speedIsOn(true)

		if self.needExtraSpeed then
			self:_extraSpeedIsOn(false)
		end
	elseif self.speed == BattleConst.SPEED_UP2 then
		if self.needExtraSpeed then
			UnityEngine.Time.timeScale = 2.55

			CueManager.setSfxSpeed(2.55)
			self:_extraSpeedIsOn(true)
			self:_speedIsOn(false)
			self:forceOpenShortSkill()
		end
	elseif self.speed == BattleConst.SPEED_UP3 then
		if self.needExtraSpeed then
			UnityEngine.Time.timeScale = 3.55

			CueManager.setSfxSpeed(3.55)
			self:_extraSpeedIsOn(true)
			self:_speedIsOn(false)
			self:forceOpenShortSkill()
		end
	else
		UnityEngine.Time.timeScale = 1.25

		CueManager.setSfxSpeed(1.25)
		self:_speedIsOn(false)

		if self.needExtraSpeed then
			self:_extraSpeedIsOn(false)
		end
	end

	self.textSpeed:setFontColor(btnFontColor)
	self.btnExtraSpeed:setFontColor(btnFontColor)
end

function BattleMainBase:_speedIsOn(isOn)
	if isOn then
		self.btnSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed2")
		self.textSpeed:setText(Lang.get(30131))
	else
		self.btnSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed1")
		self.textSpeed:setText(Lang.get(30132))
	end
end

function BattleMainBase:_extraSpeedIsOn(isOn)
	if isOn then
		self.btnExtraSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed4On")
	else
		self.btnExtraSpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed4Off")
	end

	self.btnExtraSpeed:setText(string.format(Lang.get(96567), self.maxSpeed or 4))
end

function BattleMainBase:forceOpenShortSkill()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) or self.inSkillShort then
		return
	end

	self:onShortSkillClick()
end

function BattleMainBase:_refreshShortSkillBtn()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) then
		self.btnShortSkill:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnCameraLock")
		self.btnShortSkill:setFontColor(ResColor.GREYMIDDLE)
		self.btnShortSkill:setText(Lang.get(30134))
	elseif self.inSkillShort then
		self.btnShortSkill:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnCameraClose")
		self.btnShortSkill:setFontColor(ResColor.WHITE)
		self.btnShortSkill:setText(Lang.get(30135))
	else
		self.btnShortSkill:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnCameraOpen")
		self.btnShortSkill:setFontColor(ResColor.WHITE)
		self.btnShortSkill:setText(Lang.get(30134))
	end
end

function BattleMainBase:_refreshInfoLevelBtn()
	if self.infoLevel == BattleConst.INFO_LEVEL_MIDDLE then
		self.btnInfo:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnMessage2")
		self.btnInfo:setText(Lang.get(30136))
	else
		self.btnInfo:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnMessage1")
		self.btnInfo:setText(Lang.get(30137))
	end
end

function BattleMainBase:onAutoClick()
	return
end

function BattleMainBase:onSpeedClick()
	return
end

function BattleMainBase:onExtraSpeedClick()
	return
end

function BattleMainBase:onShortSkillClick()
	return
end

function BattleMainBase:onInfoClick()
	return
end

function BattleMainBase:onClickQuit()
	return
end

function BattleMainBase:onHpLineChanged(nowLine)
	if self.maxBoxNum then
		nowLine = nowLine + 1

		self:showBoxGot(self.maxBoxNum - nowLine)
	end
end

function BattleMainBase:showBoxGot(passedNum)
	if not self.aniBoxBonus then
		self.aniBoxBonus = UIControls.UIAni(self, "AwardShowPanel")
		self.bgAniBox = UIControls.Image(self, "AwardShowPanel/IconAward")
	end

	if self.gotBoxNum and passedNum > 0 then
		if passedNum > self.gotBoxNum then
			self.textBoxNum:setText(passedNum - self.gotBoxNum)
			self.bgAniBox:setImage("Atlas/BattleAtlas/BattleBossBoxAtlas" .. self.towerType, "BgSurpriseL")
		else
			self.bgAniBox:setImage("Atlas/BattleAtlas/BattleBossBoxAtlas" .. self.towerType, "BgSurpriseLOpen")
		end

		self.aniBoxBonus:setVisible(true)

		if self.towerType == Const.BOSS_TOWER_TYPE_ZOMBIE then
			self.aniBoxBonus:startAni("ShowChallengeBossAward", true)
		else
			self.aniBoxBonus:startAni("ShowChallengeBossAward1", true)
		end
	end
end

function BattleMainBase:_onBattleOver()
	return
end

function BattleMainBase:onBattleOver()
	for _, cell in ipairs(self.btnHeros) do
		cell:clear()
	end

	if self.panelSelfPet then
		self.panelSelfPet:clear()
		self.panelEnemyPet:clear()
	end

	if self.panelBossBlood then
		self.panelBossBlood:clear()
	end

	if self.panelBox then
		self.panelBox:setVisible(false)
	end

	if self.aniBoxBonus then
		self.aniBoxBonus:setVisible(false)
	end

	if self.timerSneakBattleTargetCheck then
		self.timerSneakBattleTargetCheck:Stop()
	end

	if self.timerBattleTargetCheck then
		self.timerBattleTargetCheck:Stop()
	end

	if self.timerCheckClanBoss then
		self.timerCheckClanBoss:Stop()
	end

	self.gotBoxNum = nil

	self:onClickSensor()
	self:_onBattleOver()
end

function BattleMainBase:onResume()
	for _, btn in ipairs(self.btnHeros) do
		btn:refreshCellMana()
	end

	if self.panelSelfPet then
		self.panelSelfPet:refreshCellMana()
		self.panelEnemyPet:refreshCellMana()
	end
end

function BattleMainBase:destroy()
	for _, btn in ipairs(self.btnHeros) do
		btn:destroy()
	end

	if self.panelSelfPet then
		self.panelSelfPet:destroy()
		self.panelEnemyPet:destroy()
	end

	if self.panelBossBlood then
		self.panelBossBlood:destroy()
	end

	if self.timerCheckClanBoss then
		self.timerCheckClanBoss:Stop()
	end

	if self.timerBattleTargetCheck then
		self.timerBattleTargetCheck:Stop()
	end

	if self.timerSneakBattleTargetCheck then
		self.timerSneakBattleTargetCheck:Stop()
	end

	BattleMainBase.super.destroy(self)
end

function BattleMainBase:adaptNotchBottom()
	if DeviceHelper.isiPhoneWithNotch() then
		local RectTransformType = typeof(UnityEngine.RectTransform)

		for _, panel in ipairs({
			self.panelHero,
			self.panelFunc,
			self.panelFunc2
		}) do
			if panel then
				local rectTrans = panel:getComObj():GetComponent(RectTransformType)
				local oldMin = rectTrans.anchorMin

				oldMin.y = 0.02

				local oldMax = rectTrans.anchorMax

				oldMax.y = 0.02
				rectTrans.anchorMin = oldMin
				rectTrans.anchorMax = oldMax
			end
		end
	end
end

function BattleMainBase:getExtraSpeed()
	if self.maxSpeed == 8 then
		return BattleConst.SPEED_UP3
	else
		return BattleConst.SPEED_UP2
	end
end

return BattleMainBase
