-- chunkname: @modules/logic/fight/view/FightViewHandCardItemLock.lua

module("modules.logic.fight.view.FightViewHandCardItemLock", package.seeall)

local FightViewHandCardItemLock = class("FightViewHandCardItemLock", LuaCompBase)

function FightViewHandCardItemLock:ctor(subViewInst)
	self._subViewInst = subViewInst
end

function FightViewHandCardItemLock:init(go)
	self.go = go
	self.tr = go.transform
	self._lockGO = gohelper.findChild(self.go, "foranim/lock")

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnFightReconnect, self._onFightReconnect, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforePlayHandCard, self._beforePlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self._afterPlayHandCard, self)
end

function FightViewHandCardItemLock:removeEventListeners()
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnFightReconnect, self._onFightReconnect, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforePlayHandCard, self._beforePlayHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self._afterPlayHandCard, self)
	TaskDispatcher.cancelTask(self._reconnectSetCardLock, self)
end

function FightViewHandCardItemLock:updateItem(cardInfoMO)
	self.cardInfoMO = cardInfoMO or self.cardInfoMO

	local skillCO = lua_skill.configDict[cardInfoMO.skillId]

	if not skillCO then
		logError("skill not exist: " .. cardInfoMO.skillId)

		return
	end

	self._skillId = cardInfoMO.skillId

	local entityMO = FightDataHelper.entityMgr:getById(self.cardInfoMO.uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMO)

	self._canUse = FightViewHandCardItemLock.canUseCardSkill(self.cardInfoMO.uid, self.cardInfoMO.skillId)

	FightViewHandCardItemLock.setCardLock(self.cardInfoMO.uid, self.cardInfoMO.skillId, self._lockGO, false, buffList)
	self:_setCardPreRemove(false, buffList)
end

function FightViewHandCardItemLock:_onBuffUpdate(entityId, effectType, buffId)
	if not self.cardInfoMO then
		return
	end

	if entityId ~= self.cardInfoMO.uid then
		return
	end

	local canUse = FightViewHandCardItemLock.canUseCardSkill(entityId, self.cardInfoMO.skillId)

	if effectType == FightEnum.EffectType.BUFFADD then
		if self._canUse then
			FightViewHandCardItemLock.setCardLock(self.cardInfoMO.uid, self.cardInfoMO.skillId, self._lockGO, self._canUse)
		end
	elseif effectType == FightEnum.EffectType.BUFFDEL then
		FightViewHandCardItemLock.setCardLock(self.cardInfoMO.uid, self.cardInfoMO.skillId, self._lockGO, false)
	end

	self._canUse = canUse
end

function FightViewHandCardItemLock:_onFightReconnect()
	TaskDispatcher.runDelay(self._reconnectSetCardLock, self, 1)
end

local SkillLockStatus = {}
local SkillPreRemoveStatus = {}

function FightViewHandCardItemLock:_beforePlayHandCard()
	local entityMO = FightDataHelper.entityMgr:getById(self.cardInfoMO.uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMO)

	SkillLockStatus[self.cardInfoMO.skillId] = FightViewHandCardItemLock.canUseCardSkill(self.cardInfoMO.uid, self.cardInfoMO.skillId, buffList)
	SkillPreRemoveStatus[self.cardInfoMO.skillId] = FightViewHandCardItemLock.canPreRemove(self.cardInfoMO.uid, self.cardInfoMO.skillId, nil, buffList)
end

function FightViewHandCardItemLock:_afterPlayHandCard()
	local entityMO = FightDataHelper.entityMgr:getById(self.cardInfoMO.uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMO)

	FightViewHandCardItemLock.setCardLock(self.cardInfoMO.uid, self.cardInfoMO.skillId, self._lockGO, false, buffList)

	local oldLock = SkillLockStatus[self.cardInfoMO.skillId]
	local oldPreRemove = SkillPreRemoveStatus[self.cardInfoMO.skillId]
	local newLock = FightViewHandCardItemLock.canUseCardSkill(self.cardInfoMO.uid, self.cardInfoMO.skillId, buffList)
	local newPreRemove = FightViewHandCardItemLock.canPreRemove(self.cardInfoMO.uid, self.cardInfoMO.skillId, nil, buffList)
	local canPlayPreRemove = oldLock == false and newLock == false and (oldPreRemove == nil or oldPreRemove == false) and newPreRemove == true

	if canPlayPreRemove then
		self:_setCardPreRemove(true, buffList)
	end

	if oldLock == newLock and oldPreRemove == newPreRemove and newPreRemove and not newLock then
		self:_setCardPreRemove(false, buffList)
	end
end

function FightViewHandCardItemLock:_reconnectSetCardLock()
	FightViewHandCardItemLock.setCardLock(self.cardInfoMO.uid, self.cardInfoMO.skillId, self._lockGO, false)
