require "class"
---@class SkillTargetHandler
local SkillTargetHandler = class("SkillTargetHandler")
local BattleCore = require "BattleCore"

local function collectBlocksByIds(blockIdList, battleMgr, filter, needFindDefeat)
	local result = {}
	if blockIdList and type(blockIdList) == "table" then
		local listIndex = 1
		for _, blockId in ipairs(blockIdList) do
			local block = battleMgr:getBlockById(blockId)
			if block then
				local pass = true
				if filter then
					pass = filter(block, block:tryGetRole(needFindDefeat))
				end
				if pass then
					result[listIndex] = block
					listIndex = listIndex + 1
				end
			end
		end
	end
	return result
end


function SkillTargetHandler:ctor()
	self._instance = nil
    self:_initFunction()
end

---实例化
---@return SkillTargetHandler SkillTargetHandler
function SkillTargetHandler:instance()
	if (self._instance == nil) then
		self._instance = self:new()
	end
	return self._instance
end

function SkillTargetHandler:_initFunction()
	self.functionList = {
		[GE.SkillEffectTargetType.Self] = self._getSelf,
		[GE.SkillEffectTargetType.Enemy] = self._getEnemyInBlockList,
		[GE.SkillEffectTargetType.Friend] = self._getFriendInBlockList,
		[GE.SkillEffectTargetType.Block] = self._getBlockInBlockList,
        [GE.SkillEffectTargetType.RangeAllTarget] = self._getAllTargetInBlockList,
        [GE.SkillEffectTargetType.FrinedWithoutSelf] = self._getFriendWithOutSelfInBlockList,
		[GE.SkillEffectTargetType.FriendWithoutSummoned] = self._getFriendWithOutSummonedInBlockList,
		[GE.SkillEffectTargetType.FriendWithoutSummonedAndSelf] = self._getFriendWithOutSelfAndSummonedInBlockList,
        [GE.SkillEffectTargetType.AllFriend] = self._getAllFriend,
        [GE.SkillEffectTargetType.FriendNoSelf] = self._getAllFriendWithoutSelf,
        [GE.SkillEffectTargetType.AllEnemy] = self._getAllEnemy,
        [GE.SkillEffectTargetType.AllRole] = self._getAllRole,
        [GE.SkillEffectTargetType.AllFriendWithoutSummoned] = self._getAllFriendWithoutSummoned,
        [GE.SkillEffectTargetType.AllFriendWithoutSelfAndSummoned] = self._getAllFriendWithoutSelfAndSummoned,
        [GE.SkillEffectTargetType.HasActionWithSelf] = self._getHasActionWithSelf,
        [GE.SkillEffectTargetType.SkillTarget] = self._getSkillTarget,
        [GE.SkillEffectTargetType.ActiveSkillTarget] = self._getActiveSkillTarget,
        [GE.SkillEffectTargetType.SkillEffectTarget] = self._getSkillEffectTarget,
		[GE.SkillEffectTargetType.CurrentRoundDefeatRole] = self._getCurrentRoundDefeatRole,
		[GE.SkillEffectTargetType.CurActionRole] = self._getCurActionRole,
	}
end

