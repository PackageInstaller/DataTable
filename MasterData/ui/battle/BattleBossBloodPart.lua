-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleBossBloodPart.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local BattleLogoStateCell = require("UI/Control/Logo/BattleLogoStateCell")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local UIConst = UIConst
local strClassName = "BattleBossBloodPart"
local BattleBossBloodPart = Class(strClassName, UIControls.Panel)
local BLOOD_CONFIG = {
	{
		"BarBossBlood1",
		"BarBossBlood",
		"BarBossBloodSec"
	},
	{
		"BarBossBloodSec1",
		"BarBossBloodSec",
		"BarBossBlood"
	}
}
local ICON_PATH = "Atlas/BattleAtlas/BattleMainAtlas"

function BattleBossBloodPart:ctor()
	self:initUi()
end

function BattleBossBloodPart:initUi()
	self.iconMonster = UIControls.Image(self, self.mPath .. "/IconHero")
	self.imageBottom = UIControls.Image(self, self.mPath .. "/BgBlood")
	self.barHpDeduct = UIControls.Slider(self, self.mPath .. "/BarBloodB")
	self.imgHpDeduct = UIControls.Image(self, self.mPath .. "/BarBloodB/Fill")
	self.barHp = UIControls.Slider(self, self.mPath .. "/BarBlood")
	self.imgHp = UIControls.Image(self, self.mPath .. "/BarBlood/Fill")
	self.barEnergy = UIControls.Slider(self, self.mPath .. "/BarEnergy")
	self.panelShield = UIControls.Panel(self, self.mPath .. "/BgShield")
	self.barShield = UIControls.Slider(self, self.mPath .. "/BgShield/SliderShield")
	self.panelInfo = UIControls.Panel(self, self.mPath .. "/InfoPanel")
	self.textHP = UIControls.Label(self, self.mPath .. "/InfoPanel/TextBlood")
	self.textHpPer = UIControls.Label(self, self.mPath .. "/InfoPanel/TextBloodPer")
	self.panelScore = UIControls.Panel(self, self.mPath .. "/ScorePanel")
	self.ScorePanelNum = UIControls.Label(self, self.mPath .. "/ScorePanel/TextNum")
	self.imgScorePanelPoint = UIControls.Image(self, self.mPath .. "/ScorePanel/IconPoint")
	self.textLineNumber = UIControls.Label(self, self.mPath .. "/TextBloodNum")

	self.textLineNumber:setVisible(true)

	self.hitAniController = UIControls.UIAni(self, self.mPath .. "/BgPanel")
	self.iconStates = {}
	self.panelSpecialDamage = UIControls.Panel(self, self.mPath .. "/SpeDebuffPanel")
	self.aniSpecialDamage = UIControls.UIAni(self, self.mPath .. "/SpeDebuffPanel")

	self.aniSpecialDamage:addEventAnimateCue(self.onSpecialDamageCue)

	self.sliderSpecialDamage = UIControls.Slider(self, self.mPath .. "/SpeDebuffPanel/Slider")
	self.bgSliderSpecialDamage = UIControls.Image(self, self.mPath .. "/SpeDebuffPanel/Slider/FillArea/Fill/Img")
	self.imgSpecialDamage = UIControls.Image(self, self.mPath .. "/SpeDebuffPanel/TypePanel/IconType")
	self.aniSpecialType = UIControls.UIAni(self, self.mPath .. "/SpeDebuffPanel/TypePanel")
	self.panelNumSpecialDamage = UIControls.Panel(self, self.mPath .. "/SpeDebuffPanel/DebuffPanel/BgNum")
	self.numSpecialDamage = UIControls.Label(self, self.mPath .. "/SpeDebuffPanel/DebuffPanel/BgNum/TextNum")
	self.imgNumSpecialDamag = UIControls.Image(self, self.mPath .. "/SpeDebuffPanel/DebuffPanel/Icon")
	self.effSlider = UIControls.LazyEffectPlayer(self, self.mPath .. "/SpeDebuffPanel/Slider/FillArea/Fill/EfxFill")
	self.effType = UIControls.LazyEffectPlayer(self, self.mPath .. "/SpeDebuffPanel/TypePanel/EfxType")
	self.effDebuff = UIControls.LazyEffectPlayer(self, self.mPath .. "/SpeDebuffPanel/DebuffPanel/EfxShield")
end