end

local TxtPaths = {
	"txtLockName",
	"normal/0/seal/ani/txtLockName",
	"normal/0/unseal/ani/txtLockName",
	"normal/0/sealing/ani/txtLockName",
	"normal/1/seal/ani/txtLockName",
	"normal/1/unseal/ani/txtLockName",
	"normal/1/sealing/ani/txtLockName",
	"normal/2/seal/ani/txtLockName",
	"normal/2/unseal/ani/txtLockName",
	"normal/2/sealing/ani/txtLockName",
	"normal/3/seal/ani/txtLockName",
	"normal/3/unseal/ani/txtLockName",
	"normal/3/sealing/ani/txtLockName",
	"bigskill/4/seal/ani/txtLockName",
	"bigskill/4/unseal/ani/txtLockName",
	"bigskill/4/sealing/ani/txtLockName",
	"normal/0/seal/notani/txtLockName",
	"normal/0/unseal/notani/txtLockName",
	"normal/0/sealing/notani/txtLockName",
	"normal/1/seal/notani/txtLockName",
	"normal/1/unseal/notani/txtLockName",
	"normal/1/sealing/notani/txtLockName",
	"normal/2/seal/notani/txtLockName",
	"normal/2/unseal/notani/txtLockName",
	"normal/2/sealing/notani/txtLockName",
	"normal/3/seal/notani/txtLockName",
	"normal/3/unseal/notani/txtLockName",
	"normal/3/sealing/notani/txtLockName",
	"bigskill/4/seal/notani/txtLockName",
	"bigskill/4/unseal/notani/txtLockName",
	"bigskill/4/sealing/notani/txtLockName"
}

function FightViewHandCardItemLock.setCardLock(entityId, skillId, lockGO, hasAnim, buffList, roundOp)
	gohelper.setActive(lockGO, false)

	if gohelper.isNil(lockGO) or not skillId then
		return
	end

	if FightHelper.checkIsDevicePowerCard(skillId) then
		return
	end

	if FightEnum.UniversalCard[skillId] then
		return
	end

	local canUse = FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, buffList, roundOp)

	gohelper.setActive(lockGO, not canUse)

	if not canUse then
		local skillCO = lua_skill.configDict[skillId]
		local isBigSkill = skillCO.isBigSkill == 1

		if lua_skill_next.configDict[skillId] then
			isBigSkill = false
		end

		local skillLv = FightCardDataHelper.getSkillLv(entityId, skillId)
		local buffCO = FightViewHandCardItemLock._getCardLockReason(entityId, skillId, buffList, roundOp)
		local normalGO = gohelper.findChild(lockGO, "normal")
		local bigskillGO = gohelper.findChild(lockGO, "bigskill")

		gohelper.setActive(normalGO, not isBigSkill)
		gohelper.setActive(bigskillGO, isBigSkill)

		for i = 0, 4 do
			local levelGO = gohelper.findChild(i == FightEnum.UniqueSkillCardLv and bigskillGO or normalGO, tostring(i))

			gohelper.setActive(levelGO, i == skillLv)

			if i == skillLv then
				local animName = hasAnim and "fight_lock_seal_all" or "fight_lock_seal_allnot"
				local animator = levelGO:GetComponent(typeof(UnityEngine.Animator))

				animator:Play(animName, 0, 0)
				animator:Update(0)
			end
		end

		local name = FightViewHandCardItemLock.getLockBuffName(buffCO)

		for _, goPath in ipairs(TxtPaths) do
			local txtLockName = gohelper.findChildText(lockGO, goPath)

			if txtLockName then
				txtLockName.text = name
			end
		end

		return true
	end
end

function FightViewHandCardItemLock.getLockBuffName(buffCo)
	if buffCo then
		if not buffCo.name then
			local name = ""

			name = LuaUtil.getCharNum(name) <= 2 and name or LuaUtil.subString(name, 1, 2) .. "\n" .. LuaUtil.subString(name, 3)

			return name
		end
	end
end

function FightViewHandCardItemLock:_setCardPreRemove(hasAnim, buffList)
	local skillId = self.cardInfoMO.skillId

	if FightEnum.UniversalCard[skillId] then
		return
	end

	if gohelper.isNil(self.go) then
		return
	end

	local entityId = self.cardInfoMO.uid
	local canUse = FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, buffList)

	if canUse then
		return
	end

	local isPreRemove = FightViewHandCardItemLock.canPreRemove(entityId, skillId, nil, buffList)

	if not isPreRemove then
		return
	end

	FightViewHandCardItemLock.setCardPreRemove(entityId, skillId, self._lockGO, hasAnim)
end