---根据行动目标类型筛选目标
---@param source BattleRole
---@param blockIdList integer[]?
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@param sourceSkillID integer?
---@return BattleBlock[]
function SkillTargetHandler:findTargets(source, blockIdList, targetType, configData, sourceSkillID)
    ---@type BattleBlock[]
	local r = {}
    local func = self.functionList[targetType]
    if func then
        r = func(self, source, blockIdList, targetType, configData, sourceSkillID)
    end
	return r
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getSelf(source, blockIdList, targetType, configData)
	local result = {}
    result[1] = source:getShowBlock()
	return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getEnemyInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(_, blockRole)
		return blockRole and battleMgr:isEnemyCamp(source, blockRole)
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getBlockInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getFriendInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(_, blockRole)
		return blockRole and not battleMgr:isEnemyCamp(source, blockRole)
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getFriendWithOutSelfInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(_, blockRole)
		return blockRole and blockRole.id ~= source.id and not battleMgr:isEnemyCamp(source, blockRole)
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getFriendWithOutSummonedInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(_, blockRole)
		return blockRole and not blockRole:IsSummoned() and not battleMgr:isEnemyCamp(source, blockRole)
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getFriendWithOutSelfAndSummonedInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(_, blockRole)
		return blockRole and blockRole.id ~= source.id and not blockRole:IsSummoned() and not battleMgr:isEnemyCamp(source, blockRole)
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllFriend(source, blockIdList, targetType, configData)
    local result = {}
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        if not battleMgr:isEnemyCamp(source, role) then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllFriendWithoutSelf(source, blockIdList, targetType, configData)
    local result = {}
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        if role.id ~= source.id and not battleMgr:isEnemyCamp(source, role) then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllTargetInBlockList(source, blockIdList, targetType, configData)
    local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(blockIdList, battleMgr, function(block)
		return block:getTmpRoleId() ~= nil
	end)
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllEnemy(source, blockIdList, targetType, configData)
    local result = {}
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        if battleMgr:isEnemyCamp(source, role) then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllRole(source, blockIdList, targetType, configData)
    local result = {}
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        result[listIndex] = role:getShowBlock()
        listIndex = listIndex + 1
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllFriendWithoutSummoned(source, blockIdList, targetType, configData)
    local result = {}
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        if not role:IsSummoned() and not battleMgr:isEnemyCamp(source, role) then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getAllFriendWithoutSelfAndSummoned(source, blockIdList, targetType, configData)
    local result = {}
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local roleList = roleMgr:getRolesList()
    local listIndex = 1
    for _, role in ipairs(roleList) do
        if role.id ~= source.id and not battleMgr:isEnemyCamp(source, role) and not role:IsSummoned() then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getHasActionWithSelf(source, blockIdList, targetType, configData)
    local result = {}
    local roleIdList = source:GetRoleActionList()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local listIndex = 1
    for id, _ in pairs(roleIdList) do
        local role = roleMgr:getRole(id)
        if role then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getSkillTarget(source, blockIdList, targetType, configData, sourceSkillID)
	local result = {}
	if sourceSkillID and source.selectedSkill and sourceSkillID == source.selectedSkill then
		result = source.skillFilteredTargets or {}
	end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getActiveSkillTarget(source, blockIdList, targetType, configData)
    local result = {}
    result = source.skillFilteredTargets or {}
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getSkillEffectTarget(source, blockIdList, targetType, configData)
    local result = {}
    local roleIdList = source:GetRoleEffectActionList()
    local roleMgr = BattleCore:getBattleRoleMgr()
    local listIndex = 1
    for id, _ in pairs(roleIdList) do
        local role = roleMgr:getRole(id)
        if role then
            result[listIndex] = role:getShowBlock()
            listIndex = listIndex + 1
        end
    end
    return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getCurrentRoundDefeatRole(source, blockIdList, targetType, configData)
	local battleMgr = BattleCore:getBattleMgr()
	local roleMgr = battleMgr:getRoleManager()
	local defeatRoleList = roleMgr:getCurRoundDefeatRoleList()
	local result = {}
	local listIndex = 1
	for _, role in ipairs(defeatRoleList) do
		result[listIndex] = role:getShowBlock()
		listIndex = listIndex + 1
	end
	return result
end

---@param source BattleRole
---@param blockIdList integer[]
---@param targetType integer
---@param configData SkillTable|EffectTriggerTable|nil
---@return BattleBlock[]
function SkillTargetHandler:_getCurActionRole(source, blockIdList, targetType, configData)
	local battleMgr = BattleCore:getBattleMgr()
	local actionRole = battleMgr:getSelectedRole()
	local result = {}
	if actionRole then
		result[1] = actionRole:getShowBlock()
	end
	return result
end

---endregion 寻找目标

---筛选目标列表
---@param source BattleRole
---@param list BattleBlock[]
---@param filterList integer[]
---@return BattleBlock[]
function SkillTargetHandler:targetFilterList(source, list, filterList)
	local r = list
	for _, value in ipairs(filterList) do
		local configData = Config.GetSiftConditionInfo(value)
		if configData then
			local func = self["targetFilterType" .. configData.siftConditionType]
			if func then
				r = func(self, source, r, configData)
			end
		end
	end
	return r
