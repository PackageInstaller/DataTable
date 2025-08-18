-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\StateGroup.lua

local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local PropBoard = require("ClientData/PropBoard")
local StateTriggerData = require("ClientData/ResStateTrigger")
local StateSkillChangeData = require("ClientData/ResStateSkillChange")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResSkillToCard = require("ClientData/ResSkillToCard")
local ResSkillConditionEnhance = require("ClientData/ResSkillConditionEnhance")
local STATE_ATTR = BattleConst.STATE_CALC_ATTR
local ATTR_CONFIG = PropBoard.PROP_LEVELS
local SORTED_ATTR_LIST = {}

for pName, _ in pairs(STATE_ATTR) do
	table.insert(SORTED_ATTR_LIST, pName)
end

for pName, _ in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
	table.insert(SORTED_ATTR_LIST, pName)
end

table.sort(SORTED_ATTR_LIST)

local STATE_PROP_PREFIX = BattleConst.STATE_PROP_PREFIX
local EXCLUSIVE_TAUNT_TAG = "1"
local HOT_INTERVAL = 10
local State = Class("State")

function State:ctor(mgr, stateId, attackerId, cardId)
	self.mgr = mgr
	self.attackerId = attackerId
	self.nowCardId = cardId
	self.curFrameNum = 0
	self.stateId = stateId
	self.level = 0
	self.stateData = {}
	self.stateName = self.stateData.state_name or string.format(Lang.get(29928), self.stateId)
	self.stateDesc = self.stateData.state_name or Lang.get(29929)

	local tmpStateData = BattleStateData.getStateData(self.stateId, 1)

	if tmpStateData then
		self.exclusiveTag = tmpStateData.replaceTag
	end

	self.layer = 0
	self.layerInfo = {}
end

function State:isOver()
	return self.layer <= 0
end

local function SortLayerFunc(a, b)
	return b < a
end

function State:onAddState(level, delayTime)
	if delayTime ~= BattleConst.STATE_DURATION_UNLIMIT then
		delayTime = math.floor(delayTime * self.mgr.master.framePerSec)
		self.needTick = true
	else
		delayTime = BattleConst.STATE_DURATION_UNLIMIT_FRAME
	end

	self.level = level
	self.stateData = BattleStateData.getStateData(self.stateId, level)
	self.disableShowNum = self.stateData.disableShowNum and self.stateData.disableShowNum > 0
	self.stateMaxLayer = self.stateData.state_max_layer or 1

	if self.layer == 0 then
		self.mgr.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE, {
			self.attackerId,
			self.stateId,
			self.level
		})
	end

	table.insert(self.layerInfo, delayTime)
	table.sort(self.layerInfo, SortLayerFunc)

	for index = #self.layerInfo, self.stateMaxLayer + 1, -1 do
		self.layerInfo[index] = nil
	end

	self:_checkSkillLayer()
	self:_handleSkillDot()
end

function State:forceSetLayer(layer)
	layer = math.min(layer, self.stateMaxLayer)

	if layer == self.layer then
		return
	end

	if layer > #self.layerInfo then
		for index = #self.layerInfo, layer - 1 do
			table.insert(self.layerInfo, BattleConst.STATE_DURATION_UNLIMIT_FRAME)
		end
	else
		for index = #self.layerInfo, layer + 1, -1 do
			self.layerInfo[index] = nil
		end
	end

	table.sort(self.layerInfo, SortLayerFunc)
	self:_checkSkillLayer()
end

function State:extendStateTime(frameNum)
	for index, num in ipairs(self.layerInfo) do
		if num < BattleConst.STATE_DURATION_UNLIMIT_FRAME then
			self.layerInfo[index] = num + frameNum
		end
	end
end

