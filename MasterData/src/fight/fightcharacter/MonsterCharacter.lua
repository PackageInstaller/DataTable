MonsterCharacter = class("MonsterCharacter", function(arg_1_0, arg_1_1, arg_1_2)
	return FightCharacter:create(arg_1_0, arg_1_1, arg_1_2)
end)

local var_0_0 = math
local var_0_2 = table
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local substitution_manager = require("controller.substitution_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local expedition_manager = require("controller.expedition_manager")
local activity_manager = require("controller.activity_manager")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local item_data = require("data.item_data")
local battlefield_status_data = require("data.battlefield_status_data")

function MonsterCharacter.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = MonsterCharacter.new(arg_2_1, arg_2_2, arg_2_3)

	var_2_0:initMonster()

	return var_2_0
end

function MonsterCharacter:initMonster(arg_3_1, arg_3_2)
	self._aniWait = true
	self._passlevelWait = true

	self:registerEnterHandler(function()
		return
	end)
	self:registerExitHandler(function()
		return
	end)
	self:initMonsterBasicHandlers()
end

function MonsterCharacter:joinFight(arg_6_1)
	self.index = arg_6_1

	if self.charactertype == "player" then
		self:setStatus(STATUS_SEARCHING)
	elseif self.charactertype == "enemy" then
		self:setStatus(STATUS_PREFIGHTING)
	end

	self:registerStatusPool()
	self:resetAllCD()

	if self._slaves then
		for iter_6_0, iter_6_1 in ipairs(self._slaves) do
			iter_6_1:joinFight(arg_6_1, iter_6_0)
			FightManager.getUIElements().attachCharacter(iter_6_1)
		end
	end
end

function MonsterCharacter:registerStatusPool()
	self:registerPassiveSkill()
	self:registerSPSkill()
	self:registerAssistSkill()
	self:registerWeaponSkill()
	self:registerBattleFieldStatus()
end

function MonsterCharacter:unregisterStatusPool()
	self:unregisterPassiveSkill()
	self:unregisterSPSkill()
	self:unregisterAssistSkill()
	self:unregisterWeaponSkill()
	self:unregisterBattleFieldStatus()
end

function MonsterCharacter:registerPassiveSkill()
	local var_9_0 = total_skill_data[self:getAttribute("passiveskill")]
	local var_9_1 = 1

	while var_9_0["skill" .. var_9_1] do
		self.statuspool:registerPassiveskill(var_9_0["skill" .. var_9_1])

		var_9_1 = var_9_1 + 1
	end

	local var_9_2 = 1

	while self._skilllist["skill" .. var_9_2] do
		while total_skill_data[self._skilllist["skill" .. var_9_2].id]["skill" .. 1] do
			if skill_data[total_skill_data[self._skilllist["skill" .. var_9_2].id]["skill" .. 1]].skill_type == 0 then
				self.statuspool:registerPassiveskill(total_skill_data[self._skilllist["skill" .. var_9_2].id]["skill" .. 1])
			end
		end

		var_9_2 = var_9_2 + 1
	end
end

function MonsterCharacter:unregisterPassiveSkill()
	local var_10_0 = total_skill_data[self:getAttribute("passiveskill")]
	local var_10_1 = 1

	while var_10_0["skill" .. var_10_1] do
		self.statuspool:unregisterPassiveskill(var_10_0["skill" .. var_10_1])

		var_10_1 = var_10_1 + 1
	end

	local var_10_2 = 1

	while self._skilllist["skill" .. var_10_2] do
		while total_skill_data[self._skilllist["skill" .. var_10_2].id]["skill" .. 1] do
			if skill_data[total_skill_data[self._skilllist["skill" .. var_10_2].id]["skill" .. 1]].skill_type == 0 then
				self.statuspool:unregisterPassiveskill(total_skill_data[self._skilllist["skill" .. var_10_2].id]["skill" .. 1])
			end
		end

		var_10_2 = var_10_2 + 1
	end
end

function MonsterCharacter:registerSPSkill()
	local var_11_0 = self:getAttribute("spskill")

	if not var_11_0 then
		return
	end

	local var_11_1 = total_skill_data[var_11_0]

	while var_11_1["skill" .. 1] do
		self.statuspool:registerPassiveskill(var_11_1["skill" .. 1])
	end
end

function MonsterCharacter:unregisterSPSkill()
	local var_12_0 = self:getAttribute("spskill")

	if not var_12_0 then
		return
	end

	local var_12_1 = total_skill_data[var_12_0]

	while var_12_1["skill" .. 1] do
		self.statuspool:unregisterPassiveskill(var_12_1["skill" .. 1])
	end
end

function MonsterCharacter:registerWeaponSkill()
	if self.weapon_skill then
		while total_skill_data[self.weapon_skill]["skill" .. 1] do
			self.statuspool:registerPassiveskill(total_skill_data[self.weapon_skill]["skill" .. 1])
		end
	end
end

function MonsterCharacter:unregisterWeaponSkill()
	if self.weapon_skill then
		while total_skill_data[self.weapon_skill]["skill" .. 1] do
			self.statuspool:unregisterPassiveskill(total_skill_data[self.weapon_skill]["skill" .. 1])
		end
	end
end

function MonsterCharacter:registerAssistSkill()
	if self._assistconfig then
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in ipairs(self._assistconfig.skills) do
			local var_15_1 = 1

			while total_skill_data[iter_15_1]["skill" .. var_15_1] do
				self.statuspool:registerAssist(total_skill_data[iter_15_1]["skill" .. var_15_1])

				var_15_1 = var_15_1 + 1
			end

			if total_skill_data[iter_15_1].icon then
				var_0_2.insert(var_15_0, "skill_new/skill/" .. total_skill_data[iter_15_1].icon .. ".png")
			end
		end

		if self._boss then
			for iter_15_2, iter_15_3 in ipairs(var_15_0) do
				local var_15_2

				if config._DEBUG then
					var_15_2 = cc.Sprite:create("skill_new/fight_boss_skill_frame.png") or cc.Sprite:createWithSpriteFrameName("skill_new/fight_boss_skill_frame.png")
				end

				var_15_2:setPosition(cc.p(45 * (iter_15_2 - 1), 0))
				self.horcruxSkillsNode:addChild(var_15_2)

				local var_15_3

				if config._DEBUG then
					var_15_3 = cc.Sprite:create(iter_15_3) or cc.Sprite:createWithSpriteFrameName(iter_15_3)
				end

				var_15_3:setScale(0.36)
				var_15_3:setPosition(cc.p(45 * (iter_15_2 - 1), 0))
				self.horcruxSkillsNode:addChild(var_15_3)
			end
		elseif self._captainindex then
			for iter_15_4, iter_15_5 in ipairs(var_15_0) do
				local var_15_4

				if config._DEBUG then
					var_15_4 = cc.Sprite:create("skill_new/fight_boss_skill_frame.png") or cc.Sprite:createWithSpriteFrameName("skill_new/fight_boss_skill_frame.png")
				end

				var_15_4:setPosition(cc.p(35 * (iter_15_4 - 1), 0))
				var_15_4:setScale(0.7)
				self.horcruxSkillsNode:addChild(var_15_4)

				local var_15_5

				if config._DEBUG then
					var_15_5 = cc.Sprite:create(iter_15_5) or cc.Sprite:createWithSpriteFrameName(iter_15_5)
				end

				var_15_5:setScale(0.25)
				var_15_5:setPosition(cc.p(35 * (iter_15_4 - 1), 0))
				self.horcruxSkillsNode:addChild(var_15_5)
			end
		else
			local var_15_6 = -(#var_15_0 - 1) / 2 * 45

			for iter_15_6, iter_15_7 in ipairs(var_15_0) do
				local var_15_7

				if config._DEBUG then
					var_15_7 = cc.Sprite:create("skill_new/fight_boss_skill_frame.png") or cc.Sprite:createWithSpriteFrameName("skill_new/fight_boss_skill_frame.png")
				end

				var_15_7:setPosition(cc.p(var_15_6 + 45 * (iter_15_6 - 1), 0))
				self.horcruxSkillsNode:addChild(var_15_7)

				local var_15_8

				if config._DEBUG then
					var_15_8 = cc.Sprite:create(iter_15_7) or cc.Sprite:createWithSpriteFrameName(iter_15_7)
				end

				var_15_8:setScale(0.36)
				var_15_8:setPosition(cc.p(var_15_6 + 45 * (iter_15_6 - 1), 0))
				self.horcruxSkillsNode:addChild(var_15_8)
			end
		end
	end
end

function MonsterCharacter:unregisterAssistSkill()
	if self._assistconfig then
		for iter_16_0, iter_16_1 in ipairs(self._assistconfig.skills) do
			while total_skill_data[iter_16_1]["skill" .. 1] do
				self.statuspool:unregisterAssist(total_skill_data[iter_16_1]["skill" .. 1])
			end
		end
	end
end

function MonsterCharacter:registerBattleFieldStatus()
	if self._battlefieldstatus then
		for iter_17_0, iter_17_1 in ipairs(self._battlefieldstatus) do
			self.statuspool:registerBattleFieldStatus(iter_17_1)
		end
	end
end

function MonsterCharacter:unregisterBattleFieldStatus()
	if self._battlefieldstatus then
		for iter_18_0, iter_18_1 in ipairs(self._battlefieldstatus) do
			self.statuspool:unregisterBattleFieldStatus(iter_18_1)
		end
	end
end

function MonsterCharacter.initNormalAniListener(arg_19_0)
	return
end

function MonsterCharacter.initBattleAssist(arg_20_0, arg_20_1)
	arg_20_0._assistconfig = arg_20_1
end

function MonsterCharacter.initMonsterWeapon(arg_21_0, arg_21_1)
	arg_21_0.weapon_skill = arg_21_1.passiveSkill
	arg_21_0.weapon_XP = arg_21_1.XP
end

function MonsterCharacter:initBattleFieldStatus(arg_22_1)
	self._battlefieldstatus = nil

	if not arg_22_1 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		if self:canTriggerBattleFieldStatus(battlefield_status_data[iter_22_1]) then
			while battlefield_status_data[iter_22_1]["skill" .. 1] do
				self._battlefieldstatus = self._battlefieldstatus or {}

				var_0_2.insert(self._battlefieldstatus, battlefield_status_data[iter_22_1]["skill" .. 1])
			end
		end
	end
end

function MonsterCharacter:canTriggerBattleFieldStatus(arg_23_1)
	if arg_23_1.targetside == 1 then
		return false
	end

	if arg_23_1.targetattacktype == 1 then
		if self:getAttribute("range") >= 200 then
			return false
		end
	elseif arg_23_1.targetattacktype == 2 and self:getAttribute("range") < 200 then
		return false
	end

	if arg_23_1.targetcareer and arg_23_1.targetcareer ~= self:getAttribute("career") then
		return false
	end

	if arg_23_1.targetattr and arg_23_1.targetattr ~= self:getAttribute("targetattr") then
		return false
	end

	if arg_23_1.targetmodelid and arg_23_1.targetmodelid ~= self:getAttribute("modelid") then
		return false
	end

	if arg_23_1.targetmodeltype and arg_23_1.targetmodeltype ~= self:getAttribute("modeltype") then
		return false
	end

	return true
end

function MonsterCharacter:beHitted(arg_24_1, arg_24_2)
	if arg_24_1.damage <= 0 then
		if arg_24_1.info and arg_24_1.info.isBlind then
			self:beHittedBlind()
		end

		return false
	end

	if not self:canBeHit() then
		return false
	end

	local var_24_0 = FightManager.getCharacter(arg_24_1.sourceindex)

	if var_24_0 and var_24_0.statuspool:getStatus("damage_change_mechanical") then
		arg_24_1.damagetype = MECHANICAL_DAMAGE
	end

	if self.statuspool:getStatus("suffer_damage_change_mechanical") then
		arg_24_1.damagetype = MECHANICAL_DAMAGE
	end

	if not arg_24_1.behitted then
		self._behitted = 0.2
	end

	self:onHittedShutDown(arg_24_1.behitted)

	if arg_24_1.sourceindex and arg_24_1.info.isRes == nil then
		local var_24_1, var_24_2 = calculate_majorattr_addition(FightManager.getCharacter(arg_24_1.sourceindex), self)

		arg_24_1.info.isRes = var_24_1
		arg_24_1.damage = var_0_0.floor(arg_24_1.damage * var_24_2)
	end

	arg_24_1.damage = arg_24_1.damage * (1 + FightManager.getGlobalDamageAddition())

	local var_24_3 = self:getAttribute("max_taken_damage")

	if var_24_3 then
		self:setAttribute("max_taken_damage", var_24_3 * (1 + FightManager.getGlobalDamageAddition()))
	end

	if self:isDamageCauseDie(arg_24_1.damagetype, arg_24_1.damage) then
		self:triggerStatus("onDyingBeforeSheild", FightManager.getCharacter(arg_24_1.sourceindex), arg_24_1)
	end

	local var_24_4 = {
		damage = 0,
		finalhit = true
	}
	local var_24_5 = 0

	if arg_24_1.damagetype == HOLY_DAMAGE then
		var_24_4.damage = arg_24_1.damage
		var_24_5 = arg_24_1.damage
	else
		var_24_4.damage = self:hitShield(arg_24_1.damage)
		var_24_4.damage = self:calculateDefence(arg_24_1.damagetype, var_24_4.damage, FightManager.getCharacter(arg_24_1.sourceindex))
		arg_24_1.damage = var_24_4.damage + (arg_24_1.damage - var_24_4.damage)
		var_24_5 = arg_24_1.damage
	end

	if var_24_0 and not var_24_0.statuspool:getStatus("ignoremaxdamage") and self:getAttribute("max_taken_damage") > 0 and arg_24_1.damage > self:getAttribute("max_taken_damage") then
		arg_24_1.damage = self:getAttribute("max_taken_damage")
		var_24_5 = arg_24_1.damage
		var_24_4.damage = arg_24_1.damage
	end

	FightManager.addStatistics("damage", var_24_5, arg_24_1.sourceindex, self.index, arg_24_1)

	if not arg_24_2 then
		arg_24_1.triggeronhurt = true

		if arg_24_1.damagetype == MECHANICAL_DAMAGE then
			if FightManager.getCharacter(arg_24_1.sourceindex) then
				FightManager.getCharacter(arg_24_1.sourceindex):triggerStatus("onMechanicalDamage", self, arg_24_1)
			end

			self:triggerStatus("onMechanicalHurt", FightManager.getCharacter(arg_24_1.sourceindex), arg_24_1)
		elseif arg_24_1.damagetype == ENERGY_DAMAGE then
			if FightManager.getCharacter(arg_24_1.sourceindex) then
				FightManager.getCharacter(arg_24_1.sourceindex):triggerStatus("onEnergyDamage", self, arg_24_1)
			end

			self:triggerStatus("onEnergyHurt", FightManager.getCharacter(arg_24_1.sourceindex), arg_24_1)
		end

		self:triggerStatus("onHurt", FightManager.getCharacter(arg_24_1.sourceindex), arg_24_1)
	end

	if self._bear and self._bear:transferDamage({
		damage = var_24_4.damage,
		damagetype = arg_24_1.damagetype,
		sourceindex = arg_24_1.sourceindex,
		info = {
			isRes = false
		}
	}) then
		local var_24_6 = self._bear:getEffect()

		self:playStatusEffect(false, var_24_6.filename, var_24_6.ani, var_24_6.offsetX, var_24_6.offsetY, var_24_6.offsetZ, self:getDirection())

		var_24_4.damage = var_24_4.damage * (1 - self._bear:getPercent())
	end

	local var_24_7 = false

	if self._contracted then
		local var_24_8 = FightManager.getCharacter(self._contracted:getIndex())

		if var_24_8 and var_24_8._bear then
			var_24_7 = true
		end
	end

	if not var_24_7 and self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1) - var_24_4.damage <= 0 then
		if self._contracted and self._contracted:trigger({
			damage = var_24_4.damage,
			damagetype = arg_24_1.damagetype,
			sourceindex = arg_24_1.sourceindex
		}) then
			local var_24_9 = self._contracted:getEffect()

			self:playStatusEffect(false, var_24_9.filename, var_24_9.ani, var_24_9.offsetX, var_24_9.offsetY, var_24_9.offsetZ, self:getDirection())

			return false
		end

		self:triggerStatus("onDying", FightManager.getCharacter(arg_24_1.sourceindex), var_24_4)

		if not self.statuspool:getStatus("superimmortal") and (arg_24_1.immortallimit or not self.statuspool:getStatus("immortal")) then
			self:triggerStatus("onDyingNoImmortal", FightManager.getCharacter(arg_24_1.sourceindex), var_24_4)
		end
	end

	local var_24_10 = self:addCurHp(-1 * var_0_0.round(var_24_4.damage), arg_24_1.immortallimit)

	if self.skeleton then
		local var_24_11 = arg_24_1.info.beattype

		if arg_24_1.damagetype == ENERGY_DAMAGE then
			var_24_11 = 10

			if arg_24_1.skilltype == "attack" then
				var_24_11 = 9
			elseif arg_24_1.skilltype == "xp" then
				var_24_11 = 11
			end
		end

		self:pushBackHitnumber({
			posx = self:getPositionX(),
			posy = self:getPositionY() + (self:getAttribute("model_height") + self:getRootOffsetY()) * STANDARD_SCALE * self:getAttribute("model_scale") + HITWORD_HEIGHT,
			number = var_0_0.round(-1 * var_24_5),
			cri = arg_24_1.info.isCri,
			miss = arg_24_1.info.isMiss,
			strike = arg_24_1.info.isStrike,
			restrain = arg_24_1.info.isRes,
			side = self.charactertype,
			attacktype = var_24_11
		})
	end

	if var_24_10 < 0 then
		self:addRageOnHitted(-var_24_10)

		if self:isBoss() then
			if FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION then
				substitution_manager:update_substitution_damage(-var_24_10)
			elseif FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION_OLD then
				old_substitution_manager:updateSubstitutionEnemyHurt(-var_24_10)
			elseif FightManager.getFightType() == FIGHTTYPE_INFINITE then
				infinite_fight_manager:sync_boss_damage(-var_24_10)
			elseif FightManager.getFightType() == FIGHTTYPE_EXPEDITION_MONOPOLY then
				expedition_manager:sync_boss_damage(-var_24_10)
			elseif FightManager.getFightType() == FIGHTTYPE_WORLDBOSS then
				activity_manager:updateWorldBossDamage(-var_24_10)
			end
		end
	end

	if global_gold_drop_timer <= 0 and self.charactertype ~= "player" and FightManager.getFightType() ~= FIGHTTYPE_TOWER and FightManager.getFightType() ~= FIGHTTYPE_EXPEDITION_TOWER and FightManager.getFightType() ~= FIGHTTYPE_EXPEDITION_MONOPOLY then
		local var_24_12, var_24_13 = pcall(LayerManager.getCurrentLayerName, LayerManager)

		if var_24_13 == "FightLayer" then
			self:getMonsterDrop()
		end

		global_gold_drop_timer = 1

		if FightManager.getFightType() == FIGHTTYPE_AIATTACK then
			global_gold_drop_timer = 10
		end
	end

	if self:getAttribute("curhp") < 1 and self:getAttribute("curhpcount") <= 1 then
		return self:dieAction(arg_24_1.sourceindex)
	end

	return false
end

function MonsterCharacter:dieAction(arg_25_1)
	if self:getStatus() == STATUS_DIED then
		return false
	end

	if self:getStatus() == STATUS_REVIVAL then
		return false
	end

	self.statuspool:setStatus("invincible", false)
	self.statuspool:setStatus("invincible_count", 0)
	self:setStatus(STATUS_DIED)
	self:triggerStatus("onDied", arg_25_1)

	self._godie = true

	return true
end

local function var_0_14(arg_26_0, arg_26_1)
	arg_26_0:keepMoving()
end

local function var_0_15(arg_27_0, arg_27_1)
	arg_27_0:setStatus(STATUS_FIGHTING)
	arg_27_0:runFight()
end

local function var_0_16(arg_28_0, arg_28_1)
	if not arg_28_0._turnbackLimit and arg_28_0.target and type(arg_28_0.target) == "string" then
		local var_28_0 = arg_28_0:getTarget()

		if var_28_0 then
			arg_28_0:switchDirection(var_28_0:getStandardPosition() > arg_28_0:getStandardPosition() and 1 or -1)
		end
	end
end

local function var_0_17(arg_29_0, arg_29_1)
	if arg_29_0._pause then
		return
	end

	if arg_29_0._usingXP then
		return
	end

	if arg_29_0._fightforce then
		return
	end

	if arg_29_0._carriedconf then
		return
	end

	if arg_29_0._godie then
		FightManager.triggerEnemyDied(arg_29_0)
		arg_29_0:unregisterStatusPool()
		arg_29_0:cleanAllBuffs()
		FightManager.call("die", arg_29_0.index)
		arg_29_0:finishFight()

		if arg_29_0.charactertype == "player" then
			FightManager.playerdie(arg_29_0)
		else
			FightManager.enemydie(arg_29_0)
		end

		if not arg_29_0._boss and arg_29_0._captainindex then
			-- block empty
		end

		arg_29_0._passlevelWait = false

		arg_29_0.skeleton:setTimeScale(1)
		arg_29_0:playDieAni()

		arg_29_0._lock = true

		if arg_29_0.hpbar and not arg_29_0._boss and not arg_29_0._captainindex then
			arg_29_0.hpbar:setVisible(false)
		end

		if arg_29_0.buffpanel then
			arg_29_0.buffpanel:setVisible(false)
		end

		arg_29_0:hideBuffEffect()

		arg_29_0._godie = false
	else
		arg_29_0:stopMoving()

		if not arg_29_0._passlevelWait and not arg_29_0._aniWait then
			arg_29_0:setVisible(false)
		end
	end
end

local function var_0_18(arg_30_0, arg_30_1)
	if arg_30_0._pause then
		return
	end

	if arg_30_0._usingXP then
		return
	end

	if arg_30_0._fightforce then
		return
	end

	if arg_30_0._carriedconf then
		return
	end

	if arg_30_0._godie then
		arg_30_0:shutDown()
		arg_30_0:shutDownSlaves()
		arg_30_0:playDieAni()

		arg_30_0._lock = true

		if arg_30_0.hpbar then
			arg_30_0.hpbar:setVisible(false)
		end

		if arg_30_0.buffpanel then
			arg_30_0.buffpanel:setVisible(false)
		end

		arg_30_0:hideBuffEffect()

		arg_30_0._godie = false
	else
		arg_30_0:stopMoving()
	end
end

local function var_0_19(arg_31_0, arg_31_1)
	if arg_31_0._playing then
		return
	end

	if arg_31_0._suppress then
		return
	end

	arg_31_0:finishFight()
	arg_31_0:switchDirection(arg_31_0.charactertype == "player" and 1 or -1)
	arg_31_0:setStatus(STATUS_SEARCHING)
end

local function var_0_20(arg_32_0, arg_32_1)
	if arg_32_0._playing then
		return
	end

	if arg_32_0._suppress then
		return
	end

	if arg_32_0._wining then
		return
	end

	arg_32_0._wining = true

	arg_32_0.skeleton:setTimeScale(1)
	arg_32_0:finishFight()
	arg_32_0:switchDirection(arg_32_0.charactertype == "player" and 1 or -1)
	arg_32_0:playWinAni()

	arg_32_0._lock = true
end

function MonsterCharacter:updateFightState(arg_33_1)
	if self:getStatus() == STATUS_WAITING then
		return
	elseif self:getStatus() == STATUS_SEARCHING then
		var_0_14(self, arg_33_1)
	elseif self:getStatus() == STATUS_PREFIGHTING then
		var_0_15(self, arg_33_1)
	elseif self:getStatus() == STATUS_FIGHTING then
		var_0_16(self, arg_33_1)
	elseif self:getStatus() == STATUS_DIED then
		var_0_17(self, arg_33_1)
	elseif self:getStatus() == STATUS_REVIVAL then
		var_0_18(self, arg_33_1)
	elseif self:getStatus() == STATUS_ENDFIGHT then
		var_0_19(self, arg_33_1)
	elseif self:getStatus() == STATUS_FIGHTWIN then
		var_0_20(self, arg_33_1)
	end
end

function MonsterCharacter:getMonsterDrop()
	local var_34_0, var_34_1 = self:getPosition()
	local var_34_2 = self:getLocalZOrder() - 1

	for iter_34_0 = 1, var_0_0.random(3, 4) do
		GoldSprite:createGold(var_34_0, var_34_1 + var_0_0.random(-40, 10), var_34_2, (iter_34_0 - 1) % 2 * iter_34_0 * 0.02)
	end
end

function MonsterCharacter:monsterDestroy()
	if self:getStatus() == STATUS_DIED then
		return false
	end

	self:setStatus(STATUS_DIED)

	self._godie = true
end

function MonsterCharacter:dropToBattleField(arg_36_1, arg_36_2)
	self.statuspool:setStatus("invincible", true)
	self.statuspool:addStatus("invincible_count", 1)
	self.statuspool:setStatus("impotence", true)
	self.statuspool:addStatus("impotence_count", 1)

	local var_36_0, var_36_1 = self:getPosition()

	arg_36_2 = arg_36_2 or 0

	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_36_2), cc.CallFunc:create(function()
		self.statuspool:addStatus("invincible_count", -1)

		if self.statuspool:getStatus("invincible_count") <= 0 then
			self.statuspool:setStatus("invincible", false)
		end

		self.statuspool:addStatus("impotence_count", -1)

		if self.statuspool:getStatus("impotence_count") <= 0 then
			self.statuspool:setStatus("impotence", false)
		end

		self.logic:updateFight()
		self:registerDefaultY(arg_36_1)
	end)))
end

function MonsterCharacter:delayToBattleField(arg_38_1, arg_38_2, arg_38_3)
	self.statuspool:setStatus("invincible", true)
	self.statuspool:addStatus("invincible_count", 1)
	self.statuspool:setStatus("impotence", true)
	self.statuspool:addStatus("impotence_count", 1)

	arg_38_1 = arg_38_1 or 0

	self:setVisible(false)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_38_1), cc.Show:create(), cc.CallFunc:create(function()
		self:setPosition(cc.p(arg_38_2, arg_38_3))
		self.statuspool:addStatus("invincible_count", -1)

		if self.statuspool:getStatus("invincible_count") <= 0 then
			self.statuspool:setStatus("invincible", false)
		end

		self.statuspool:addStatus("impotence_count", -1)

		if self.statuspool:getStatus("impotence_count") <= 0 then
			self.statuspool:setStatus("impotence", false)
		end

		self:resetAllCD()
		self.logic:updateFight()
		self:registerDefaultY(arg_38_3)
	end)))
end

function MonsterCharacter.onPlayerAiAttack(arg_40_0)
	return
end
