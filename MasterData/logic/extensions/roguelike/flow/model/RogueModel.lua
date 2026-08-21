-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/model/RogueModel.lua

module("logic.extensions.roguelike.flow.model.RogueModel", package.seeall)

local M = class("RogueModel", IRogueFlowComp)

function M:onInit()
	self._rogueFieldInfo = false
	self._roleMos = false
	self._isRoundFinish = false
	self._extraResult = nil
	self._roleId2Prop = {}
	self._isRestore = false
	self._inExitEvent = false
end

function M:onStart()
	self._unitMgr = self.flow.unitMgr
end

function M:onClear()
	self._rogueFieldInfo = false
	self._roleMos = false
	self._isRoundFinish = false
	self._extraResult = nil
	self._roleId2Prop = {}
	self._isRestore = false
	self._inExitEvent = false

	RoguelikeModel.instance:setEnterRoleStates()
	RogueExploreModel.instance:setState(nil)
	RoguelikeAgent.instance:clearPropCodes()
end

function M:setRoleSelectProp(roleId, prop)
	self._roleId2Prop[roleId] = prop
end

function M:setSelectProp(prop)
	self._selectProp = prop
end

function M:setInExitEvent(inExitEvent)
	self._inExitEvent = inExitEvent
end

function M:getInExitEvent()
	return self._inExitEvent
end

function M:getSelectProp()
	return self._selectProp
end

function M:setRogueFieldInfo(fieldInfo)
	self._rogueFieldInfo = RogueFieldInfo:createInstance()

	local roleIds = fieldInfo.roleIds

	self._roleMos = {}

	for idx, v in ipairs(roleIds) do
		local roleInfo = {}

		roleInfo.entityCode = v
		roleInfo.idx = idx

		local roleMo = self._unitMgr:createRoleUnit(roleInfo)

		table.insert(self._roleMos, roleMo)

		local position = Vector3.New(-20, 0, -10 + (idx - 1) * 8)

		roleMo.transform:setPosition(position)
		roleMo.transform:setActive(false)
		roleMo.infoBar:setVisible(false)
		self._rogueFieldInfo:addRoleMo(roleMo)
	end
end

function M:updateRoleSort()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	function changeIndex(index, changeIndex)
		local temp = self._roleMos[index]

		self._roleMos[index] = self._roleMos[changeIndex]
		self._roleMos[changeIndex] = temp
	end

	function getCurIndex(roleId)
		for k, v in pairs(self._roleMos) do
			if v.roleProp:getRoleId() == roleId then
				return k
			end
		end

		return 1
	end

	for k, v in ipairs(allRoleState) do
		local entityInfo = {}

		entityInfo.entityCode = v.code

		RogueUnitGenerator.setRoleInfo(self._roleMos[k], entityInfo)
	end
end

function M:getAllRoleMos()
	return self._roleMos
end

function M:setRoundFinish(isFinish)
	self._isRoundFinish = isFinish
end

function M:getRoundFinish()
	return self._isRoundFinish
end

function M:setInAttack(isAttack)
	self._isInAttack = isAttack
end

function M:getInAttack()
	return self._isInAttack
end

function M:setJudgeResult(isWin)
	self._judgeResult = isWin

	if not RogueMgr.instance:getIsClientMode() then
		if RoguelikeConst.GetIsEventJudgeQuick() then
			RogueMgr.instance:getRogueFlow().judgeMgr:saveJudgeArchive(true, true)
		end

		local type = self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT and 1 or 2

		RoguelikeAgent.instance:sendEndJudgeRequest(type, isWin)
		RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive()
	end

	RogueMgr.instance:getRogueFlow().judgeModel:setRoleDiceWall(0)
	RogueMgr.instance:getRogueFlow().judgeMgr:setCombatDiceFeatures(nil)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_MONSTER_COMBAT_END)
end

function M:getJudgeResult()
	return self._judgeResult
end