function State:nextFrame()
	for index, num in ipairs(self.layerInfo) do
		if num < BattleConst.STATE_DURATION_UNLIMIT_FRAME then
			self.layerInfo[index] = num - 1
		end
	end

	if self.layerInfo[#self.layerInfo] and self.layerInfo[#self.layerInfo] <= 0 then
		self:_checkSkillLayer()
	end
end

function State:tickHot()
	self.curFrameNum = self.curFrameNum + 1

	if self.layer > 0 and (self.hot or self.dot) then
		if self.hot and self.curFrameNum % self.hot[3] == 0 then
			local attacker = self.mgr.master.mgr:getObjectIncludeAll(self.attackerId)
			local skillId = self.hot[1]
			local eventId = self.hot[2]
			local eventLevel = self.level

			if attacker then
				attacker:triggerSkillEvent(skillId, eventId, self.mgr.master.id, nil, eventLevel)
			end
		end

		if self.dot and self.curFrameNum % self.dot[3] == 0 then
			local attacker = self.mgr.master.mgr:getObjectIncludeAll(self.attackerId)
			local skillId = self.dot[1]
			local eventId = self.dot[2]
			local eventLevel = self.level

			if attacker then
				attacker:triggerSkillEvent(skillId, eventId, self.mgr.master.id, nil, eventLevel)
			end
		end
	end
end

function State:onStateOver()
	self.layerInfo = {}

	self:_checkSkillLayer()
end

function State:getSkillChangeInfo()
	if self.layer <= 0 then
		return nil
	end

	local stateData = StateSkillChangeData[self.stateId]

	if stateData then
		local levelData = stateData[self.level]

		if levelData then
			return levelData
		end
	end

	return nil
end

function State:needOverWhenAttackerDead()
	if self.hot then
		return true
	end

	if self.dot then
		return true
	end

	if self.stateData.attackerDeadClear and self.stateData.attackerDeadClear > 0 then
		return true
	end

	if self.exclusiveTag == EXCLUSIVE_TAUNT_TAG then
		return true
	end

	return false
end

function State:_checkSkillLayer()
	for index = #self.layerInfo, 1, -1 do
		if self.layerInfo[index] <= 0 then
			self.layerInfo[index] = nil
		else
			break
		end
	end

	local thisTimeLayer = #self.layerInfo

	if self.layer ~= #self.layerInfo then
		self:_setStateLayer(#self.layerInfo)
	end

	if self.layer == thisTimeLayer and self.layer <= 0 then
		self.mgr:oneStateOver(self)
	end
end

function State:_setStateLayer(layer)
	local preLayer = self.layer or 0

	self.layer = layer

	for _, propName in ipairs(SORTED_ATTR_LIST) do
		if self.stateData[propName] then
			local realStatePropName = propName

			if ATTR_CONFIG[STATE_PROP_PREFIX .. propName] then
				realStatePropName = STATE_PROP_PREFIX .. propName
			end

			self:_onPropChanged(propName, realStatePropName)

			if not self.disableShowNum and preLayer < layer and BattleConst.STATE_PROP_SHOW[propName] then
				self.mgr.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_STATESHOW, {
					propName,
					self.stateData.state_type == BattleConst.STATE_TYPE_DEBUFF
				})
			end
		end
	end

	self:_triggerStateEvent(self.level, layer)
	self:_checkSkillChange(self.level, layer)
	self:_handleSkillEnhance()
	self:_triggerSkillPassive(self.stateData.passiveSkill)
end

function State:_handleSkillDot()
	self.dot = nil

	local args = self.stateData.dotDamageId

	if args then
		args = utils.splitString(args, ",")

		if args[1] and args[2] and tonumber(args[1]) and tonumber(args[2]) then
			if self.stateData.dotDamageCircle and self.stateData.dotDamageCircle > 0 then
				self.dot = {
					tonumber(args[1]),
					tonumber(args[2]),
					math.floor(self.stateData.dotDamageCircle * self.mgr.master.framePerSec)
				}
			else
				self.dot = {
					tonumber(args[1]),
					tonumber(args[2]),
					HOT_INTERVAL
				}
			end
		end
	end

	self.hot = nil
	args = self.stateData.hotDamageId

	if args then
		args = utils.splitString(args, ",")

		if args[1] and args[2] and tonumber(args[1]) and tonumber(args[2]) then
			if self.stateData.hotDamageCircle and self.stateData.hotDamageCircle > 0 then
				self.hot = {
					tonumber(args[1]),
					tonumber(args[2]),
					math.floor(self.stateData.hotDamageCircle * self.mgr.master.framePerSec)
				}
			else
				self.hot = {
					tonumber(args[1]),
					tonumber(args[2]),
					HOT_INTERVAL
				}
			end
		end
	end
end

function State:_triggerStateEvent(level, layer)
	if layer <= 0 then
		return
	end

	local triggerData = StateTriggerData[self.stateId]

	if triggerData then
		local levelData = triggerData[level]

		if levelData and levelData[layer] then
			for index = 1, 3 do
				local trigger_event = levelData[layer]["trigger_event" .. index]

				if trigger_event then
					local attacker = self.mgr.master.mgr:getObjectByKey(self.attackerId)
					local skillId = trigger_event[1]
					local eventId = trigger_event[2]
					local eventLevel = self.level

					if attacker and skillId and eventId then
						attacker:triggerSkillEvent(skillId, eventId, self.mgr.master.id, nil, eventLevel)
					end
				end
			end
		end
	end
end

function State:_checkSkillChange(level, layer)
	if StateSkillChangeData[self.stateId] then
		self.mgr:refreshSkillChangeStates()
	end
end

function State:_handleSkillEnhance()
	if self.stateData.enhanceSkillId then
		self:_setPropValue("enhanceSkillRate", "enhanceSkillRate")

		if self.enhanceSkillRate and self.enhanceSkillRate ~= 0 then
			self.enhanceSkillId = self.stateData.enhanceSkillId

			self.mgr:addSkillEhanceState(self)
		else
			self.mgr:delSkillEnhanceState(self)
		end
	end

	if self.layer <= 0 then
		self.mgr:delSkillConditionEnhanceState(self)
	elseif self.stateData.conditionEnhanceId then
		self.mgr:addSkillConditionEhanceState(self)
	end
end

function State:_triggerSkillPassive(nowPassiveId)
	if self.layer <= 0 then
		if self.passiveSkillId then
			local delPassive = self.passiveSkillId

			self.passiveSkillId = nil

			self.mgr.master.passiveGroup:delSkill(delPassive, self.level)
		end
	elseif nowPassiveId and nowPassiveId ~= self.passiveSkillId then
		if self.passiveSkillId then
			self.mgr.master.passiveGroup:delSkill(self.passiveSkillId, self.level)
		end

		self.mgr.master.passiveGroup:addSkill(nowPassiveId, self.level, self.attackerId, self.mgr.master.act > 1)

		self.passiveSkillId = nowPassiveId
	end
end

function State:_onPropChanged(propName, realStatePropName)
	self:_setPropValue(propName, realStatePropName)
	self.mgr:onPropChanged(realStatePropName)
end

function State:_setPropValue(propName, realStatePropName)
	if self.stateData and self.stateData[propName] then
		local propValues = self.stateData[propName]

		if self.layer <= 0 then
			self[realStatePropName] = nil
		elseif type(propValues) == "number" then
			self[realStatePropName] = propValues
		elseif type(propValues) == "string" then
			self[realStatePropName] = tonumber(propValues)
		else
			local prop = self.stateData[propName][self.layer] or self.stateData[propName][1]

			if type(prop) == "number" then
				self[realStatePropName] = prop
			else
				self[realStatePropName] = self.mgr.master:calcAttrValue(prop, self.layer, self.attackerId)
			end
		end
	else
		self[realStatePropName] = nil
	end
end

local strClassName = "StateGroup"
local StateGroup = Class(strClassName)

function StateGroup:ctor(combatUnit)
	self.master = combatUnit
	self.orderStates = {}
	self.tickStates = {}
	self.hotStates = {}
	self.outdateState = {}
	self.states = {}
	self.props = {}
	self.exclusive = {}
	self.skillEnhanceInfo = {}
	self.stateInvalidDict = {}
	self.skillChangeStates = {}
	self.skillConditionEnhanceInfo = {}
end

function StateGroup:tickHot()
	for _, state in ipairs(self.hotStates) do
		state:tickHot()
	end
end

function StateGroup:nextFrame()
	for _, state in ipairs(self.tickStates) do
		state:nextFrame()
	end

	self:deleteOutdatedState()
end

function StateGroup:addState(attacker, stateId, level, delayTime, cardId)
	if self:onCheckStateImmune(stateId, level, attacker) then
		return
	end

	return self:_addState(attacker, stateId, level, delayTime, cardId)
end

function StateGroup:_addState(attacker, stateId, level, delayTime, cardId)
	local _attackerId = attacker.id

	if not self.states[_attackerId] then
		self.states[_attackerId] = {}
	end

	local _states = self.states[_attackerId]
	local state = _states[stateId]

	if not state then
		state = State(self, stateId, _attackerId, cardId)

		if state.exclusiveTag then
			self:_addExclusive(state.exclusiveTag, _attackerId, stateId)
		end

		_states[stateId] = state

		table.insert(self.orderStates, state)
	end

	state:onAddState(level, delayTime)

	if state[BattleConst.STATE_SILENCE] and state[BattleConst.STATE_SILENCE] > 0 then
		self.master:onAddSilenceState()
	end

	if state[BattleConst.STATE_CHANGE_CAMP] and state[BattleConst.STATE_CHANGE_CAMP] > 0 then
		self.master:onCheckCampState()

		state.onChangeCamp = true
	end

	self:addInvaidCondition(state)
	self:_checkStateTickFlag(state)

	return state
end

function StateGroup:_checkStateTickFlag(state)
	if state.dot or state.hot then
		local has = false

		for _, hotState in ipairs(self.hotStates) do
			if hotState == state then
				has = true

				break
			end
		end

		if not has then
			table.insert(self.hotStates, state)
		end
	end

	if state.needTick then
		local has = false

		for _, tickState in ipairs(self.tickStates) do
			if tickState == state then
				has = true

				break
			end
		end

		if not has then
			table.insert(self.tickStates, state)
		end
	end
end

function StateGroup:delState(aid, stateId)
	local _states = self.states[aid]

	if _states then
		local state = _states[stateId]

		if state then
			state:onStateOver()
			self:deleteOutdatedState()
		end
	end
end

local SELECT_MODE_RANDOM = 0
local SELECT_MODE_ALL = 1
local SELECT_MODE_CHOSEN = 2

function StateGroup:delStates(selectType, selectMode, randomCount, selectIds)
	local statesToDel = self:_getStatesList(selectType, selectMode, randomCount, selectIds, true)
	local delNumber = 0

	for i, state in ipairs(statesToDel) do
		state:onStateOver()

		delNumber = delNumber + 1
	end

	self:deleteOutdatedState()

	return delNumber
end

function StateGroup:extendStateTime(selectType, selectMode, randomCount, selectIds, extendTime)
	local extendFrame = math.floor(extendTime * self.master.framePerSec)
	local statesToExtend = self:_getStatesList(selectType, selectMode, randomCount, selectIds)

	for i, state in ipairs(statesToExtend) do
		if state.layer > 0 then
			state:extendStateTime(extendFrame)
		end
	end

	return #statesToExtend
end

function StateGroup:_getStatesList(selectType, selectMode, randomCount, selectIds, excludeCantPure)
	excludeCantPure = excludeCantPure or false

	local selectAllType = false

	if selectType == BattleConst.STATE_TYPE_ALL then
		selectAllType = true
	end

	local resultList = {}

	if selectMode == SELECT_MODE_CHOSEN then
		if not selectIds or #selectIds == 0 then
			return resultList
		end

		for _, state in ipairs(self.orderStates) do
			local _data = state.stateData
			local _type = _data.state_type
			local _id = _data.state_id

			if utils.getIndexByValue(selectIds, _id) ~= -1 and (not excludeCantPure or not _data.cantBePure) then
				table.insert(resultList, state)
			end
		end
	elseif selectMode == SELECT_MODE_ALL then
		for _, state in ipairs(self.orderStates) do
			local _data = state.stateData
			local _type = _data.state_type

			if (selectAllType or _type == selectType) and (not excludeCantPure or not _data.cantBePure) then
				table.insert(resultList, state)
			end
		end
	elseif selectMode == SELECT_MODE_RANDOM then
		local allStates = {}

		if not randomCount or randomCount == 0 then
			return resultList
		end

		for _, state in ipairs(self.orderStates) do
			local _data = state.stateData
			local _type = _data.state_type

			if (selectAllType or _type == selectType) and (not excludeCantPure or not _data.cantBePure) then
				table.insert(allStates, state)
			end
		end

		if randomCount >= #allStates then
			return allStates
		end

		local randomGenerator = self.master.randomGenerator

		resultList = randomGenerator:randomChoice(allStates, randomCount, true)
	end

	return resultList
end

function StateGroup:forceSetLayer(attacker, stateId, level, delayTime, layer)
	if layer <= 0 then
		self:delState(attacker.id, stateId)
	else
		local _attackerId = attacker.id
		local _states = self.states[_attackerId] or {}
		local state = _states[stateId]

		state = state or self:_addState(attacker, stateId, level, delayTime, nil)

		state:forceSetLayer(layer)
	end
end

function StateGroup:delStateLayer(attacker, stateId, delLayer)
	local _attackerId = attacker.id
	local _states = self.states[_attackerId] or {}
	local state = _states[stateId]

	if state then
		local targetLayer = state.layer - delLayer

		if targetLayer <= 0 then
			self:delState(attacker.id, stateId)
		else
			state:forceSetLayer(targetLayer)
		end
	end
end

function StateGroup:getStateLayer(stateId, targetId)
	local _states = self.states[targetId] or {}
	local state = _states[stateId]

	if state and not state:isOver() then
		return state.layer
	end

	return 0
end

function StateGroup:hasState(stateId, targetId)
	if targetId then
		local _states = self.states[targetId] or {}
		local state = _states[stateId]

		if state and not state:isOver() then
			return true
		end
	else
		for _, state in ipairs(self.orderStates) do
			if stateId == state.stateId and not state:isOver() then
				return true
			end
		end
	end

	return false
end

function StateGroup:hasStateType(stateType)
	for _, state in ipairs(self.orderStates) do
		if state.stateData and state.stateData.state_type == stateType then
			return true
		end
	end

	return false
end

function StateGroup:onCheckStateImmune(stateId, level, attacker)
	local stateData = BattleStateData.getStateData(stateId, level)

	if stateData then
		if self.props[BattleConst.STATE_IMMUNE_TAUNT] and self.props[BattleConst.STATE_IMMUNE_TAUNT] > 0 and stateData.replaceTag == EXCLUSIVE_TAUNT_TAG then
			self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
				BattleConst.STATE_IMMUNE_TAUNT,
				stateId,
				level
			})

			return true
		end

		if self.props[BattleConst.STATE_IMMUNE_SILENCE] and self.props[BattleConst.STATE_IMMUNE_SILENCE] > 0 and stateData[BattleConst.STATE_SILENCE] then
			self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
				BattleConst.STATE_IMMUNE_SILENCE,
				stateId,
				level
			})

			return true
		end

		if self.props[BattleConst.STATE_IMMUNE_CHANGE_CAMP] and self.props[BattleConst.STATE_IMMUNE_CHANGE_CAMP] > 0 and stateData[BattleConst.STATE_CHANGE_CAMP] then
			self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
				BattleConst.STATE_IMMUNE_CHANGE_CAMP,
				stateId,
				level
			})

			return true
		end

		if self.props[BattleConst.STATE_IMMUNE_DEBUFF] and self.props[BattleConst.STATE_IMMUNE_DEBUFF] > 0 and stateData.state_type == BattleConst.STATE_TYPE_DEBUFF then
			self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
				BattleConst.STATE_IMMUNE_DEBUFF,
				stateId,
				level
			})
			self.master.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT, {
				BattleConst.STATE_IMMUNE_DEBUFF,
				attacker
			})

			return true
		end

		if self.props[BattleConst.STATE_IMMUNE_DISARM] and self.props[BattleConst.STATE_IMMUNE_DISARM] > 0 and stateData[BattleConst.STATE_DISARM] then
			self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
				BattleConst.STATE_IMMUNE_DISARM,
				stateId,
				level
			})

			return true
		end
	end

	return false
