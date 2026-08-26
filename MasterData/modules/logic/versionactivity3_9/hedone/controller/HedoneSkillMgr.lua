-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneSkillMgr.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneSkillMgr", package.seeall)

local HedoneSkillMgr = class("HedoneSkillMgr", BaseController)

function HedoneSkillMgr:onInit()
	return
end

function HedoneSkillMgr:onInitFinish()
	return
end

function HedoneSkillMgr:addConstEvents()
	return
end

function HedoneSkillMgr:reInit()
	return
end

function HedoneSkillMgr:onEnterGame()
	return
end

function HedoneSkillMgr:onUpdate(deltaTime, nowTime)
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local cdSkillUidList = playerMO and playerMO:getCDSkillUidList()

	if not cdSkillUidList then
		return
	end

	local monsterUidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Monster)
	local cdSkillCount = #cdSkillUidList

	for i = 1, cdSkillCount do
		local skillUid = cdSkillUidList[i]
		local skill = playerMO:getSkill(skillUid)

		if skill then
			self:_updateSkillRemainCD(skill, deltaTime)

			if (monsterUidList and #monsterUidList > 0 or nil) and true then
				self:_tryCastCDSkill(skill)
			end
		end
	end
end

function HedoneSkillMgr:playerAddSkill(skillId)
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local skillCD = HedoneConfig.instance:getHedoneSkillCd(skillId)
	local isCDSkill = skillCD and skillCD > 0

	if isCDSkill then
		local cdSkillUidList = playerMO:getCDSkillUidList()
		local cdSkillCount = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.CDSkillCount, false, true)

		if cdSkillUidList and cdSkillCount <= #cdSkillUidList then
			logError(string.format("HedoneSkillMgr:playerAddSkill error,cd skill count reach max"))

			return
		end
	end

	local skill = playerMO and playerMO:addSkill(skillId)

	if not skill then
		return
	end

	local skillUid = skill:getUid()

	HedoneTriggerMgr.instance:triggerSpecifiedSkill(skillUid, HedoneGameEnum.TriggerPoint.None)
	self:dispatchEvent(HedoneEvent.OnPlayerAddSkill)
end

function HedoneSkillMgr:getNewSkillList()
	local rareItemList = self:_getNewSkillRareItemList()

	if not rareItemList or #rareItemList <= 0 then
		return
	end

	local resultList = {}

	local function getRareWeightFunc(rareItem)
		return rareItem.weight
	end

	local function getSkillWeightFunc(skillId)
		return HedoneConfig.instance:getHedoneSkillWeight(skillId)
	end

	local remainNewSkillCount = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.NewSkillCount, false, true)

	while remainNewSkillCount > 0 do
		local randomRareItem = HedoneGameHelper.getWeightedRandomPick(rareItemList, getRareWeightFunc)

		if not randomRareItem then
			break
		end

		local pickedList = {}
		local rare = randomRareItem.rare
		local canPickSkillIdList = self:_getCanPickSkillIdListByRare(rare)
		local canPickSkillCount = #canPickSkillIdList

		if remainNewSkillCount < canPickSkillCount then
			pickedList = HedoneGameHelper.getWeightedRandomPickList(canPickSkillIdList, remainNewSkillCount, getSkillWeightFunc)
		else
			pickedList = canPickSkillIdList
			randomRareItem.weight = 0
		end

		local pickedCount = #pickedList

		if pickedCount == 0 then
			randomRareItem.weight = 0
		end

		local resultLen = #resultList

		for i = 1, pickedCount do
			resultList[resultLen + i] = pickedList[i]
		end

		remainNewSkillCount = remainNewSkillCount - pickedCount
	end

	return resultList
end

function HedoneSkillMgr:_getNewSkillRareItemList()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local curPlayerLv = playerMO and playerMO:getCurLv() or 0
	local lv2RareArr = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.SkillRareRollWeight, false, false, "|")
	local strRareWeight

	for _, strLvRare in ipairs(lv2RareArr) do
		local data = string.split(strLvRare, "#")
		local needLv = tonumber(data[1])

		if needLv and needLv <= curPlayerLv then
			strRareWeight = data[2]
		end
	end

	if string.nilorempty(strRareWeight) then
		return
	end

	local rareItemList = {}
	local rareWeightArr = string.splitToNumber(strRareWeight, ",")

	for rare, weight in ipairs(rareWeightArr) do
		rareItemList[#rareItemList + 1] = {
			rare = rare,
			weight = weight
		}
	end

	return rareItemList
end