function M:setCurMonster(monsterId)
	local roleInfo = {}

	roleInfo.entityCode = monsterId

	local monsterMo = self._unitMgr:createMonsterUnit(roleInfo)
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local position = Vector3.New(pos.x + 5 * kMapItemSize, 0, pos.z + 1.25 * kMapItemSize)

	monsterMo.transform:setPosition(position)
	monsterMo.meshModel:setDirection(UnitSpineDir.Right)

	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil then
		local enemyId = judgeArchive.enemyId

		if judgeArchive.type == RoguelikeExtension_pb.JudgeType.FIGHT and judgeArchive.enemyOuterHp ~= 0 and enemyId == monsterId then
			monsterMo.monsterProp:setHp(judgeArchive.enemyOuterHp, true)
		end
	else
		RogueMgr.instance:getRogueFlow().judgeMgr:setFeaturePatterns(nil)
	end

	self._rogueFieldInfo:setCurMonsterMo(monsterMo)
end

function M:getCurMonster()
	return self._rogueFieldInfo:getCurMonsterMo()
end

function M:setCurEventType(eventType)
	self._eventType = eventType

	local eventInfo = {}

	eventInfo.eventType = eventType

	if eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

		eventInfo.replyCo = replyCo

		if RogueMgr.instance:getNeedShowDice() then
			local eventMo = self._unitMgr:createEventUnit(eventInfo)
			local mapMgr = RogueMgr.instance:getMapMgr()
			local pos = mapMgr:getMapRolePos()
			local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
			local position = Vector3.New(pos.x + 5 * kMapItemSize, 0, pos.z + 1.25 * kMapItemSize)

			eventMo.transform:setPosition(position)
			eventMo.meshModel:setDirection(UnitSpineDir.Right)

			self._curEventMo = eventMo
		end
	end
end

function M:getCurEventMo()
	return self._curEventMo
end

function M:getCurEventType()
	return self._eventType or RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT
end

function M:getIsEventJudge()
	return self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT or self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT or self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT
end

function M:setCurRoleIndex(roleIndex)
	self._curRoleIndex = roleIndex

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHANGE_ROLE, self._curRoleIndex)
end

function M:getCurRoleIndex()
	return self._curRoleIndex
end

function M:getCurRoleMo()
	if not self._roleMos[self._curRoleIndex] then
		print("找不到角色", self._curRoleIndex)

		return self._roleMos[1].roleProp
	end

	return self._roleMos[self._curRoleIndex].roleProp
end

function M:getCurRoleUnit()
	if not self._roleMos[self._curRoleIndex] then
		print("找不到角色", self._curRoleIndex)

		return self._roleMos[1]
	end

	return self._roleMos[self._curRoleIndex]
end

function M:getCurRoleSpine()
	if not self._roleMos[self._curRoleIndex] then
		print("找不到角色", self._curRoleIndex)

		return self._roleMos[1].meshModel
	end

	return self._roleMos[self._curRoleIndex].meshModel
end

function M:getRoleMoByIndex(index)
	return self._roleMos[index].roleProp
end

function M:getRoleMoByRoleId(roleId)
	for k, v in pairs(self._roleMos) do
		if v.roleProp:getRoleId() == roleId then
			return v
		end
	end
end

function M:getRoleIndexByRoleId(roleId)
	for k, v in pairs(self._roleMos) do
		if v.roleProp:getRoleId() == roleId then
			return k
		end
	end

	return 1
end

function M:attackAllRole(attack)
	for k, v in pairs(self._roleMos) do
		v.roleProp:reduceHp(attack)
	end
end

function M:attackAllRoleSan(sanAttack)
	for k, v in pairs(self._roleMos) do
		v.roleProp:reduceSan(sanAttack)
	end
end