end

function StateGroup:getProp(propName, defaultValue)
	if self.props[propName] then
		return self.props[propName]
	end

	return defaultValue
end

function StateGroup:_calcHurtOrDamageReduce(propName, multiIsNegative)
	local addValue = 0
	local multiValue = 1

	for _, state in ipairs(self.orderStates) do
		if state[propName] then
			if multiIsNegative then
				if state[propName] >= 0 then
					addValue = addValue + state[propName]
				else
					multiValue = multiValue * (10000 + state[propName]) / 10000
				end
			elseif state[propName] <= 0 then
				addValue = addValue + state[propName]
			else
				multiValue = multiValue * (10000 - state[propName]) / 10000
			end
		end
	end

	if multiIsNegative then
		return addValue + (multiValue - 1) * 10000
	else
		return addValue + (1 - multiValue) * 10000
	end
end

function StateGroup:onPropChanged(propName)
	local value = 0

	if propName == "sProp_damage_reduce_percent" or propName == "sProp_fire_damage_reduce" or propName == "sProp_ice_damage_reduce" then
		value = self:_calcHurtOrDamageReduce(propName, false)
	elseif propName == "sProp_damage_percent" or propName == "sProp_fire_damage" or propName == "sProp_ice_damage" then
		value = self:_calcHurtOrDamageReduce(propName, true)
	else
		for _, state in ipairs(self.orderStates) do
			if state[propName] then
				value = value + state[propName]
			end
		end
	end

	self.props[propName] = value

	if STATE_ATTR[propName] then
		self.master[propName] = value

		self.master:onStatePropChanged(propName, value)
	end

	if string.find(propName, "sProp_") == 1 then
		self.master:refreshBoardProp(propName)
	end
