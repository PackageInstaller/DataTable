local var_0_0 = math

function FightCharacter:canCharacterFight()
	if self:getStatus() == STATUS_REVIVAL then
		return false
	elseif self:getStatus() == STATUS_DIED then
		return false
	elseif self.statuspool:checkStatus("vertigo") then
		return false
	elseif self.statuspool:checkStatus("stone") then
		return false
	elseif self.statuspool:checkStatus("confine") then
		return false
	elseif self.statuspool:checkStatus("fear") then
		return false
	elseif self.statuspool:checkStatus("impotence") then
		return false
	else
		return true
	end
end

function FightCharacter:canBeLocked(arg_2_1)
	if self:getStatus() == STATUS_DIED then
		return false
	elseif self.statuspool:checkStatus("confine") then
		return false
	elseif not self:canBeHit() then
		return false
	elseif not self:canLockUnit(arg_2_1) then
		return false
	else
		return true
	end
end

function FightCharacter:canBeHit()
	if self.statuspool:checkStatus("invincible") then
		return false
	elseif not self._pause and self:getStatus() == STATUS_REVIVAL then
		return false
	else
		return true
	end
end

function FightCharacter:canLockUnit(arg_4_1)
	arg_4_1 = arg_4_1 or 0

	return arg_4_1 >= self._unitorder
end

function FightCharacter:isBKB()
	return self.statuspool:checkStatus("bkb")
end

function FightCharacter:isHighLevelSuppressNow()
	return self.statuspool:checkStatus("stone") or self.statuspool:checkStatus("frozen")
end

function FightCharacter:isMiddleLevelSuppressNow()
	return self:isHighLevelSuppressNow() or self.statuspool:checkStatus("vertigo") or self.statuspool:checkStatus("confine")
end

function FightCharacter:setVertigo()
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	if self:isHighLevelSuppressNow() then
		return
	end

	self:shutDown()
	self.skeleton:setTimeScale(FightManager.getBossSpeedUp())
	self:play("stun")
	self:setUnitOrder(0, true)

	self._suppress = true
end

function FightCharacter:removeVertigo()
	self._suppress = self.statuspool:isSuppress()

	self:pushInResetHandler()
end

function FightCharacter:setFlyUnit()
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	self:setUnitOrder(1)
end

function FightCharacter:removeFlyUnit()
	self:setUnitOrder(0)
end

function FightCharacter:setImpotence()
	self.statuspool:setStatus("vertigo", true)

	self._suppress = true

	self.skeleton:setTimeScale(FightManager.getBossSpeedUp())

	if self._unitorder == 1 then
		self:shutDown("idle")
		self:play("idle_fly")
	else
		self:shutDown("idle")
		self:play("idle")
	end
end

function FightCharacter:removeImpotence()
	self.statuspool:setStatus("vertigo", false)
	self.logic:updateFight()
end

function FightCharacter:setStone()
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	self:shutDown("clearTracks")
	self.skeleton:setTimeScale(1)
	self:clearTracks()
	self:setUnitOrder(0, true)
	self.skeleton:setColor(cc.c3b(100, 100, 100))

	self._suppress = true
end

function FightCharacter:removeStone()
	self.skeleton:setColor(cc.c3b(255, 255, 255))
	self:setToSetupPose()

	self._suppress = self.statuspool:isSuppress()

	self:pushInResetHandler()
end

function FightCharacter.setSilence(arg_16_0)
	return
end

function FightCharacter.removeSilence(arg_17_0)
	return
end

function FightCharacter:setAddict()
	if self:isMiddleLevelSuppressNow() then
		return
	end

	self:shutDown()

	self._suppress = true
end

function FightCharacter:removeAddict()
	self._suppress = self.statuspool:isSuppress()

	self:shutDown()
end

function FightCharacter.setImmortal(arg_20_0)
	return
end

