require "class"
---@class SkillConditionHandler
local SkillConditionHandler = class("SkillConditionHandler")
local BattleCore = require "BattleCore"


function SkillConditionHandler:ctor()
	self._instance = nil
	self:_initConditionEvent()
end

---实例化
---@return SkillConditionHandler SkillConditionHandler
function SkillConditionHandler:instance()
	if (self._instance == nil) then
		self._instance = self:new()
	end
	return self._instance
end

---初始化效果事件
function SkillConditionHandler:_initConditionEvent()
	self._conditionEvent = {
		[GE.SkillConditionType.CompareTiming] = self._compareTiming,
		[GE.SkillConditionType.CompareAtkAttriType] = self._compareAtkAttriType,
		[GE.SkillConditionType.CompareAtkDmgType] = self._compareAtkDmgType,
		[GE.SkillConditionType.IsEngagedInBattle] = self._isEngagedInBattle,
		[GE.SkillConditionType.CompareActionTagType] = self._compareActionTag,
		[GE.SkillConditionType.CompareAttributeType] = self._compareAttribute,
		[GE.SkillConditionType.CompareMoveDistance] = self._compareMoveDistance,
		[GE.SkillConditionType.CompareTargetDistance] = self._compareTargetDistance,
		[GE.SkillConditionType.CompareConditionTargetInRange] = self._compareConditionTargetInRange,
		[GE.SkillConditionType.CompareTargetAttributeValue] = self._compareTargetAttribute,
		[GE.SkillConditionType.CompareAttributeWithTarget] = self._compareAttributeWithTarget,
		[GE.SkillConditionType.CompareHpPrecent] = self._compareRoleHpPrecent,
		[GE.SkillConditionType.CompareBuffTagCount] = self._compareRoleBuffCountWithTag,
		[GE.SkillConditionType.CompareTargetBlockTag] = self._compareBlockTag,
		[GE.SkillConditionType.CompareIsInEnemyAttactRange] = self._compareIsInRangeOfEnemyBlock,
		[GE.SkillConditionType.CampareHasAction] = self._compareTargetHasAction,
        [GE.SkillConditionType.CampareCurSkillId] = self._compareCurSkillIdWithSourceSkillId,
        [GE.SkillConditionType.CompareTargetAttributeWithTarget] = self._compareTargetAttributeWithTarget,
		[GE.SkillConditionType.CompareHpPrecentWithTarget] = self._compareRoleHpPrecentWithTarget,
		[GE.SkillConditionType.CompareTargetIsAlive] = self._compareTargetIsAlive,
		[GE.SkillConditionType.CompareTargetRemainMovePower] = self._compareTargetRemainMovePower,
		[GE.SkillConditionType.CompareSourceAndTargetIsOnStraightLine] = self._compareSourceAndTargetIsOnStraightLine,
		[GE.SkillConditionType.CompareTargetRestraintNum] = self._compareTargetRestraintNum,
		[GE.SkillConditionType.CompareTargetBuffTag] = self._compareTargetBuffTag,
	}
end

---@param source BattleRole
---@param target BattleRole
---@param conditionConfig EffectTriggerConditionTable
---@return BattleBlock[]
function SkillConditionHandler:FindAllTarget(source, target, conditionConfig, sourceSkillId)
	local BattleCore = require "BattleCore"
	-- local skillMgr = BattleCore:getSkillTargetHandler()
	local targetHandler = BattleCore:getSkillTargetHandler()
	---@type BattleBlock[]
	local result = {}

	local targetType = conditionConfig.conditionTarget[1]
	local siftList = conditionConfig.SiftCondition
	if targetType then
		local blockIdList = {}
		if target then
			blockIdList[1] = target:getShowBlock().id
		end
        local targetList = targetHandler:findTargets(source, blockIdList, targetType, nil, sourceSkillId)
		result = targetHandler:targetFilterList(source, targetList, siftList)
	else
		result[1] = source:getShowBlock()
	end

	return result
end