end

function StateGroup:triggerInvalidCondition(stateInvalidType)
	if self.stateInvalidDict[stateInvalidType] then
		local invalidDict = self.stateInvalidDict[stateInvalidType]
		local needDelete = false

		for index = 1, #invalidDict do
			local info = invalidDict[index]

			if info then
				local state = info[1]
				local account = info[2]

				account = account - 1

				if account <= 0 then
					state:onStateOver()

					needDelete = true
				else
					info[2] = account
				end
			end
		end

		if needDelete then
			self:deleteOutdatedState()
		end
	end
end

function StateGroup:addInvaidCondition(state)
	self:delInvaidCondition(state)

	local invaidType = state.stateData.state_invalid_type

	if invaidType and invaidType > 0 and state.stateData.state_invalid_number then
		if not self.stateInvalidDict[invaidType] then
			self.stateInvalidDict[invaidType] = {}
		end

		table.insert(self.stateInvalidDict[invaidType], {
			state,
			state.stateData.state_invalid_number
		})
	end
end

function StateGroup:delInvaidCondition(state)
	for invaidType, invaidInfo in pairs(self.stateInvalidDict) do
		for index, info in ipairs(invaidInfo) do
			if info[1] == state then
				table.remove(invaidInfo, index)

				return
			end
		end
	end