function HedoneSkillMgr:_getCanPickSkillIdListByRare(rare)
	local canPickSkillIdList = {}

	if rare then
		::label_12_0::

		local rareSkillIdList = HedoneConfig.instance:getHedoneSkillIdListByRare(rare)

		if rareSkillIdList and #rareSkillIdList > 0 then
			for _, skillId in ipairs(rareSkillIdList) do
				local isCanPick = self:_checkSkillCanPick(skillId)

				if isCanPick then
					canPickSkillIdList[#canPickSkillIdList + 1] = skillId
				end
			end
		end

		return canPickSkillIdList
	end
end

function HedoneSkillMgr:_checkSkillCanPick(skillId)
	local gameId = HedoneGameModel.instance:getGameId()
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not playerMO then
		return false
	end

	local skillCD = HedoneConfig.instance:getHedoneSkillCd(skillId)

	if skillCD and skillCD > 0 then
		local cdSkillUidList = playerMO:getCDSkillUidList()
		local cdSkillCount = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.CDSkillCount, false, true)

		if cdSkillUidList and cdSkillCount <= #cdSkillUidList then
			return false
		end
	end

	local unlockGameId = HedoneConfig.instance:getHedoneSkillUnlockGameId(skillId)

	if unlockGameId and gameId < unlockGameId then
		return false
	end

	local weight = HedoneConfig.instance:getHedoneSkillWeight(skillId)

	if not weight or weight <= 0 then
		return false
	end

	local isUnique = HedoneConfig.instance:getHedoneSkillIsUnique(skillId)

	if isUnique then
		local isHaveSkill = playerMO:getIsHaveSkill(skillId)

		if isHaveSkill then
			return false
		end
	end

	local conflictSkillList = HedoneConfig.instance:getHedoneSkillConflictSkillList(skillId)

	if conflictSkillList then
		for _, conflictSkillId in ipairs(conflictSkillList) do
			local isHaveSkill = playerMO:getIsHaveSkill(conflictSkillId)

			if isHaveSkill then
				return false
			end
		end
	end

	local needTypeCountList = HedoneConfig.instance:getHedoneSkillUnlockTypeCountList(skillId)

	if needTypeCountList then
		for _, countData in ipairs(needTypeCountList) do
			local skillType = countData.type
			local needCount = countData.count
			local skillIdList = playerMO:getSkillIdList(skillType)

			if skillIdList then
				if not #skillIdList then
					local haveCount = 0

					if haveCount < needCount then
						return false
					end
				end
			end
		end
	end

	return true
end

function HedoneSkillMgr:_updateSkillRemainCD(skill, deltaTime)
	local state = skill:getState()

	if state ~= HedoneGameEnum.SkillState.Cooldown then
		return
	end

	local skillUid = skill:getUid()

	skill:onUpdateRemainCD(deltaTime)
	self:dispatchEvent(HedoneEvent.RefreshSkillCDProgress, skillUid)
end

function HedoneSkillMgr:_tryCastCDSkill(skill)
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local canCast = skill and skill:getCDSkillCanCast()

	if not canCast or not playerMO then
		return
	end

	skill:setState(HedoneGameEnum.SkillState.Casting)

	local result = self:_castCDSkill(skill)

	if not result then
		skill:setState(HedoneGameEnum.SkillState.Ready)

		return
	end

	local skillType = skill:getSkillType()
	local comboRate = playerMO:getAttrValue(HedoneGameEnum.Attribute.ComboRate, skillType)
	local r = math.random()

	if r < comboRate then
		self:_castCDSkill(skill, true)
		HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterCDSkillCombo, skillType)
	end

	if skillType == HedoneGameEnum.Const.PlayAttackSkillType then
		HedoneGameController.instance:dispatchEvent(HedoneEvent.EntityPlayAnim, HedoneGameEnum.Const.PlayerUid, HedoneGameEnum.EntityAnimName.PlayerAttack)
	end
end

function HedoneSkillMgr:_castCDSkill(skill, isCombo)
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not skill or not playerMO then
		return
	end

	local skillType = skill:getSkillType()

	HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.CDSkillReady2Cast, skillType)

	local result = false
	local bulletCount = playerMO:getAttrValue(HedoneGameEnum.Attribute.SkillBulletCount, skillType) or 0
	local playerPos = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerXY, false, true, "#")
	local targetUidList, bulletDataList = self:_findSkillTargets(bulletCount, skill, playerPos[1], playerPos[2], nil, false, isCombo)

	if targetUidList and #targetUidList > 0 then
		result = true

		skill:enterCD()
		self:_executeCDSkill(skill, targetUidList, false, isCombo)
	elseif bulletDataList and #bulletDataList > 0 then
		result = true

		skill:enterCD()
		HedoneGameController.instance:addEntityList(bulletDataList)
	end

	playerMO:consumeBuffLife(HedoneGameEnum.BuffLifeRule.CDSkillCast, skillType)

	return result
end