---检测所有条件
---@param conditions integer[] 条件表数据
---@param sourceSkillId integer|nil
---@param source BattleRole
---@param target BattleRole? 目标
---@param targetList BattleBlock[]?
---@return boolean 条件是否达成
function SkillConditionHandler:checkAllConditions(conditions, source, target, targetList, sourceSkillId)
	local isPass = false
	---判断是否有检测目标存活的条件
	local needCheckAlive = conditions and tablex.contains(conditions, 118001) or false
	local isAlive = needCheckAlive or source:getIsAlive()
	if isAlive then
		if (conditions) then
			isPass = true
			for _, condition in ipairs(conditions) do
				isPass = self:_checkCondition(condition, source, target, sourceSkillId)
				-- if not GV.IsServer then
				-- 	LuaLogger.ds("SkillConditionHandler _checkCondition", isPass)
				-- end
				if (not isPass) then
					break
				end
			end
		else
			isPass = true
		end
	end
	-- if not GV.IsServer then
	-- 	LuaLogger.ds("SkillConditionHandler:checkAllConditions",isPass)
	-- end
	return isPass
end

---@param condition integer 条件ID
---@param source BattleRole 条件源
---@param target BattleRole? 条件目标
---@param _targetList BattleBlock[]? 条件目标列表(暂时用不上，预留)
---@param sourceSkillID integer? 来源技能ID
function SkillConditionHandler:_checkCondition(condition, source, target, sourceSkillID)
	-- LuaLogger.ds("_checkCondition id:", condition, source, target)
	local conditionConfig = Config.GetEffectTriggerConditionInfo(condition)
	if (not conditionConfig) then
		return false
	end
	local type = conditionConfig.conditionType
	local compareFunc = self._conditionEvent[type]
	if compareFunc then
		local targets = self:FindAllTarget(source, target, conditionConfig, sourceSkillID)
		local r = compareFunc(self, conditionConfig, source, targets, sourceSkillID)
		return r
	end
	return false
end

---比对
---@param value1 any 比对值1
---@param value2 any 比对值2
---@param type ConditionCompareType 比对类型
---@return boolean
function SkillConditionHandler:_compare(value1, value2, type)
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
		BattleCore.ds("SkillConditionHandler:_compare wrong ConditionCompareType", type)
		return false
	end
end

---region 条件检测函数

---比对时机
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source any 条件源
---@param target any 条件目标
function SkillConditionHandler:_compareTiming(conditionConfig, source, target)
	local BattleCore = require "BattleCore"
	if (not conditionConfig) then
		return false
	end
	local battleMgr = BattleCore:getBattleMgr()
	local timing = battleMgr:getTiming()
	local targetTiming = conditionConfig.conditionValue[1]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareTiming", timing, targetTiming)
	end
	return self:_compare(timing, targetTiming, conditionConfig.compareType)
end

---比对技能类型
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source any 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareAtkAttriType(conditionConfig, source, targets)
	if (not targets or not conditionConfig) then
		return false
	end
	local target = nil
	local block = targets[1]
	if block then
		target = block:tryGetRole(true)
	end
	if not target or not target.selectedSkill then
		return false
	end
	local skillConfig = Config.GetSkillInfo(target.selectedSkill)
	local atkAttriType = skillConfig.attackAttriType
	local targetAtkAttriType = conditionConfig.conditionValue[1]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareAtkAttriType", atkAttriType, targetAtkAttriType)
	end
	return self:_compare(atkAttriType, targetAtkAttriType, conditionConfig.compareType)
end

---比对伤害类型
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source any 条件源
---@param targets any 条件目标
function SkillConditionHandler:_compareAtkDmgType(conditionConfig, source, targets)
	if (not targets or not conditionConfig) then
		return false
	end
	local target = nil
	local block = targets[1]
	if block then
		target = block:tryGetRole(true)
	end
	if not target or not target.selectedSkill then
		return false
	end
	local skillConfig = Config.GetSkillInfo(target.selectedSkill)
	local atkDmgType = skillConfig.attackDamageType
	local targetAtkDmgType = conditionConfig.conditionValue[1]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:compareAtkDmgType", atkDmgType, targetAtkDmgType)
	end
	return self:_compare(atkDmgType, targetAtkDmgType, conditionConfig.compareType)
end