end

function StateGroup:refreshSkillChangeStates()
	self.skillChangeStates = {}

	for _, state in ipairs(self.orderStates) do
		if state:getSkillChangeInfo() then
			table.insert(self.skillChangeStates, state)
		end
	end
end

function StateGroup:getSkillChange(attackType, cardId, cardLevel)
	for _, state in ipairs(self.skillChangeStates) do
		local changeInfo = state:getSkillChangeInfo()

		if changeInfo then
			for _, info in pairs(changeInfo) do
				if info.trigger_skill == cardId then
					if info.level_source == 1 then
						return info.change_args, state.level
					else
						return info.change_args, cardLevel
					end
				end

				if attackType == BattleConst.ATTACK_CA and info.trigger_skill == 1 then
					if info.level_source == 1 then
						return info.change_args, state.level
					else
						return info.change_args, cardLevel
					end
				elseif attackType == BattleConst.ATTACK_SKILL and info.trigger_skill == -1 then
					if info.level_source == 1 then
						return info.change_args, state.level
					else
						return info.change_args, cardLevel
					end
				end
			end
		end
	end
end

function StateGroup:clear()
	for _, state in ipairs(self.orderStates) do
		self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DELSTATE, {
			state.attackerId,
			state.stateId
		})
	end

	self.states = {}
	self.orderStates = {}
	self.hotStates = {}
	self.tickStates = {}
	self.outdateState = {}

	for propName, value in pairs(self.props) do
		if STATE_ATTR[propName] then
			self.master[propName] = nil
		end
	end

	self.props = {}
	self.exclusive = {}
	self.skillEnhanceInfo = {}
	self.stateInvalidDict = {}
	self.skillChangeStates = {}
	self.skillConditionEnhanceInfo = {}