function BattleBossBloodPart:setBossConfig(monster, number, focusMonsters, focusOneObj)
	local curState = GameFsm.getCurState()

	if curState.speData and curState.speData.worldBossData then
		self.panelScore:setVisible(true)

		local bossData = curState.speData.worldBossData

		self.socre_k = bossData.score_k
		self.init_score = bossData.init_score

		local integralnum = 0 * self.socre_k + self.init_score

		self.ScorePanelNum:setText(integralnum)

		self.lastintegralnum = integralnum

		local typenum = curState.speData.worldBossData.type

		self.imgScorePanelPoint:setImage(ICON_PATH, "IconWorldBoss" .. typenum)
	elseif curState.speData and curState.speData.seasonTowerData and curState.speData.seasonTowerData.bossConfig then
		local bossConfig = GameFsm.getCurState().speData.seasonTowerData.bossConfig

		self.panelScore:setVisible(true)

		self.socre_k = 1 / bossConfig.item_per_hp
		self.init_score = 0

		self.ScorePanelNum:setText(0)

		self.lastintegralnum = 0

		if bossConfig.icon then
			self.imgScorePanelPoint:setImage(bossConfig.icon_path, bossConfig.icon)
		end
	elseif curState.speData and curState.speData.newMazeData then
		local eventId = curState.speData.newMazeData.eventId
		local eventData = ResNewMazeBattle[eventId] or {}
		local actObj = CurAvatar:getNewMazeActivity()

		if eventData.need_settle == 1 and actObj then
			local miscData = actObj.actData.miscData

			self.panelScore:setVisible(true)

			self.socre_k = miscData.score_correction_factor
			self.init_score = 0

			self.ScorePanelNum:setText("0")

			self.lastintegralnum = 0
		else
			self.socre_k = nil

			self.panelScore:setVisible(false)
		end

		self.imgScorePanelPoint:setImage("Atlas/BattleAtlas/BattleMainAtlas", "IconRogueBoss")
	else
		self.socre_k = nil

		self.panelScore:setVisible(false)
	end

	self.bloodHasNoLimit = number >= 100

	if self.bloodHasNoLimit then
		self.panelInfo:setVisible(false)
	end

	local iconPath = UIConst.getMonsterIconPath(monster.monsterID)

	if iconPath then
		self.iconMonster:setImage(iconPath[1], iconPath[2])
	end

	self.focusMonsters = focusMonsters

	if #focusMonsters > 1 then
		self.singleMode = false
		self.mhp = 0

		for _, actor in ipairs(self.focusMonsters) do
			self.mhp = self.mhp + actor.combatUnit.mhp
		end

		self.oneLineHp = self.mhp / number

		self:onHpChangeMulti(1, 0, 0)

		if focusOneObj then
			self.focusObj = focusOneObj.combatUnit or focusOneObj
		else
			self.focusObj = focusOneObj
		end
	else
		self.singleMode = true
		self.obj = monster.combatUnit
		self.mhp = monster.mhp
		self.oneLineHp = self.mhp / number

		self:onHpChange(self.obj.hp, self.obj.mhp)

		self.focusObj = self.obj
	end

	if self.focusObj then
		self.barEnergy:setVisible(true)
		self:onSetMana()
	else
		self.barEnergy:setVisible(false)
	end

	self:attachListener()
end

local listenerFuncConfig = {
	onHpChange = BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE
}
local focusFuncConfig = {
	onSetMana = BattleConst.MATRIX_EVENT_ENTITY_SETMANA,
	SkillHide = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE,
	SkillHideCancel = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL,
	onShieldChange = BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE,
	onAddState = BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE,
	onDelState = BattleConst.MATRIX_EVENT_ENTITY_DELSTATE
}
local multiListenerFuncConfig = {
	onHpChangeMulti = BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE
}

function BattleBossBloodPart:attachListener()
	if self.singleMode then
		EventCenter.addEventListenerGroup(self, listenerFuncConfig, self.obj.id)
	else
		EventCenter.addEventListenerGroup(self, multiListenerFuncConfig)
	end

	if self.focusObj then
		EventCenter.addEventListenerGroup(self, focusFuncConfig, self.focusObj.id)
	end
end

function BattleBossBloodPart:detachListener()
	if self.singleMode then
		EventCenter.removeEventListenerGroup(self, listenerFuncConfig, self.obj.id)
	else
		EventCenter.removeEventListenerGroup(self, multiListenerFuncConfig)
	end

	if self.focusObj then
		EventCenter.removeEventListenerGroup(self, focusFuncConfig, self.focusObj.id)
	end
end

function BattleBossBloodPart:clear()
	self:detachListener()

	for index, cell in ipairs(self.iconStates) do
		cell:setVisible(false)
		cell:destroy()
	end

	self.iconStates = {}
	self.inSkillPause = false

	self.panelSpecialDamage:setVisible(false)
end

function BattleBossBloodPart:destroy()
	self:detachListener()
end