function FightCharacter:removeImmortal()
	if self:getAttribute("curhp") <= 0 and self:getAttribute("curhpcount") <= 1 then
		self:dieAction()
	end
end

function FightCharacter:setFear()
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	self._feardir = -1 * self._direction

	if self:isMiddleLevelSuppressNow() then
		return
	end

	self:shutDown()

	self._suppress = true
end

function FightCharacter:removeFear()
	self._suppress = self.statuspool:isSuppress()

	self:pushInResetHandler()
end

function FightCharacter:believeChunge(arg_24_1)
	if self.statuspool:checkStatus("revivallimit") then
		return
	end

	self._revivaling = (self._revivaling or 0) + arg_24_1

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	self._godie = true

	self:setStatus(STATUS_REVIVAL)
end

function FightCharacter:revivalByChunge()
	self:pushInRevivalHandler(self:getAttribute("revivaltime") or 0.3)
end

function FightCharacter:setConfine()
	if self:isHighLevelSuppressNow() then
		return
	end

	self:shutDown()
	self.skeleton:setVisible(false)

	self._suppress = true
end

function FightCharacter:removeConfine()
	self.skeleton:setVisible(true)

	self._suppress = self.statuspool:isSuppress()

	self:pushInResetHandler()
end

function FightCharacter:setFrozen()
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	self:shutDown("clearTracks")
	self.skeleton:setTimeScale(1)
	self:clearTracks()
	self:setUnitOrder(0, true)

	self._suppress = true
end

function FightCharacter:removeFrozen()
	self:setToSetupPose()

	self._suppress = self.statuspool:isSuppress()

	self:pushInResetHandler()
end

function FightCharacter:grabTarget(arg_30_1, arg_30_2)
	if not arg_30_1 then
		return false
	end

	local var_30_0 = FightManager.getCharacter(arg_30_1)

	if not var_30_0 then
		return false
	end

	if var_30_0:setGrabed(self.index, arg_30_2) then
		self._grabing = true

		return true
	else
		return false
	end
end

function FightCharacter:releaseGrabTarget(arg_31_1)
	self._grabing = nil

	if not arg_31_1 then
		return false
	end

	local var_31_0 = FightManager.getCharacter(arg_31_1)

	if not var_31_0 then
		return false
	end

	var_31_0:removeGrabed(self.index)
end

function FightCharacter:isGrabing()
	return self._grabing
end

function FightCharacter:setGrabed(arg_33_1, arg_33_2)
	if self:getStatus() == STATUS_DIED then
		return
	end

	if self:getStatus() == STATUS_REVIVAL then
		return
	end

	local var_33_0 = FightManager.getCharacter(arg_33_1)

	if not var_33_0 then
		return
	end

	if not self._grabed then
		self.statuspool:setStatus("vertigo", true)
		self.statuspool:addStatus("vertigo_count", 1)
		self:setVertigo()
	end

	arg_33_2.finaloffset = arg_33_2.finaloffset or cc.p(0, 0)
	self._grabed = {
		sourceindex = arg_33_1,
		bonename = arg_33_2.bonename,
		finaloffset = cc.p(var_33_0:getRelativeDir(self.index) * arg_33_2.finaloffset.x, arg_33_2.finaloffset.y),
		oringinpos = cc.p(self:getPositionX(), self:getPositionY())
	}

	self:setGravityEnabled(false)

	return true
end

function FightCharacter:removeGrabed(arg_34_1)
	if not self._grabed then
		return
	end

	if self._grabed.sourceindex ~= arg_34_1 then
		return
	end

	self:setPosition(cc.p(self._grabed.oringinpos.x + self._grabed.finaloffset.x, self._grabed.oringinpos.y + self._grabed.finaloffset.y))

	self._grabed = nil

	self.statuspool:addStatus("vertigo_count", -1)

	if self.statuspool:getStatus("vertigo_count") <= 0 then
		self.statuspool:setStatus("vertigo", false)
		self:removeVertigo()
	end

	self:setGravityEnabled(true)