end

function StateGroup:onAttackerDead(attacker)
	local needDelete = false
	local aid = attacker.id

	for _, state in ipairs(self.orderStates) do
		if aid == state.attackerId and state:needOverWhenAttackerDead() then
			state:onStateOver()

			needDelete = true
		end
	end

	if needDelete then
		self:deleteOutdatedState()
	end
end

function StateGroup:oneStateOver(state)
	table.insert(self.outdateState, state)
end

function StateGroup:deleteOutdatedState()
	if #self.outdateState > 0 then
		for _, state in ipairs(self.outdateState) do
			if state and state:isOver() then
				local stateId = state.stateId

				self.master:addOutput(BattleConst.MATRIX_EVENT_ENTITY_DELSTATE, {
					state.attackerId,
					state.stateId
				})

				if state.exclusiveTag then
					self.exclusive[state.exclusiveTag] = nil
				end

				self:delInvaidCondition(state)

				for index, orderState in ipairs(self.orderStates) do
					if orderState == state then
						table.remove(self.orderStates, index)

						break
					end
				end

				for index, hotState in ipairs(self.hotStates) do
					if hotState == state then
						table.remove(self.hotStates, index)

						break
					end
				end

				local _states = self.states[state.attackerId]

				if _states then
					_states[stateId] = nil
				end

				if state.onChangeCamp then
					self.master:onCheckCampState()
				end
			end
		end

		self.outdateState = {}
	end