function BattleBossBloodPart:refreshInfoLevel(infoLevel)
	if infoLevel ~= BattleConst.INFO_LEVEL_MIDDLE or self.bloodHasNoLimit then
		self.panelInfo:setVisible(false)
	else
		self.panelInfo:setVisible(true)
	end
end

function BattleBossBloodPart:setColorConfig(lineNumber)
	if self.bloodHasNoLimit and lineNumber > 10 then
		self.textLineNumber:setText("∞")
	else
		self.textLineNumber:setText("x" .. lineNumber)
	end

	local configNumber = lineNumber % 2 + 1
	local config = BLOOD_CONFIG[configNumber]

	if config then
		self.imgHpDeduct:setImage(ICON_PATH, config[1])
		self.imgHp:setImage(ICON_PATH, config[2])
		self.imageBottom:setImage(ICON_PATH, config[3])

		if lineNumber == 0 then
			self.imageBottom:setVisible(false)
		else
			self.imageBottom:setVisible(true)
		end
	end
end

function BattleBossBloodPart:_shieldCalc(hp, shield)
	local nowHp = hp % self.oneLineHp

	if nowHp == 0 and hp ~= 0 then
		nowHp = self.oneLineHp
	end

	local hpRate = nowHp / self.oneLineHp
	local shieldRate = 0

	if shield > 0 then
		if self.preShield and shield <= self.preShield then
			shieldRate = shield / self.preShield
		else
			shieldRate = 1
			self.preShield = shield

			self.panelShield:setVisible(true)
		end

		if shieldRate > 0 and shieldRate < 0.04 then
			shieldRate = 0.04
		end

		self.barShield:setValue(shieldRate)
	elseif self.preShield then
		self.preShield = nil

		self.panelShield:setVisible(false)
	end

	if hpRate > 0 and hpRate < 0.07 then
		hpRate = 0.07
	end

	return hpRate
end

function BattleBossBloodPart:setHpShield(hp, shield)
	self.hp = hp
	self.shield = shield

	local nowLine = math.floor(self.hp / self.oneLineHp)
	local lessHp = self.hp - nowLine * self.oneLineHp

	if nowLine > 0 and lessHp == 0 then
		lessHp = self.oneLineHp
		nowLine = nowLine - 1
	end

	if nowLine ~= self.nowLine then
		self:setColorConfig(nowLine)

		local hpRate1 = lessHp / self.oneLineHp

		if hpRate1 > 0 and hpRate1 < 0.07 then
			hpRate1 = 0.07
		end

		self.barHp:setValue(hpRate1)
		self.barHpDeduct:setValue(hpRate1)

		self.nowLine = nowLine

		if self.mParent.onHpLineChanged then
			self.mParent:onHpLineChanged(self.nowLine)
		end
	end

	local hpRate = self:_shieldCalc(lessHp, shield)

	self.barHp:setValue(hpRate, 0.05)
	self.barHpDeduct:setValue(hpRate, 0.5)
	self.textHP:setText(ClientUtils.getNumShortStr(math.ceil(self.hp)) .. "/" .. ClientUtils.getNumShortStr(math.ceil(self.mhp)))

	local perValue = math.floor(self.hp / self.mhp * 100 + 0.5)

	if self.hp > 0 and perValue == 0 then
		perValue = 1
	elseif perValue == 100 and self.hp < self.mhp then
		perValue = 99
	end

	self.textHpPer:setText(math.min(100, perValue) .. "%")
end

function BattleBossBloodPart:onHpChange(hp, mhp)
	self:setHpShield(self.obj.hp, self.shield or 0)
	self:setBossScore(hp)
end

function BattleBossBloodPart:onHpChangeMulti(objId, hp, mhp)
	hp = 0

	for _, actor in ipairs(self.focusMonsters) do
		hp = hp + actor.combatUnit.hp
	end

	self:setHpShield(hp, 0)
	self:setBossScore(hp)
end

function BattleBossBloodPart:setBossScore(hp)
	if self.socre_k then
		local integralnum = (self.mhp - hp) * self.socre_k + self.init_score
		local math_integralnum = math.floor(integralnum)

		if math_integralnum >= 2147483647 then
			self.ScorePanelNum:setText(tostring(math_integralnum))
		else
			self.ScorePanelNum:jumpTo(self.lastintegralnum, math_integralnum)
		end

		self.lastintegralnum = math_integralnum
	end
end

function BattleBossBloodPart:onShieldChange(shield)
	if self.hp <= 0 then
		return
	end

	self:setHpShield(self.hp, shield)
end

function BattleBossBloodPart:SkillHide(targets, skillSelf)
	self.inSkillPause = true

	self:onSetMana()
end