end

function FightCharacter:startTransform(arg_35_1, arg_35_2)
	self._transformer = arg_35_1

	if type(arg_35_2) == "string" then
		local var_35_0, var_35_1 = arg_35_2:match("(%d+),(%d+)")

		arg_35_2 = cc.size(var_35_0, var_35_1)
	end

	self:setImpactSize(arg_35_2.width * self:getAttribute("model_scale") * STANDARD_SCALE, arg_35_2.height * self:getAttribute("model_scale") * STANDARD_SCALE)
end

function FightCharacter:finishTransform()
	self._transformer = nil

	self:setImpactSize(self:getAttribute("model_weight") * self:getAttribute("model_scale") * STANDARD_SCALE, self:getAttribute("model_height") * self:getAttribute("model_scale") * STANDARD_SCALE)

	if self._usingXP then
		return
	end

	self:shutDown()
end

function FightCharacter:registerStatus(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	self.statuspool:registerStatus(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
end

function FightCharacter:unregisterStatus(arg_38_1, arg_38_2, arg_38_3)
	self.statuspool:unregisterStatus(arg_38_1, arg_38_2, arg_38_3)
end

function FightCharacter:registerToStatusPool(arg_39_1, arg_39_2)
	self.statuspool:registerToStatusPool(arg_39_1, arg_39_2)
end

function FightCharacter:unregisterFromStatusPool(arg_40_1, arg_40_2)
	self.statuspool:unregisterFromStatusPool(arg_40_1, arg_40_2)
end

function FightCharacter:getStatusCount(arg_41_1)
	return self.statuspool:getStatusCount(arg_41_1)
end

function FightCharacter:triggerStatus(arg_42_1, arg_42_2, arg_42_3)
	self.statuspool:triggerStatus(arg_42_1, arg_42_2, arg_42_3)
end

function FightCharacter:getTriggerProbAddition(arg_43_1)
	return self.statuspool:getTriggerProbAddition(arg_43_1)
end

function FightCharacter:getTriggerCDAddition(arg_44_1)
	return self.statuspool:getTriggerCDAddition(arg_44_1)
end

function FightCharacter:getStatusRegisterValueAdd(arg_45_1)
	return self.statuspool:getStatusRegisterValueAdd(arg_45_1)
end

function FightCharacter:getStatusExertRegisterValueAdd(arg_46_1)
	return self.statuspool:getStatusExertRegisterValueAdd(arg_46_1)
end

function FightCharacter:getStatusTriggerValueAdd(arg_47_1)
	return self.statuspool:getStatusTriggerValueAdd(arg_47_1)
end

function FightCharacter:getStatusExertTriggerValueAdd(arg_48_1)
	return self.statuspool:getStatusExertTriggerValueAdd(arg_48_1)
end

function FightCharacter:playStatusEffect(arg_49_1, ...)
	if arg_49_1 then
		self:addBuffEffect(...)
	else
		self:playEffect(...)
	end
end

function FightCharacter:getAllBuffs(arg_50_1)
	return self.statuspool:getAllBuffs(arg_50_1)
end

function FightCharacter:addBuff(arg_51_1, arg_51_2, arg_51_3, arg_51_4, arg_51_5, arg_51_6)
	self.statuspool:addBuff(arg_51_1, arg_51_2, arg_51_3, arg_51_4, arg_51_5, arg_51_6)
end

function FightCharacter:removeBuff(arg_52_1)
	self.statuspool:removeBuff(arg_52_1)
end

function FightCharacter:removeBuffByCount(arg_53_1, arg_53_2)
	self.statuspool:removeBuffByCount(arg_53_1, arg_53_2)
end

function FightCharacter:cleanBuff(arg_54_1, arg_54_2)
	self.statuspool:cleanBuff(arg_54_1, arg_54_2)
end

function FightCharacter:cleanDebuff(arg_55_1, arg_55_2)
	self.statuspool:cleanDebuff(arg_55_1, arg_55_2)
end

function FightCharacter:cleanAllBuffs(arg_56_1)
	self.statuspool:cleanAllBuffs(arg_56_1)
end

function FightCharacter:cleanBuffOnRevival()
	self.statuspool:cleanBuffOnRevival()
end

function FightCharacter:pushBackBuff(arg_58_1, arg_58_2)
	if not self.buffpanel then
		return
	end

	self.buffpanel:pushBuff(arg_58_1, arg_58_2)
end

function FightCharacter:popBuff(arg_59_1, arg_59_2)
	if not self.buffpanel then
		return
	end

	self.buffpanel:removeBuff(arg_59_1, arg_59_2)
end

function FightCharacter:getBuffCount(arg_60_1)
	return self.statuspool:getBuffCount(arg_60_1)
end

function FightCharacter:getBuffStackAdd(arg_61_1)
	return self.statuspool:getBuffStackAdd(arg_61_1)
end

function FightCharacter:getExertBuffStackAdd(arg_62_1)
	return self.statuspool:getExertBuffStackAdd(arg_62_1)
end

function FightCharacter:getBuffTimeAdd(arg_63_1)
	return self.statuspool:getBuffTimeAdd(arg_63_1)
end

function FightCharacter:getExertBuffTimeAdd(arg_64_1)
	return self.statuspool:getExertBuffTimeAdd(arg_64_1)
end

function FightCharacter:getBuffTimeFac(arg_65_1)
	return self.statuspool:getBuffTimeFac(arg_65_1)
end

function FightCharacter:getExertBuffTimeFac(arg_66_1)
	return self.statuspool:getExertBuffTimeFac(arg_66_1)
end

function FightCharacter:registerBuff(arg_67_1, arg_67_2)
	self.statuspool:registerBuff(arg_67_1, arg_67_2)
end

function FightCharacter:unregisterBuff(arg_68_1, arg_68_2, arg_68_3)
	self.statuspool:unregisterBuff(arg_68_1, arg_68_2, arg_68_3)
end

function FightCharacter:cleanStatusTriggerCD()
	self.statuspool:clearTriggerCD()
end

function FightCharacter:playEffect(arg_70_1, arg_70_2, arg_70_3, arg_70_4, arg_70_5, arg_70_6)
	local var_70_0 = L2Skeleton:create(EFFECT_SPINE_PATH .. arg_70_1 .. ".json", EFFECT_SPINE_PATH .. arg_70_1 .. ".atlas")

	var_70_0:refreshSkeleton()

	local var_70_1

	if not arg_70_6 then
		arg_70_6 = self._direction
		var_70_1 = self.skeleton:getRootPosition()
	end

	var_70_0:setPosition(cc.p(var_70_1.x * STANDARD_SCALE * self:getAttribute("model_scale") * self._direction + self._size.width * (0.5 - arg_70_6 * (0.5 - arg_70_3)), var_70_1.y * STANDARD_SCALE * self:getAttribute("model_scale") + self._size.height * arg_70_4))

	local var_70_2 = var_0_0.min(self:getAttribute("model_scale"), 1.3)

	var_70_0:setScale(STANDARD_SCALE * arg_70_6 * var_70_2, STANDARD_SCALE * var_70_2)
	var_70_0:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())
	self:addChild(var_70_0, arg_70_5)
	var_70_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_71_0)
		var_70_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
	end)
	var_70_0:play(arg_70_2, false)