end

function StateGroup:addSkillEhanceState(state)
	self:delSkillEnhanceState(state)
	table.insert(self.skillEnhanceInfo, {
		state.enhanceSkillId,
		state.enhanceSkillRate,
		state
	})
end

function StateGroup:delSkillEnhanceState(state)
	for index, info in ipairs(self.skillEnhanceInfo) do
		if info[3] == state then
			table.remove(self.skillEnhanceInfo, index)

			return
		end
	end
end

StateGroup.CARD_TYPE_CACHE = {}
StateGroup.SKILL_TYPE_CACHE = {}

function StateGroup._getCardTypeKeys(cardId, skillId)
	if StateGroup.CARD_TYPE_CACHE[cardId] then
		return StateGroup.CARD_TYPE_CACHE[cardId]
	elseif ResSkillConfig[cardId] then
		local keys = {}

		keys[BattleConst.SPECIAL_ID_ANY_SKILL] = 1

		if ResSkillConfig[cardId][1].skill_type == BattleConst.SKILL_CONFIG_CA then
			keys[BattleConst.SPECIAL_ID_COMMON_ATTACK] = 1
		elseif ResSkillConfig[cardId][1].skill_type == BattleConst.SKILL_CONFIG_SKILL then
			keys[BattleConst.SPECIAL_ID_EXCEPT_COMMON_ATTACK] = 1
		end

		keys[cardId] = 1
		StateGroup.CARD_TYPE_CACHE[cardId] = keys

		return keys
	end

	if StateGroup.SKILL_TYPE_CACHE[skillId] then
		return StateGroup.SKILL_TYPE_CACHE[skillId]
	end

	local keys = {}

	keys[BattleConst.SPECIAL_ID_ANY_SKILL] = 1

	if ResSkillToCard[skillId] then
		if ResSkillToCard[skillId].skill_type == BattleConst.SKILL_CONFIG_CA then
			keys[BattleConst.SPECIAL_ID_COMMON_ATTACK] = 1
		elseif ResSkillToCard[skillId].skill_type == BattleConst.SKILL_CONFIG_SKILL then
			keys[BattleConst.SPECIAL_ID_EXCEPT_COMMON_ATTACK] = 1
		elseif ResSkillToCard[skillId].cardId and ResSkillConfig[ResSkillToCard[skillId].cardId] then
			keys[ResSkillToCard[skillId].cardId] = 1
		end
	end

	StateGroup.SKILL_TYPE_CACHE[skillId] = keys

	return keys