---是否发生战斗（当前行动）
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source any 条件源
---@param target any 条件目标
function SkillConditionHandler:_isEngagedInBattle(conditionConfig, source, target)
	local BattleCore = require "BattleCore"
	if (not conditionConfig) then
		return false
	end
	
	local battleMgr = BattleCore:getBattleMgr()
	local result = battleMgr:isEngagedInBattle()
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_isEngagedInBattle result:", result)
	end
	return self:_compare(result, true, conditionConfig.compareType)
end

---是否有对应的行动标签（当前行动）
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareActionTag(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end
	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end
	-- if LuaLogger.Enabled and (not GV.IsServer) then
	-- 	LuaLogger.ds(role.roleConfig.name, "SkillConditionHandler:_compActionTag", tablex.dump(role._actionTagList),
	-- 	tablex.dump(conditionConfig.conditionValue))
	-- end
	local result = true

	local valueList = conditionConfig.conditionValue
	local compareType = conditionConfig.compareType
	for _, value in ipairs(valueList) do
		local roleTag = role:CheckHasTag(value)
		local hasTagResult = roleTag == true and GE.ConditionCompareType.Equal or GE.ConditionCompareType.NotEqual
		if hasTagResult ~= compareType then
			result = false
			break
		end
	end

	return result
end

---检测舰种
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareAttribute(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end
	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end
	if not GV.IsServer then
		BattleCore.ds(role.roleConfig.name, "SkillConditionHandler:_compareAttribute", role.roleConfig.attribute, "compareType", conditionConfig.compareType, tablex.dump(conditionConfig.conditionValue))
	end
	local valueList = conditionConfig.conditionValue
	local compareType = conditionConfig.compareType
	local result = compareType == GE.ConditionCompareType.NotEqual
	for _, value in ipairs(valueList) do
		local roleAttribute = role.roleConfig.attribute
		local isEqual = roleAttribute == value
		if isEqual then
			result = compareType == GE.ConditionCompareType.Equal
			break
		end
	end

	return result
end

---检测目标移动距离
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareMoveDistance(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end
	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end
	local movePath = role:getHasMoveDistance()
	local moveDis = movePath or 0
	if not GV.IsServer then
		BattleCore.ds(role.roleConfig.name, "SkillConditionHandler:_compareMoveDistance", moveDis, "compareType", conditionConfig.compareType, tablex.dump(conditionConfig.conditionValue))
	end
	
	local compareValue = conditionConfig.conditionValue[1]
	return self:_compare(moveDis, compareValue, conditionConfig.compareType)
end

---检测与目标之间的距离
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetDistance(conditionConfig, source, targets)
	local BattleCore = require "BattleCore"
	if (not conditionConfig) then
		return false
	end
	local block = targets[1]
	if not block then
		return false
	end
	local sourceBlock = source:getShowBlock()
	local mapMgr = BattleCore:getBattleMgr():getMap()
    local dis = mapMgr:checkDistanceBetweenTwoBlock(sourceBlock, block)

	local compareValue = conditionConfig.conditionValue[1]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareTargetDistance", dis, "compareType", conditionConfig.compareType, compareValue)
	end
	return self:_compare(dis, compareValue, conditionConfig.compareType)
end

---检测当前目标的数量
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareConditionTargetInRange(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end
	local targetCount = #targets
	local compareValue = conditionConfig.conditionValue[1]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareConditionTargetInRange", targetCount, "compareType",
			conditionConfig.compareType, compareValue)
	end
	return self:_compare(targetCount, compareValue, conditionConfig.compareType)
end

---检测与目标某项属性值的比对
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareAttributeWithTarget(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end
	
	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local compareValue = conditionConfig.conditionValue[1]
    local compareValue2 = conditionConfig.conditionValue[2] or compareValue
	local attr1 = source:getAttrib(compareValue, nil)
    local attr2 = role:getAttrib(compareValue2, nil)
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareAttributeWithTarget", attr1, attr2, "compareType", conditionConfig.compareType, compareValue, compareValue2)
	end

	return self:_compare(attr1, attr2, conditionConfig.compareType)
end

---检测目标某项属性值的比对
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetAttribute(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local compareValue = conditionConfig.conditionValue[1]
	local attr1 = role:getAttrib(compareValue)
	local attr2 = conditionConfig.conditionValue[2]
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareTargetAttribute", attr1, attr2, "compareType",
			conditionConfig.compareType)
	end

	return self:_compare(attr1, attr2, conditionConfig.compareType)
end

---检测目标血量百分比的比对
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareRoleHpPrecent(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	
	if not role then
		return false
	end

	local precent = role:GetCurHPPrecent()
	local attr2 = conditionConfig.conditionValue[1]

	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareTargetHpPrecent", precent, attr2, "compareType",
			conditionConfig.compareType)
	end

	return self:_compare(precent, attr2, conditionConfig.compareType)
end

---检测来源和目标血量百分比的比对
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareRoleHpPrecentWithTarget(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	
	if not role then
		return false
	end

	local precent1 = source:GetCurHPPrecent()
	local precent2 = role:GetCurHPPrecent()
	if not GV.IsServer then
		BattleCore.ds("SkillConditionHandler:_compareTargetHpPrecent", precent1, precent2, "compareType",
			conditionConfig.compareType)
	end

	return self:_compare(precent1, precent2, conditionConfig.compareType)
end

---检测目标指定标签buff的数量
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareRoleBuffCountWithTag(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local buffController = role:getBuffController()
	local buffTag = conditionConfig.conditionValue[1]
	local tagList = { buffTag }
	local list = buffController:getBuffsByTags(tagList)
	local num = #list
	local limitNum = conditionConfig.conditionValue[2]

	return self:_compare(num, limitNum, conditionConfig.compareType)
end

---筛选目标携带的buff标签
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
---@return boolean
function SkillConditionHandler:_compareTargetBuffTag(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local valueList = conditionConfig.conditionValue
	if not valueList or #valueList == 0 then
		return false
	end

	local buffController = role:getBuffController()
	local compareType = conditionConfig.compareType
	local matchCount = 0
	for _, tag in ipairs(valueList) do
		if #buffController:getBuffsByTags({ tag }) > 0 then
			matchCount = matchCount + 1
		end
	end

	if compareType == 1 then
		return matchCount == #valueList
	elseif compareType == 2 then
		return matchCount > 0
	elseif compareType == 3 then
		return matchCount == 0
	end

	BattleCore.ds("SkillConditionHandler:_compareTargetBuffTag wrong compareType", compareType)
	return false
end

---检测目标地格标签
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareBlockTag(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end
	local tData = block.terrainCfgData
	local valueList = tData.tags
	local compareType = conditionConfig.compareType
	local result = compareType == GE.ConditionCompareType.NotEqual
	local tagId = conditionConfig.conditionValue[1]
	for _, value in ipairs(valueList) do
		local isEqual = tagId == value
		if isEqual then
			result = compareType == GE.ConditionCompareType.Equal
			break
		end
	end

	return result
end

---检测是否在危险地格范围内
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareIsInRangeOfEnemyBlock(conditionConfig, source, targets)
	local BattleCore = require "BattleCore"
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

    local battleMgr = BattleCore:getBattleMgr()
	local skillMgr = battleMgr:getSkillManager()
    local roleMgr = battleMgr:getRoleManager()
	local enemyCamps = roleMgr:getEnemyCamp(role.camp)
	---@type BattleRole[]
	local enemyList = {}
	for _, camp in ipairs(enemyCamps) do
		enemyList = tablex.combine(enemyList, roleMgr:getRolesByCamp(camp))
	end
    local mapMgr = battleMgr:getMap()

	local compareType = conditionConfig.compareType
	local result = compareType == GE.ConditionCompareType.NotEqual
	for _, v in ipairs(enemyList) do
		local dis = mapMgr:checkDistanceBetweenTwoBlock(v:getShowBlock(), block)
		local movePower = v:getAttrib(GE.AttribType.MovePower)
		local roleConfig = v.roleConfig
		local skillConfig = Config.GetSkillInfo(roleConfig.normalSkill)
		local range = skillMgr:GetSkillSelectRangeByRole(skillConfig, v)
		if dis <= (movePower + range[1]) then
			local chooseRangeIdList = v:getRoleKVAtkRange()
			if chooseRangeIdList[block.id] then
				result = compareType == GE.ConditionCompareType.Equal
				return result
			end
		end
	end
	return result
end

---检测是否有过交互
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetHasAction(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local compareType = conditionConfig.compareType
	local result = compareType == GE.ConditionCompareType.NotEqual
	local actionList = role:GetRoleActionList()
	if next(actionList) ~= nil then
		result = compareType == GE.ConditionCompareType.Equal
	end
	
	return result
end

---检测是否属于当前技能
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareCurSkillIdWithSourceSkillId(conditionConfig, source, targets, sourceSkillId)
    if (not conditionConfig) then
        return false
    end

	if sourceSkillId == nil then
		return false
	end

    local compareType = conditionConfig.compareType
    local result = false
    local curSkillId = source.selectedSkill
    if curSkillId then
        result = self:_compare(curSkillId, sourceSkillId, compareType)
	end

    return result
end

---检测目标的某项属性与目标的另一项属性值的比对
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetAttributeWithTarget(conditionConfig, source, targets)
    if (not conditionConfig) then
        return false
    end

    local role = nil
    local block = targets[1]
    if block then
        role = block:tryGetRole(true)
    end
    if not role then
        return false
    end

    local compareValue = conditionConfig.conditionValue[1]
    local compareValue2 = conditionConfig.conditionValue[2] or compareValue
    local attr1 = role:getAttrib(compareValue, nil)
    local attr2 = role:getAttrib(compareValue2, nil)
    if not GV.IsServer then
        BattleCore.ds("SkillConditionHandler:_compareAttributeWithTarget", attr1, attr2, "compareType",
            conditionConfig.compareType)
    end

    return self:_compare(attr1, attr2, conditionConfig.compareType)
end

---检测目标是否存活
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetIsAlive(conditionConfig, source, targets)
    if (not conditionConfig) then
        return false
    end

    local role = nil
    local block = targets[1]
    if block then
        role = block:tryGetRole(true)
    end
    if not role then
        return false
    end
    local compareValue = false
    local compareValue2 = role:getIsAlive()

    return self:_compare(compareValue, compareValue2, conditionConfig.compareType)
end

---检测目标的剩余移动力
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareTargetRemainMovePower(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end

	local movePower = role:getRemainMovePower()
	local compareValue = conditionConfig.conditionValue[1]

	return self:_compare(movePower, compareValue, conditionConfig.compareType)
end

---检测来源和目标是否在同一直线上
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
function SkillConditionHandler:_compareSourceAndTargetIsOnStraightLine(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local sourceBlock = source:getShowBlock()
	local targetBlock = targets[1]
	if not sourceBlock or not targetBlock then
		return false
	end

	local compareType = conditionConfig.compareType
	local isOnStraightLine = sourceBlock.col == targetBlock.col or sourceBlock.row == targetBlock.row
	local result = compareType == GE.ConditionCompareType.NotEqual
	if isOnStraightLine then
		result = compareType == GE.ConditionCompareType.Equal
	end
	
	return result
end

---检测目标的舰种克制系数
---@param conditionConfig EffectTriggerConditionTable 条件表数据
---@param source BattleRole 条件源
---@param targets BattleBlock[] 条件目标
---@return boolean
function SkillConditionHandler:_compareTargetRestraintNum(conditionConfig, source, targets)
	if (not conditionConfig) then
		return false
	end

	local role = nil
	local block = targets[1]
	if block then
		role = block:tryGetRole(true)
	end
	if not role then
		return false
	end
	local sourceAttribute = source.roleConfig.attribute
	local charRestraintConfig = Config.GetCharacterRestraintInfo(sourceAttribute)
    if not charRestraintConfig then
        return false
    end
	local ratio = charRestraintConfig.ratio
	local targetAttribute = role.restraintType
	local restraintNum = ratio[targetAttribute]

	local compareValue = conditionConfig.conditionValue[1] or 1

	return self:_compare(restraintNum, compareValue, conditionConfig.compareType)
end

---endregion

return SkillConditionHandler