end

function FightCharacter:addBuffEffect(arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5)
	local var_72_0 = arg_72_1 .. "_" .. arg_72_2

	if self.buff_effect_tbl[arg_72_1 .. "_" .. arg_72_2] then
		self.buff_effect_tbl[var_72_0].count = self.buff_effect_tbl[var_72_0].count + 1
	else
		self.buff_effect_tbl[var_72_0] = {}
		self.buff_effect_tbl[var_72_0].count = 1

		local var_72_1 = L2Skeleton:create(EFFECT_SPINE_PATH .. arg_72_1 .. ".json", EFFECT_SPINE_PATH .. arg_72_1 .. ".atlas")

		var_72_1:refreshSkeleton()

		local var_72_2 = var_0_0.min(self:getAttribute("model_scale"), 1.3)

		var_72_1:setScale(STANDARD_SCALE * var_72_2 * self:getDirection(), STANDARD_SCALE * var_72_2)

		local var_72_3 = self.skeleton:getRootPosition()

		var_72_1:setPosition(cc.p(var_72_3.x * STANDARD_SCALE * self:getAttribute("model_scale") * self._direction + arg_72_3 * self._size.width * self:getDirection(), var_72_3.y * STANDARD_SCALE * self:getAttribute("model_scale") + arg_72_4 * self._size.height))
		self:addChild(var_72_1, arg_72_5)
		var_72_1:play(arg_72_2)
		var_72_1:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())

		self.buff_effect_tbl[var_72_0].effect = var_72_1
		self.buff_effect_tbl[var_72_0].offset = cc.p(arg_72_3 * self._size.width * self:getDirection(), arg_72_4 * self._size.height)
	end

	self.buff_effect_tbl[var_72_0].effect:setVisible(true)

	return var_72_0