function M:randAttackRole(attack)
	local temp = {}

	for k, v in pairs(self._roleMos) do
		if not v.roleProp:getIsDeath() then
			table.insert(temp, v.roleProp)
		end
	end

	if #temp > 0 then
		temp[math.random(1, #temp)]:reduceHp(attack)
	end
end

function M:randSanAttackRole(sanAttack)
	local temp = {}

	for k, v in pairs(self._roleMos) do
		if not v.roleProp:getIsDeath() then
			table.insert(temp, v.roleProp)
		end
	end

	if #temp > 0 then
		temp[math.random(1, #temp)]:reduceSan(sanAttack)
	end
end

function M:setNextRoleIndex()
	self._curRoleIndex = self:getNextRoleIndex()

	if self._curRoleIndex ~= 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHANGE_ROLE, self._curRoleIndex)
	end

	return self._curRoleIndex
end

function M:getNextRoleIndex()
	self:checkIsFinish()

	local idx = 0

	for i = self._curRoleIndex + 1, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			idx = i

			return idx
		end
	end

	return idx
end

function M:checkIsFinish()
	local isAllDeath = true

	for k, v in pairs(self._roleMos) do
		if not v.roleProp:getIsDeath() then
			isAllDeath = false
		end
	end

	if isAllDeath then
		self._isRoundFinish = true

		self:setJudgeResult(false)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Role_All_Death")
		local msg = string.format(format)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end
end

function M:checkIsLastOne()
	if self._isRoundFinish or self._curRoleIndex >= #self._roleMos or self._curRoleIndex == 0 then
		return true
	end

	for i = self._curRoleIndex + 1, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			return false
		end
	end

	return true
end

function M:setFirstActiveRoleIndex()
	local firstIndex = self:getFirstActiveRoleIndex()

	if firstIndex == 0 then
		FloatWordMgr.instance:show("全部角色阵亡")

		return 0
	end

	self:setCurRoleIndex(firstIndex)

	return firstIndex
end

function M:clearRestoreIndex()
	self._restoreIndex = nil
end

function M:getRestoreRoleIndex()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil then
		local index

		for i = 1, #self._roleMos do
			local roleProp = self._roleMos[i].roleProp

			if roleProp:getRoleId() == judgeArchive.heroId then
				index = i

				if not judgeArchive.isJudged and not roleProp:getIsDeath() then
					self._isRestore = true
					self._restoreIndex = i

					return i
				end
			elseif index ~= nil and not roleProp:getIsDeath() then
				self._isRestore = true
				self._restoreIndex = i

				return i
			end
		end

		for i = 1, #self._roleMos do
			if not self._roleMos[i].roleProp:getIsDeath() then
				return i
			end
		end
	else
		return nil
	end
end

function M:getIsFirstRoleIndex()
	return self._curRoleIndex == self:getFirstActiveRoleIndex()
end

function M:getIsFirstRondRoleIndex()
	for i = 1, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			return self._curRoleIndex == i
		end
	end

	return false
end

function M:getBehindActiveRoleCount(roleIndex)
	local count = 0

	for i = roleIndex, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			count = count + 1
		end
	end

	return count
end

function M:getFirstActiveRoleIndex()
	local restoreIndex = self:getRestoreRoleIndex()

	if restoreIndex ~= nil then
		return restoreIndex
	end

	for i = 1, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			return i
		end
	end

	return 0
end

function M:getCaptainIndex()
	if not self._roleMos then
		return 1
	end

	for i = 1, #self._roleMos do
		if not self._roleMos[i].roleProp:getIsDeath() then
			return i
		end
	end

	return 1
end

function M:getActiveRoleMo()
	local nextIndex = self._roleMos[self._curRoleIndex] and self._roleMos[self._curRoleIndex].roleProp:getIsDeath() and self:getNextRoleIndex() or self._curRoleIndex

	if nextIndex ~= 0 then
		if self._roleMos[nextIndex].roleProp:getIsDeath() then
			self:setNextRoleIndex()

			return self:getActiveRoleMo()
		end

		return self._roleMos[nextIndex].roleProp
	end

	return nil
end

function M:setExtraResult(extraResult)
	self._extraResult = extraResult

	if extraResult ~= nil then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_HAD_EXTRA_RESULT, extraResult)
	end
end

function M:getExtraResult()
	return self._extraResult
end

function M:setPlayerDicePos(pos)
	self._playerDicePos = pos
end

function M:getPlayerDicePos()
	return self._playerDicePos or Vector3.zero
end

function M:setCurEventId(eventId)
	self._eventId = eventId
end

function M:getCurEventId()
	return self._eventId
end

function M:setRectifyProp(prop)
	self._rectifyProp = prop

	self:setSelectProp(prop)
end

function M:getRectifyProp()
	return self._rectifyProp
end

function M:setRectifyRoleIndex(index)
	self._rectifyIndex = index
	self._curRoleIndex = index
end

function M:getRectifyRoleIndex()
	return self._rectifyIndex
end

function M:setEventProp(prop)
	self._eventProp = prop

	self:setSelectProp(prop)
end

function M:getEventProp()
	return self._eventProp
end

function M:setCurReplyCo(co)
	self._replyCo = co
end

function M:getCurReplyCo()
	return self._replyCo
end

function M:setEventChangeDifficulty(difficulty)
	self._eventChangeDifficulty = difficulty
end

function M:getEventChangeDifficulty()
	return (self._eventChangeDifficulty or 0) + RoguelikeModel.instance:getEventDiffAdd()
end

function M:setMonsterChangeFight(fight)
	self._monsterChangeFight = fight
end

function M:getMonsterChangeFight()
	return (self._monsterChangeFight or 0) + RoguelikeModel.instance:getMonsterDiffAdd()
end

function M:getCurEventProp()
	local eventId = self:getCurEventId()
	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
	local weakness = {}
	local prop = self:getEventProp()

	if prop ~= nil then
		weakness = {
			prop
		}
	end

	local eventProp = weakness[1]

	if eventProp == nil then
		printWarn("当前事件没有属性", eventId)

		eventProp = 1
	end

	return eventProp
end

function M:clearTempData()
	self._eventProp = nil
	self._rectifyIndex = nil
	self._rectifyProp = nil
	self._eventId = nil
end

function M:getMonsterHeadPos()
	return self._monsterHeadPos
end

function M:setMonsterHeadPos(pos)
	self._monsterHeadPos = pos
end

function M:setMonsterDiceItems(items)
	self._monsterDiceItems = items
end

function M:getMonsterDiceItems()
	return self._monsterDiceItems
end

function M:getTopMonsterDiceItem()
	local item = self._monsterDiceItems[#self._monsterDiceItems]

	return item
end

function M:setInSettlement(inSettlement)
	self._inSettlement = inSettlement
end

function M:getInSettlement()
	local temp = self._inSettlement

	self._inSettlement = false

	return temp
end

function M:setCurMonsterId(monsterId)
	self._curMonsterId = monsterId

	if monsterId then
		self:setMeetMonsterId(monsterId)
	end
end

function M:getCurMonsterId()
	return self._curMonsterId
end

function M:setMeetMonsterId(monsterId)
	self._meetMonsterId = monsterId
end

function M:getMeetMonsterId()
	return self._meetMonsterId
end

function M:setCurEventInfo(info)
	self._eventInfo = info
end

function M:getCurEventInfo()
	return self._eventInfo
end

function M:setCurProp()
	if self._allProps and #self._allProps > 0 then
		for k, v in pairs(self._allProps) do
			v:destroy()
		end
	end

	self._allProps = {}

	local allProp = RoguelikeModel.instance:getAllPropNOs() or {}

	for k, v in ipairs(allProp) do
		local propInfo = {}

		propInfo.propId = v.code

		local propMo = self._unitMgr:createPropUnit(propInfo)

		table.insert(self._allProps, propMo)
	end

	local allRoleSkills = {}
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

	for k, v in pairs(roleMos) do
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(v.roleProp:getRoleId())

		if heroMO then
			local skillIds = heroMO:getRoguelikeSkillIds()
			local isUnlock = RoguelikeConfig.instance:getRoguelikeRoleSkillUnlock(v.roleProp:getRoleId()) and RoguelikeModel.instance:getSkillOpen(v.roleProp:getRoleId())

			if isUnlock then
				for k1, v1 in pairs(skillIds) do
					table.insert(allRoleSkills, v1)
				end
			end
		end
	end

	if #allRoleSkills > 0 then
		local propInfo = {}

		propInfo.id = 1

		local normalUnit = self._unitMgr:createNormalBuffUnit(propInfo, allRoleSkills)

		table.insert(self._allProps, normalUnit)
	end

	local allEquip = RoguelikeModel.instance:getCurEquipMOS() or {}

	for k, v in ipairs(allEquip) do
		local propInfo = {}

		propInfo.equipId = v:getId()
		propInfo.level = v:getLevel()

		local propMo = self._unitMgr:createPropUnit(propInfo)

		table.insert(self._allProps, propMo)
	end

	local diffBuffs = RoguelikeModel.instance:getCurDiffBuffIds()

	if diffBuffs then
		local propInfo = {}

		propInfo.id = 1

		local normalUnit = self._unitMgr:createNormalBuffUnit(propInfo, diffBuffs)

		table.insert(self._allProps, normalUnit)
	end

	return self._allProps
end

function M:getAllProp()
	return self._allProps
end

function M:getConditionEffect(program)
	for k, v in pairs(self._allProps or {}) do
		local trigger, params = v:triggerByProgram(program)

		if trigger then
			return true, params
		end
	end

	return false
end

return M