end

---@param source BattleRole
---@param list integer[]
---@param isEnemyCamp boolean
---@param needFindDefeat boolean
---@return BattleBlock[]
local function findAllRoleByBlockIds(source, list, isEnemyCamp, needFindDefeat)
	local battleMgr = BattleCore:getBattleMgr()
	return collectBlocksByIds(list, battleMgr, function(_, blockRole)
		local isEnemy = blockRole and battleMgr:isEnemyCamp(source, blockRole)
		return isEnemyCamp == isEnemy
	end, needFindDefeat)
end

--- 筛选友方
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType1(source, list, conditionData)
	local blockIdList = {}
	for i, v in ipairs(list) do
		blockIdList[i] = v.id
	end

	local result = findAllRoleByBlockIds(source, blockIdList, false, false)
	return result
end

--- 筛选敌方
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType2(source, list, conditionData)
	local blockIdList = {}
	for i, v in ipairs(list) do
		blockIdList[i] = v.id
	end

	local result = findAllRoleByBlockIds(source, blockIdList, true, false)
	return result
end

--- 筛选除自己以外的友方
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType4(source, list, conditionData)
	local result = {}

	local listIndex = 1
	for _, block in ipairs(list) do
		local blockRole = block:tryGetRole()
		if blockRole and blockRole.id ~= source.id then
			result[listIndex] = block
			listIndex = listIndex + 1
		end
	end

	return result
end