function FightViewHandCardItemLock.setCardPreRemove(entityId, skillId, lockGO, hasAnim)
	local isBigSkill = FightCardDataHelper.isBigSkill(skillId)
	local skillLv = FightCardDataHelper.getSkillLv(entityId, skillId)
	local normalGO = gohelper.findChild(lockGO, "normal")
	local bigskillGO = gohelper.findChild(lockGO, "bigskill")

	gohelper.setActive(normalGO, not isBigSkill)
	gohelper.setActive(bigskillGO, isBigSkill)

	for i = 0, 4 do
		local levelGO = gohelper.findChild(i == FightEnum.UniqueSkillCardLv and bigskillGO or normalGO, tostring(i))

		gohelper.setActive(levelGO, i == skillLv)

		if i == skillLv then
			local animName = hasAnim and "fight_lock_sealing_all" or "fight_lock_sealing_allnot"
			local animator = levelGO:GetComponent(typeof(UnityEngine.Animator))

			if animator then
				animator:Play(animName, 0, 0)
				animator:Update(0)
			end
		end
	end
end

function FightViewHandCardItemLock.setCardUnLock(entityId, skillId, lockGO)
	local skillCO = lua_skill.configDict[skillId]
	local isBigSkill = skillCO.isBigSkill == 1
	local skillLv = FightCardDataHelper.getSkillLv(entityId, skillId)
	local normalGO = gohelper.findChild(lockGO, "normal")
	local bigskillGO = gohelper.findChild(lockGO, "bigskill")

	gohelper.setActive(normalGO, not isBigSkill)
	gohelper.setActive(bigskillGO, isBigSkill)

	for i = 0, 4 do
		local levelGO = gohelper.findChild(i == FightEnum.UniqueSkillCardLv and bigskillGO or normalGO, tostring(i))

		gohelper.setActive(levelGO, i == skillLv)

		if i == skillLv then
			local animName = "fight_lock_unseal_all"
			local animator = levelGO:GetComponent(typeof(UnityEngine.Animator))

			if animator then
				animator:Play(animName, 0, 0)
				animator:Update(0)
			end
		end
	end
end

local AllType = {
	[102] = true,
	[101] = true
}
local SingleType = {
	true,
	[107] = true,
	[106] = true,
	[108] = true,
	[112] = true,
	[111] = true,
	[109] = true
}

function FightViewHandCardItemLock.canPreRemove(entityId, skillId, curPlayOp, buffList)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if FightBuffHelper.hasCastChannel(entityMO, buffList) then
		return false
	end

	if FightBuffHelper.hasFeature(entityMO, buffList, FightEnum.BuffFeature.Dream) and not FightCardDataHelper.isBigSkill(skillId) then
		return false
	end

	local cardOps = FightDataHelper.operationDataMgr:getOpList()

	for _, op in ipairs(cardOps) do
		if op == curPlayOp then
			return false
		end

		if op:isPlayCard() and op.clientSimulateCanPlayCard then
			local skillCo = lua_skill.configDict[op.skillId]
			local target = skillCo.logicTarget

			if (AllType[target] or SingleType[target] and entityId == op.toId and entityId ~= op.belongToEntityId) and FightBuffHelper.checkSkillCanPurifyBySkill(entityId, skillId, op.skillId, buffList, op.belongToEntityId) then
				return true
			end
		end
	end
end

local LockAllBuffType = {
	[FightEnum.BuffType_Dizzy] = true,
	[FightEnum.BuffType_Charm] = true,
	[FightEnum.BuffType_Petrified] = true,
	[FightEnum.BuffType_Sleep] = true,
	[FightEnum.BuffType_Frozen] = true,
	[FightEnum.BuffType_Freeze] = true,
	[FightEnum.BuffType_Disarm] = {
		true,
		true,
		bigSkill = false
	},
	[FightEnum.BuffType_Forbid] = {
		nil,
		nil,
		true,
		true,
		true,
		true,
		bigSkill = false
	},
	[FightEnum.BuffType_Seal] = {
		true,
		true,
		true,
		true,
		true,
		true,
		nil,
		nil,
		true,
		bigSkill = true
	},
	[FightEnum.BuffType_CastChannel] = true,
	[FightEnum.BuffFeature.Dream] = {
		bigSkill = true,
		reverse = true
	},
	[FightEnum.BuffType_NoneCastChannel] = true,
	[FightEnum.BuffType_ContractCastChannel] = true,
	[FightEnum.BuffType_AddCardCastChannel] = true,
	[FightEnum.BuffFeature.SpecialCountCastChannel] = true,
	[FightEnum.BuffFeature.NuoDiKaCastChannel] = true,
	[FightEnum.BuffFeature.UseSkillHasBuffCond] = {
		UseSkillHasBuffCond = true
	},
	[FightEnum.BuffFeature.ConsumeBuffLayerCastChannel] = true
}