end

function FightCharacter:removeBuffEffect(arg_73_1)
	if self.buff_effect_tbl[arg_73_1] then
		self.buff_effect_tbl[arg_73_1].count = self.buff_effect_tbl[arg_73_1].count - 1

		if self.buff_effect_tbl[arg_73_1].count <= 0 then
			self.buff_effect_tbl[arg_73_1].effect:runAction(cc.RemoveSelf:create())

			self.buff_effect_tbl[arg_73_1] = nil
		end
	end
end

function FightCharacter:showBuffEffect()
	for iter_74_0, iter_74_1 in pairs(self.buff_effect_tbl) do
		iter_74_1.effect:setVisible(true)
	end
end

function FightCharacter:hideBuffEffect()
	for iter_75_0, iter_75_1 in pairs(self.buff_effect_tbl) do
		iter_75_1.effect:setVisible(false)
	end
end

local total_skill_data = require("data.total_skill_data")

function FightCharacter:playHorcruxTriggerEffect(arg_76_1, arg_76_2)
	if not self._assist then
		return
	end

	if FightManager.isNormalFight() and not FightManager.isBigBossFight() then
		return
	end

	if self.charactertype ~= "player" then
		return
	end

	for iter_76_0 = 1, #self._assist._skills do
		while total_skill_data[self._assist._skills[iter_76_0]]["skill" .. 1] do
			if total_skill_data[self._assist._skills[iter_76_0]]["skill" .. 1] == arg_76_1 and not total_skill_data[self._assist._skills[iter_76_0]].enter_trigger then
				local var_76_1 = cc.EventCustom:new("triggerHorcrux")

				var_76_1.modelid = self._assist._id
				var_76_1.skillid = self._assist._skills[iter_76_0]

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_76_1)

				break
			end
		end
	end
end

local FightContract = require("fight.fightstatus.FightContract")

function FightCharacter.beContracted(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	arg_77_0._contracted = FightContract.new(arg_77_1, arg_77_2, arg_77_3)
end

function FightCharacter.removeContracted(arg_78_0)
	arg_78_0._contracted = nil
end

local FightBear = require("fight.fightstatus.FightBear")

function FightCharacter.beBear(arg_79_0, arg_79_1, arg_79_2)
	arg_79_0._bear = FightBear.new(arg_79_1, arg_79_2)
end

function FightCharacter.removeBear(arg_80_0)
	arg_80_0._bear = nil
end