--- 对目标按距离排序
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType5(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	for _, block in ipairs(list) do
		local roleID = block:getTmpRoleId()
		if roleID then
			result[listIndex] = block
			listIndex = listIndex + 1
		end
	end
	local mapMgr = BattleCore:getBattleMgr():getMap()
	local sortType = conditionData.conditionValue and conditionData.conditionValue[1] or 0
	local sourceBlock = source:getShowBlock()
	table.sort(result, function(a, b)
		local dis1 = mapMgr:checkDistanceBetweenTwoBlock(sourceBlock, a)
		local dis2 = mapMgr:checkDistanceBetweenTwoBlock(sourceBlock, b)
		if dis1 ~= dis2 then
			if sortType == 0 then
				return dis1 < dis2
			else
				return dis1 > dis2
			end
		end
		return a.id < b.id
	end)
	
	return result
end

--- 对目标按属性值排序
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType6(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local roleMgr = BattleCore:getBattleRoleMgr()
	for _, block in ipairs(list) do
		local roleID = block:getTmpRoleId()
		if roleID then
			result[listIndex] = block
			listIndex = listIndex + 1
		end
	end
	local attributeId = conditionData.conditionValue[1]
	local sortType = conditionData.conditionValue[2] or 0
	
	table.sort(result, function(a, b)
		local role1 = roleMgr:getRole(a.roleId)
		local role2 = roleMgr:getRole(b.roleId)
		local value1 = role1 and role1:getAttrib(attributeId) or 0
		local value2 = role2 and role2:getAttrib(attributeId) or 0
		if value1 ~= value2 then
			if sortType == 0 then
				return value1 < value2
			else
				return value1 > value2
			end
		end
		return a.id < b.id
	end)
	
	return result
end

--- 按职业筛选目标
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType7(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local valueList = conditionData.conditionValue
	local compareType = conditionData.compareType
	local conditionList = {}
	if valueList then
		for _, value in ipairs(valueList) do
		conditionList[value] = 1
	end
	for _, block in ipairs(list) do
		local role = block:tryGetRole()
		if role then
			local roleAttribute = role.roleConfig.attribute
			local needEqual = compareType == GE.ConditionCompareType.Equal
			local checkResult = false
			if needEqual then
				checkResult = conditionList[roleAttribute] ~= nil
			else
				checkResult = conditionList[roleAttribute] == nil
			end
			if checkResult then
				result[listIndex] = block
				listIndex = listIndex + 1
			end
		end
		end
	end
	
	return result
end

--- 按属性值筛选目标
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType8(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local valueList = conditionData.conditionValue
	local compareType = conditionData.compareType
	if valueList then
		for _, block in ipairs(list) do
			local role = block:tryGetRole()
			if role then
				local attributeValue = role:getAttrib(valueList[1])
				local checkResult = self:_compare(attributeValue, valueList[2], compareType)
				if checkResult then
					result[listIndex] = block
					listIndex = listIndex + 1
				end
			end
		end
	end

	return result
end

--- 按距离筛选
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType9(source, list, conditionData)
	local BattleCore = require "BattleCore"
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local mapMgr = BattleCore:getBattleMgr():getMap()
	local valueList = conditionData.conditionValue
	local compareType = conditionData.compareType
	local sourceBlock = source:getShowBlock()
	if valueList then
		for _, block in ipairs(list) do
			local roleID = block:getTmpRoleId()
			if roleID then
				local dis = mapMgr:checkDistanceBetweenTwoBlock(sourceBlock, block)
				local checkResult = self:_compare(dis, valueList[1], compareType)
				if checkResult then
					result[listIndex] = block
					listIndex = listIndex + 1
				end
			end
		end
	end

	return result
end

--- 按生命值百分比筛选目标
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType10(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local valueList = conditionData.conditionValue
	local compareType = conditionData.compareType
	if valueList then
		for _, block in ipairs(list) do
			local role = block:tryGetRole()
			if role then
				local value = role:GetCurHPPrecent()
				local checkResult = self:_compare(value, valueList[1], compareType)
				if checkResult then
					result[listIndex] = block
					listIndex = listIndex + 1
				end
			end
		end
	end

	return result
end

--- 对目标按生命值百分比排序
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
function SkillTargetHandler:targetFilterType11(source, list, conditionData)
	local BattleCore = require "BattleCore"
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local roleMgr = BattleCore:getBattleRoleMgr()
	for _, block in ipairs(list) do
		local roleID = block:getTmpRoleId()
		if roleID then
			result[listIndex] = block
			listIndex = listIndex + 1
		end
	end
	-- local attributeId = GE.AttribType.Hp
	-- local attributeHpMax = GE.AttribType.MaxHp
	local sortType = conditionData.conditionValue[1] or 0

	table.sort(result, function(a, b)
		local role1 = roleMgr:getRole(a.roleId)
		local role2 = roleMgr:getRole(b.roleId)
		local value1 = role1 and role1:GetCurHPPrecent() or 0
		local value2 = role2 and role2:GetCurHPPrecent() or 0
		if value1 ~= value2 then
			if sortType == 0 then
				return value1 < value2
			else
				return value1 > value2
			end
		end
		return a.id < b.id
	end)

	return result
end

--- 按角色阵营筛选目标
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType12(source, list, conditionData)
    ---@type BattleBlock[]
    local result = {}
    local listIndex = 1
    local valueList = conditionData.conditionValue
    local compareType = conditionData.compareType
    local conditionList = {}
	if valueList then
		for _, value in ipairs(valueList) do
			conditionList[value] = 1
		end
		for _, block in ipairs(list) do
			local role = block:tryGetRole()
			if role then
				local needEqual = compareType == GE.ConditionCompareType.Equal
				local roleCamp = role.roleConfig.camp
				local checkResult = false
				if not roleCamp then
				else
					for _, campID in ipairs(roleCamp) do
						checkResult = conditionList[campID] ~= nil
						if checkResult then
							break
						end
					end
				end
				if (checkResult == true and needEqual == true) or (checkResult == false and needEqual == false) then
					result[listIndex] = block
					listIndex = listIndex + 1
				end
			end
		end
	end
    return result
end

---筛选是否有受到伤害的标签
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType13(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	for _, block in ipairs(list) do
		local role = block:tryGetRole()
		if role then
			local value = role:CheckHasTag(GE.ActionTagType.HasBeHurt)
			if value == true then
				result[listIndex] = block
				listIndex = listIndex + 1
			end
		end
	end

	return result
end

--- 筛选是否是空中单位
---@param source BattleRole
---@param list BattleBlock[]
---@param conditionData SiftConditionTable
---@return BattleBlock[]
function SkillTargetHandler:targetFilterType14(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	for _, block in ipairs(list) do
		local role = block:tryGetRole()
		if role then
			local isFly = role.roleConfig.canFly
			local compareValue = conditionData.conditionValue and conditionData.conditionValue[1] or 0
			local compareType = conditionData.compareType
			if self:_compare(isFly, compareValue, compareType) then
				result[listIndex] = block
				listIndex = listIndex + 1
			end
		end
	end

	return result
end

---查询范围内所有敌方角色（包括阵亡角色）
---@param source BattleRole
---@param list BattleBlock[]
function SkillTargetHandler:targetFilterType15(source, list, conditionData)
	---@type integer[]
	local blockIdList = {}
	for i, v in ipairs(list) do
		blockIdList[i] = v.id
	end
	local r = findAllRoleByBlockIds(source, blockIdList, true, true)
	return r
end

---查询范围内所有友方角色（包括阵亡角色）
---@param source BattleRole
---@param list BattleBlock[]
function SkillTargetHandler:targetFilterType16(source, list, conditionData)
	---@type integer[]
	local blockIdList = {}
	for i, v in ipairs(list) do
		blockIdList[i] = v.id
	end
	local r = findAllRoleByBlockIds(source, blockIdList, false, true)
	return r
end

---筛选还有特定标签buff的目标
---@param source BattleRole
---@param list BattleBlock[]
function SkillTargetHandler:targetFilterType17(source, list, conditionData)
	---@type BattleBlock[]
	local result = {}
	local listIndex = 1
	local valueList = conditionData.conditionValue
	local compareType = conditionData.compareType
	for _, block in ipairs(list) do
		local role = block:tryGetRole()
		if role then
			local isPass = false
			local buffController = role:getBuffController()
			local matchCount = 0
			for _, tag in ipairs(valueList) do
				if tablex.next(buffController:getBuffsByTags({ tag })) then
					matchCount = matchCount + 1
				end
			end
			if compareType == 1 then
				isPass = matchCount == #valueList
			elseif compareType == 2 then
				isPass = matchCount > 0
			elseif compareType == 3 then
				isPass = matchCount == 0
			end
			if isPass then
				result[listIndex] = block
				listIndex = listIndex + 1
			end
		end
	end

	return result
end

---@param value1 number 比对值
---@param value2 number 基准值
---@param type ConditionCompareType 比对类型
---@return boolean
function SkillTargetHandler:_compare(value1, value2, type)
	if (type == GE.ConditionCompareType.Equal) then
		return value1 == value2
	elseif (type == GE.ConditionCompareType.Bigger) then
		return value1 > value2
	elseif (type == GE.ConditionCompareType.BiggerOrEqual) then
		return value1 >= value2
	elseif (type == GE.ConditionCompareType.Smaller) then
		return value1 < value2
	elseif (type == GE.ConditionCompareType.SmallerOrEqual) then
		return value1 <= value2
	elseif (type == GE.ConditionCompareType.NotEqual) then
		return value1 ~= value2
		-- elseif (type == GE.ConditionCompareType.Invert) then
		-- 	return not (value1 == value2)
	else
		BattleCore.ds("SkillTargetHandler:_compare wrong ConditionCompareType", type)
		return false
	end
end

---@param source BattleRole
---@param skillConfig SkillTable
---@return integer[]
function SkillTargetHandler:checkTargetBlockWithSource(source, skillConfig)
	local BattleCore = require "BattleCore"
	local result = {}
	if skillConfig and skillConfig.effectRange then
		-- local blockIdList = {}
		local battleMgr = BattleCore:getBattleMgr()
		local block = source:getShowBlock()
		local mapMar = battleMgr:getMap()
		local skillMgr = battleMgr:getSkillManager()
		local skillEffectRange = skillMgr:GetSkillEffectRangeByRole(skillConfig, source)
		local blockDataList = mapMar:getDiffuseRange(skillConfig.rangeSelectType, block, skillEffectRange)
		for index, blockData in ipairs(blockDataList) do
			local id = blockData.blockId
			result[index] = id
		end
		-- result = self:findTargets(source, blockIdList, skillConfig.effectSoldierType, skillConfig, skillConfig.id)
	end
	return result
end

return SkillTargetHandler