function HedoneSkillMgr:_findSkillTargets(targetCount, skill, bulletStartX, bulletStartY, excludeTargetDict, isLinkBullet, isCombo)
	if not skill then
		return
	end

	local skillUid = skill:getUid()
	local skillId = skill:getId()
	local skillType = skill:getSkillType()
	local findTargetType = HedoneConfig.instance:getHedoneSkillFindTarget(skillId)
	local bulletRes

	if isLinkBullet then
		local needLinkBullet = HedoneConfig.instance:getHedoneSkillTypeIsNeedLinkBullet(skillType)

		if needLinkBullet then
			bulletRes = HedoneConfig.instance:getHedoneSkillBullet(skillId)
		end
	else
		bulletRes = HedoneConfig.instance:getHedoneSkillBullet(skillId)
	end

	local isNeedBullet = not string.nilorempty(bulletRes) and bulletStartX and bulletStartY
	local targetUidList = {}
	local bulletDataList = {}
	local targetUid2BulletDataDict = {}

	excludeTargetDict = excludeTargetDict or {}

	for _ = 1, targetCount do
		local targetUid = HedoneGameHelper.findTarget(findTargetType, nil, excludeTargetDict)

		if targetUid then
			if isNeedBullet then
				local bulletData = targetUid2BulletDataDict[targetUid]

				if bulletData then
					bulletData.executeCount = bulletData.executeCount + 1
				else
					bulletData = {
						executeCount = 1,
						id = skillId,
						posX = bulletStartX,
						posY = bulletStartY,
						entityType = HedoneGameEnum.EntityType.Bullet,
						skillUid = skillUid,
						targetUid = targetUid,
						isLinkBullet = isLinkBullet,
						isCombo = isCombo
					}
					bulletDataList[#bulletDataList + 1] = bulletData
					targetUid2BulletDataDict[targetUid] = bulletData
				end
			else
				targetUidList[#targetUidList + 1] = targetUid
			end

			HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterFindCDSkillEffectTarget, skillType, {
				targetUid = targetUid
			})
		end
	end

	return targetUidList, bulletDataList
end

function HedoneSkillMgr:onSkillBulletHit(bulletUid)
	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local bulletMO = HedoneGameModel.instance:getEntityMO(bulletUid, HedoneGameEnum.EntityType.Bullet)

	if not playerMO or not bulletMO then
		return
	end

	bulletMO:setHit()

	local skillUid = bulletMO:getBulletSkillUid()
	local targetUid = bulletMO:getBulletTargetUid()
	local isLinkBullet = bulletMO:getIsLinkBullet()
	local isCombo = bulletMO:getIsCombo()
	local skill = playerMO:getSkill(skillUid)

	self:_executeCDSkill2SingeTarget(skill, targetUid, isLinkBullet, isCombo)
	HedoneGameController.instance:removeEntity(bulletUid)
end

function HedoneSkillMgr:_executeCDSkill2SingeTarget(skill, targetUid, isAlreadyLinked, isCombo, executeCount)
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not skill or not targetUid or not playerMO then
		return
	end

	local skillUid = skill:getUid()

	executeCount = executeCount or 1

	for _ = 1, executeCount do
		self:_doCDSkillEffect(skillUid, targetUid, isCombo)

		if not isAlreadyLinked then
			self:_checkSkillLinkCount(skill, targetUid, isCombo)
		end
	end
end

function HedoneSkillMgr:_executeCDSkill(skill, targetUidList, isAlreadyLinked, isCombo)
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not skill or not targetUidList or #targetUidList <= 0 or not playerMO then
		return
	end

	local skillUid = skill:getUid()

	for _, targetUid in ipairs(targetUidList) do
		self:_doCDSkillEffect(skillUid, targetUid, isCombo)

		if not isAlreadyLinked then
			self:_checkSkillLinkCount(skill, targetUid, isCombo)
		end
	end
end

function HedoneSkillMgr:_doCDSkillEffect(skillUid, targetUid, isCombo)
	if not skillUid then
		return
	end

	local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)
	local isAlive = targetMO and targetMO:getIsAlive()

	if not isAlive then
		return
	end

	HedoneTriggerMgr.instance:triggerSpecifiedSkill(skillUid, HedoneGameEnum.TriggerPoint.None, nil, {
		targetUid = targetUid,
		isCombo = isCombo
	}, true)
end

function HedoneSkillMgr:_checkSkillLinkCount(skill, targetUid, isCombo)
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local skillType = skill:getSkillType()
	local linkCount = playerMO:getAttrValue(HedoneGameEnum.Attribute.SkillLinkCount, skillType) or 0

	if linkCount <= 0 then
		return
	end

	local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)
	local linkStartX, linkStartY = targetMO and targetMO:getPosition()
	local targetUidList, bulletDataList = self:_findSkillTargets(linkCount, skill, linkStartX, linkStartY, {
		[targetUid] = true
	}, true, isCombo)

	if targetUidList and #targetUidList > 0 then
		self:_executeCDSkill(skill, targetUidList, true, isCombo)
	elseif bulletDataList and #bulletDataList > 0 then
		HedoneGameController.instance:addEntityList(bulletDataList)
	end
end

function HedoneSkillMgr:onExitGame()
	return
end

HedoneSkillMgr.instance = HedoneSkillMgr.New()

return HedoneSkillMgr