end

function StateGroup:getSkillEnhanceRate(cardId, skillId)
	local keys = self._getCardTypeKeys(cardId, skillId)
	local skillPower = 10000

	for index, info in ipairs(self.skillEnhanceInfo) do
		if keys[info[1]] then
			skillPower = skillPower + info[2]
		end
	end

	return skillPower
end

function StateGroup:addSkillConditionEhanceState(state)
	local condEnhanceId = state.stateData.conditionEnhanceId

	if ResSkillConditionEnhance[condEnhanceId] and ResSkillConditionEnhance[condEnhanceId][state.level] then
		self.skillConditionEnhanceInfo[state] = ResSkillConditionEnhance[condEnhanceId][state.level]
	else
		self.skillConditionEnhanceInfo[state] = nil
	end
end

function StateGroup:delSkillConditionEnhanceState(state)
	self.skillConditionEnhanceInfo[state] = nil
end

function StateGroup:getSkillConditionEnhanceRate(cardId, skillId, boxType, target, boxId)
	local skillPower = 10000

	if next(self.skillConditionEnhanceInfo) == nil then
		return skillPower
	end

	local keys = self._getCardTypeKeys(cardId, skillId)

	if next(keys) == nil then
		return skillPower
	end

	for _, conditionData in pairs(self.skillConditionEnhanceInfo) do
		if (not conditionData.boxId or conditionData.boxId and conditionData.boxId == boxId) and keys[conditionData.skillType] and conditionData.boxType then
			for index, needBoxType in ipairs(conditionData.boxType) do
				if boxType == needBoxType and (conditionData.conditionArgs == nil or conditionData.conditionArgs and utils.onCheckCondition(self.master, conditionData.conditionArgs, target)) then
					skillPower = skillPower + conditionData.enhanceValueType or 0

					break
				end
			end
		end
	end

	return skillPower
end

function StateGroup:getStateRemainedTime(stateId, targetId)
	local _states = self.states[targetId] or {}
	local state = _states[stateId]

	if state and not state:isOver() then
		return {
			state.level,
			state.layerInfo
		}
	end
end

function StateGroup:_addExclusive(tag, aid, sid)
	if self.exclusive[tag] then
		self:_delExclusive(tag)
	end

	self.exclusive[tag] = {
		aid,
		sid
	}

	if tag == EXCLUSIVE_TAUNT_TAG then
		self.master:beTaunted(aid)
	end
end

function StateGroup:_delExclusive(tag)
	if self.exclusive[tag] then
		local sinfo = self.exclusive[tag]

		self:delState(sinfo[1], sinfo[2])
	end
end

function StateGroup:getTauntInfo()
	if self.exclusive[EXCLUSIVE_TAUNT_TAG] then
		return self.exclusive[EXCLUSIVE_TAUNT_TAG][1]
	end

	return nil
end

function StateGroup:getStateNum(stateType)
	local statesToExtend = self:_getStatesList(stateType, SELECT_MODE_ALL)

	return #statesToExtend
end

return StateGroup