function BattleBossBloodPart:SkillHideCancel()
	self.inSkillPause = false

	self:onSetMana()
end

function BattleBossBloodPart:onSetMana(mana, maxMana, manaSpeed)
	if not self.focusObj then
		return
	end

	if self.hp <= 0 then
		return
	elseif manaSpeed == nil then
		manaSpeed = self.focusObj.mana_gen
	end

	mana = self.focusObj.mana
	maxMana = 100

	if self.inSkillPause then
		manaSpeed = 0
	end

	local manaRate = mana / maxMana

	if mana > 0 and manaRate < 0.005 then
		manaRate = 0.005
	end

	if maxMana <= mana or manaSpeed <= 0 then
		self.barEnergy:setValue(manaRate)
	else
		self.barEnergy:setValue(manaRate)
		self.barEnergy:setValue(1, (maxMana - mana) / manaSpeed)
	end
end

function BattleBossBloodPart:onAddState(userId, stateId, stateLevel)
	local stateData = BattleStateData.getStateData(stateId, stateLevel) or {}

	if stateData.show_state then
		self:onDelState(userId, stateId)

		local newIcon = BattleLogoStateCell(self, self.mPath .. "/StatePanel", "System/Battle/BattleField/BattleStateCell", 0, 0, true)

		newIcon:setData(userId, stateId, stateLevel, stateData)
		table.insert(self.iconStates, newIcon)
	end
end

function BattleBossBloodPart:onDelState(userId, stateId)
	local stateData = BattleStateData.getStateData(stateId, 1) or {}

	if stateData.show_state then
		for index, cell in ipairs(self.iconStates) do
			if cell.userId == userId and cell.stateId == stateId then
				cell:setVisible(false)
				cell:destroy()
				table.remove(self.iconStates, index)
			end
		end
	end
end

local DAMAGE_TYPE_CONFIG = {
	{
		"BgShieldSnow",
		"BgShieldSnowBar",
		"Effects/UI/efx_ui_buffad_ieclien.prefab",
		"Effects/UI/efx_ui_buffad_iecbehit.prefab",
		"Effects/UI/efx_ui_buffad_iectrigger.prefab"
	},
	{
		"BgShieldFire",
		"BgShieldFireBar",
		"Effects/UI/efx_ui_buffad_firelien.prefab",
		"Effects/UI/efx_ui_buffad_firebehit.prefab",
		"Effects/UI/efx_ui_buffad_firetrigger.prefab"
	},
	{
		"BgShieldSnowFire",
		"BgShieldSnowFireBar",
		"Effects/UI/efx_ui_buffad_bilien.prefab",
		"Effects/UI/efx_ui_buffad_bibehit.prefab",
		"Effects/UI/efx_ui_buffad_bitrigger.prefab"
	}
}

function BattleBossBloodPart:onSpecialDamageRecord(isInit, args)
	if isInit then
		self.panelSpecialDamage:setVisible(true)

		local imgConfig = DAMAGE_TYPE_CONFIG[args[1]]

		self.imgSpecialDamage:setImage(ICON_PATH, imgConfig[1])
		self.bgSliderSpecialDamage:setImage(ICON_PATH, imgConfig[2])
		self.imgNumSpecialDamag:setImage(ICON_PATH, "BgShieldDis")
		self.panelNumSpecialDamage:setVisible(false)
		self.sliderSpecialDamage:setValue(0, 0, true)

		self.effectCount = nil

		self.aniSpecialDamage:startAni("SpeDebuffReset", true)
		self.effSlider:playEffectByPath(imgConfig[3])
		self.effType:playEffectByPath(imgConfig[4])
		self.effDebuff:playEffectByPath(imgConfig[5])
	else
		local nowCount = args[1]
		local argNeedCount = args[2]
		local triggerOK = args[3]

		self.effectCount = args[4]

		self.aniSpecialType:startAni("SpeDebuffJump", true)

		if triggerOK then
			self.aniSpecialDamage:startAni("SpeDebuffActivate", true)
			self.sliderSpecialDamage:setValue(100, 0.1)
		else
			self.sliderSpecialDamage:setValue(nowCount / argNeedCount, 0.3)
		end
	end
end

function BattleBossBloodPart:onSpecialDamageCue(cueName)
	if self.effectCount then
		self.panelNumSpecialDamage:setVisible(true)
		self.sliderSpecialDamage:setValue(0, 0, true)
		self.numSpecialDamage:setText("+" .. self.effectCount)
		self.imgNumSpecialDamag:setImage(ICON_PATH, "BgShieldSel")
		self.aniSpecialDamage:startAni("SpeDebuffReset", true)
	end
end

return BattleBossBloodPart