function FightViewHandCardItemLock.canUseCardSkill(entityId, skillId, buffList, roundOp)
	if not entityId or not skillId then
		return false
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return true
	end

	if FightHelper.checkIsDevicePowerCard(skillId) then
		return true
	end

	local skillCO = lua_skill.configDict[skillId]

	for _, buffMO in ipairs(buffList or entityMO:getBuffList()) do
		local buffFeatures = FightConfig.instance:getBuffFeatures(buffMO.buffId)

		for featureType, value in pairs(buffFeatures) do
			if FightViewHandCardItemLock.isLockByLockBuffType(value, skillCO, entityId) then
				return false
			end
		end
	end

	if FightModel.instance:isBeContractEntity(entityId) then
		if buffList then
			local nanaEntityId = FightModel.instance.contractEntityUid

			if nanaEntityId then
				::label_16_0::

				local nanaEntityMo = FightDataHelper.entityMgr:getById(nanaEntityId)

				buffList = FightBuffHelper.simulateBuffList(nanaEntityMo, roundOp)

				if FightBuffHelper.hasFeature(nil, buffList, FightEnum.BuffType_ContractCastChannel) then
					return false
				end
			end
		elseif FightBuffHelper.checkCurEntityIsBeContractAndHasChannel(entityId) then
			return false
		end
	end

	return true
end

function FightViewHandCardItemLock.isLockByLockBuffType(feature, skillConfig, entityId)
	local isBigSkill = skillConfig.isBigSkill == 1
	local featureType = feature.featureType

	if featureType == FightEnum.BuffFeature.Dream and string.splitToNumber(feature.featureStr, "#")[2] == 1 then
		return false
	end

	local lockObj = LockAllBuffType[featureType]

	if lockObj == true then
		return true
	end

	if lockObj then
		if lockObj.reverse then
			if isBigSkill then
				if not lockObj.bigSkill then
					return true
				end
			elseif not lockObj[skillConfig.effectTag] then
				return true
			end
		elseif lockObj.UseSkillHasBuffCond then
			local ids = FightStrUtil.instance:getSplitToNumberCache(feature.featureStr, "#")

			for i = 3, #ids do
				if ids[i] == skillConfig.id then
					local entity = FightHelper.getEntity(entityId)

					if entity and entity.buff and not entity.buff:haveBuffTypeId(ids[2]) then
						return true
					end
				end
			end
		else
			if isBigSkill and lockObj.bigSkill then
				return true
			end

			if lockObj[skillConfig.effectTag] == true and lockObj.bigSkill == isBigSkill then
				return true
			end
		end
	end
end

function FightViewHandCardItemLock._getCardLockReason(entityId, skillId, buffList, roundOp)
	if not entityId or not skillId then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	local skillCO = lua_skill.configDict[skillId]
	local lockBuffMO, curPriority = FightViewHandCardItemLock.getLockBuffMo(entityMO, buffList, skillCO)

	if FightModel.instance:isBeContractEntity(entityId) then
		local nanaEntityId = FightModel.instance.contractEntityUid

		if nanaEntityId then
			::label_18_0::

			local nanaEntityMo = FightDataHelper.entityMgr:getById(nanaEntityId)

			buffList = FightBuffHelper.simulateBuffList(nanaEntityMo, roundOp)
			lockBuffMO, curPriority = FightViewHandCardItemLock.getLockBuffMo(nanaEntityMo, buffList, skillCO, lockBuffMO, curPriority)
		end
	end

	return lockBuffMO and lua_skill_buff.configDict[lockBuffMO.buffId]
end

function FightViewHandCardItemLock.getLockBuffMo(entityMo, buffList, skillCO, curBuffMo, curPriority)
	if not entityMo then
		return
	end

	curPriority = curPriority or -1
	buffList = buffList or entityMo:getBuffList()

	for _, buffMO in ipairs(buffList) do
		local buffFeatures = FightConfig.instance:getBuffFeatures(buffMO.buffId)

		for featureType, value in pairs(buffFeatures) do
			if FightViewHandCardItemLock.isLockByLockBuffType(value, skillCO, entityMo.id) then
				if not FightEnum.CardLockPriorityDict[featureType] then
					if not curBuffMo then
						curBuffMo = buffMO
						curPriority = FightEnum.CardLockPriorityDict[featureType]
					elseif curPriority < FightEnum.CardLockPriorityDict[featureType] or FightEnum.CardLockPriorityDict[featureType] == curPriority and tonumber(buffMO.uid) > tonumber(curBuffMo.uid) then
						curBuffMo = buffMO
						curPriority = FightEnum.CardLockPriorityDict[featureType]
					end
				end
			end
		end
	end

	return curBuffMo, curPriority
end

function FightViewHandCardItemLock.logSkill(skillId, message)
	local skillCo = lua_skill.configDict[skillId]

	logError(string.format("%s : %s", skillCo.name, message))
end

return FightViewHandCardItemLock
