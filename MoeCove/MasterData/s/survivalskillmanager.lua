require "class"
---@class SurvivalSkillManager
local SurvivalSkillManager = class("SurvivalSkillManager")
local insert = table.insert
local remove = table.remove

function SurvivalSkillManager:ctor(...)
	self._skillFunctionList = {
		[GE.SurvivalSkillType.CreateBullet] = self.CreateBullet,
		[GE.SurvivalSkillType.AreaEffect] = self.CreateAreaEffect,
		[GE.SurvivalSkillType.AttributeBonus] = self.ApplyAttributeBonus,
	}
end

--获取角色属性对技能的加持(根据技能配置权重来计算)
---@param roleAttr table<SurvivalAttribType, number> 角色属性
---@param skillParam table 技能参数
---@param attribType SurvivalAttribType? 指定属性类型
---@return table<SurvivalAttribType, number> 角色属性对技能的加持
function SurvivalSkillManager:GetBaseAttrFromRole(roleAttr, skillParam, attribType)
	local attr = {}
	local attrWeight = {}
	for k, v in pairs(skillParam[2]) do
        local attrId = tonumber(string.sub(k, 2))  -- 去掉首字母，转数字
        if attrId then
            attrWeight[attrId] = v
        end
    end
	for k, v in pairs(roleAttr) do
		if attribType and k ~= attribType then
			goto continue
		end
		local weight = attrWeight[k] or 1
		attr[k] = v * weight
		::continue::
	end
	return attr
end

--获取技能初始属性
---@param skillParam table 技能参数
---@param attribType SurvivalAttribType? 指定属性类型
---@return table<SurvivalAttribType, number> 技能初始属性
function SurvivalSkillManager:GetBaseAttrFormSkill(skillParam, attribType)
	local baseAttr = skillParam[1]
    local attr = {}
    for k, v in pairs(baseAttr) do
		if attribType and k ~= attribType then
			goto continue
		end
        local attrId = tonumber(string.sub(k, 2))  -- 去掉首字母，转数字
        if attrId then
            attr[attrId] = v
        end
    end
	::continue::
    return attr
end

---根据蓄力比例计算技能属性倍率（满蓄时为 skillTypeParam.bonus 配置值）
---@param skillId integer
---@param chargeRatio number 0~1
---@return table<integer, number>|nil attrId -> multiplier
function SurvivalSkillManager:CalcChargeBonus(skillId, chargeRatio)
	if not chargeRatio or chargeRatio <= 0 then
		return nil
	end
	local cfg = Config.GetSurvivorSkillInfo(skillId)
	local bonusCfg = cfg and cfg.skillTypeParam and cfg.skillTypeParam.bonus
	if not bonusCfg then
		return nil
	end
	local bonus = {}
	for k, maxMult in pairs(bonusCfg) do
		local attrId = tonumber(string.sub(k, 2))
		if attrId then
			bonus[attrId] = 1 + (maxMult - 1) * chargeRatio
		end
	end
	return bonus
end

---将蓄力倍率应用到技能基础属性
---@param attrMap table<integer, number>
---@param chargeBonus table<integer, number>|nil
function SurvivalSkillManager:ApplyChargeBonus(attrMap, chargeBonus)
	if not attrMap or not chargeBonus then
		return
	end
	for attrId, mult in pairs(chargeBonus) do
		if attrMap[attrId] then
			attrMap[attrId] = attrMap[attrId] * mult
		end
	end
end

-------------------------技能相关函数-------------------------
--#region

---创建子弹
---@param role SurvivalRole 角色对象
---@param skillId integer 技能id
---@param overrideDirection Vector3|nil 手动指定射击方向
---@param chargeBonus table<integer, number>|nil 蓄力属性倍率
---@return skillFeedBack table? 技能反馈
function SurvivalSkillManager:CreateBullet(role, skillId, overrideDirection, chargeBonus)
	local cfg = Config.GetSurvivorSkillInfo(skillId)
	if not cfg then
		LuaLogger.ws("SurvivalSkillManager:CreateBullet: skill not found: ", skillId)
		return false
	end
	local skillParam = cfg.effectParameter
	local aimParam = skillParam[3]	--{起点, 方向, 规则}
	local damageType = skillParam[4]	--伤害类型
	local _, directionType, aimRuleList = self:ParseAimParam(aimParam)
	local forbiddenList, priorityList, onlyList = self:ParseAimRules(aimRuleList)
	local skillAttr = self:GetBaseAttrFormSkill(skillParam)
	local leadSpeed = skillAttr[GE.SurvivalAttribType.BulletSpeed] or 10
	local canCreate, target, shootDirection
	if self:IsManualSkill(cfg) then
		canCreate, target, shootDirection = self:ResolveManualSkillAim(role, overrideDirection)
	else
		canCreate, target, shootDirection = self:ResolveSkillAim(
			role, directionType, onlyList, priorityList, forbiddenList, overrideDirection, leadSpeed)
	end
	-- 子弹起点：startPos=0 默认（角色位置+Range 高度），startPos=1 脚下高度
	local startPos = self:ResolveBulletStartPos(role, skillParam)
	if canCreate then
		local roleAttr = role:GetAllAttr()
		-- LuaLogger.ds("SurvivalSkillManager:CreateBullet: roleAttr: ", tablex.dump(roleAttr))
		--散射、数量相关属性加持
		local roleAttrAdd = self:GetBaseAttrFromRole(roleAttr, skillParam)
		local skillAttrAdd = self:GetBaseAttrFormSkill(skillParam)
		-- LuaLogger.ds("SurvivalSkillManager:CreateBullet: roleAttrAdd: ", tablex.dump(roleAttrAdd))
		-- LuaLogger.ds("SurvivalSkillManager:CreateBullet: skillAttrAdd: ", tablex.dump(skillAttrAdd))
		local roleExtraBulletNum = roleAttrAdd[GE.SurvivalAttribType.ExtraBulletNum] or 0
		local skillBulletNum = skillAttrAdd[GE.SurvivalAttribType.ExtraBulletNum] or 1
		local bulletNum = math.floor(roleExtraBulletNum + skillBulletNum)
		--测试
		-- local bulletNum = 3
		local roleExtraBulletAngle = roleAttrAdd[GE.SurvivalAttribType.BulletAngle] or 0
		local skillBulletAngle = skillAttrAdd[GE.SurvivalAttribType.BulletAngle] or 30
		local bulletAngle = math.floor(roleExtraBulletAngle + skillBulletAngle)
		--计算最左边的子弹角度
		local startAngle = - (bulletNum - 1) * bulletAngle / 2
		for i = 1, bulletNum do
			local dir = self:RotateDirection(shootDirection, startAngle + (i - 1) * bulletAngle)
			-- 每次独立传参：CreateBullet 异步加载，复用同一 table 会导致回调读到最后一发的 direction
			SurvivalManager.instance():GetBulletMgr():CreateBullet({
				skillId = skillId,
				ownerRoleId = role.id,
				roleAttribute = roleAttr,
				direction = dir,
				position = startPos,
				team = role:GetTeam(),
				damageType = damageType,
				onlyList = onlyList,
				forbiddenList = forbiddenList,
				chargeBonus = chargeBonus,
				bulletName = cfg.bullet,
			})
		end
	end
	local feedBack = {
		direction = shootDirection,
		target = target,
	}
	return canCreate, feedBack
end

---解析子弹发射位置（effectParameter[5].startPos）
---@param role SurvivalRole
---@param skillParam table
---@return Vector3
function SurvivalSkillManager:ResolveBulletStartPos(role, skillParam)
	local rolePos = role:GetPosition()
	local extParam = skillParam[5]
	if extParam and extParam.startPos == 1 then
		return rolePos
	end
	return rolePos + Vector3.up * role:GetAttr(GE.SurvivalAttribType.Range)
end

---解析瞄准规则
---@param aimRuleList table
---@return table forbiddenList, table priorityList, table onlyList
function SurvivalSkillManager:ParseAimRules(aimRuleList)
	local forbiddenList = {}
	local priorityList = {}
	local onlyList = {}
	if not aimRuleList then
		return forbiddenList, priorityList, onlyList
	end
	for _, aniRule in pairs(aimRuleList) do
		local aimRuleType = aniRule[1]
		local aimRuleDetail = aniRule[2]
		if aimRuleType == GE.SurvivalAimRule.Priority then
			priorityList = aimRuleDetail
		elseif aimRuleType == GE.SurvivalAimRule.Only then
			onlyList = aimRuleDetail
		elseif aimRuleType == GE.SurvivalAimRule.Forbid then
			forbiddenList = aimRuleDetail
		end
	end
	return forbiddenList, priorityList, onlyList
end

---解析 effectParameter[3]：{起点, 方向, 瞄准规则}
---@param aimParam table
---@return integer originType, integer directionType, table|nil aimRuleList
function SurvivalSkillManager:ParseAimParam(aimParam)
	aimParam = aimParam or {}
	return aimParam[1] or GE.SurvivalSkillOrigin.Self,
		aimParam[2] or GE.SurvivalAimType.NearbyDirection,
		aimParam[3]
end

---@param cfg table|nil
---@return boolean
function SurvivalSkillManager:IsManualSkill(cfg)
	return cfg ~= nil and cfg.skillType == GE.SurvivalSkillReleaseType.Manual
end

---主动技能：自身为起点，玩家操作方向，射出后方向不再变化
---@param role SurvivalRole
---@param overrideDirection Vector3|nil
---@return boolean canAim, SurvivalRole|nil target, Vector3 shootDirection
function SurvivalSkillManager:ResolveManualSkillAim(role, overrideDirection)
	local dir = role:GetDirection()
	if overrideDirection and overrideDirection ~= Vector3.zero then
		dir = Vector3(overrideDirection.x, 0, overrideDirection.z).normalized
	elseif dir == Vector3.zero then
		dir = Vector3.forward
	end
	return true, nil, dir
end

---根据起点类型计算区域圆心/激光起点（创建时）
---@param role SurvivalRole
---@param originType integer
---@param directionType SurvivalAimType
---@param target SurvivalRole|nil
---@param projectileSpeed number|nil 子弹弹速
---@param leadTime number|nil AoE 扩散耗时 expandMaxTime
---@return Vector3|nil
function SurvivalSkillManager:ResolveSkillOrigin(role, originType, directionType, target, projectileSpeed, leadTime)
	local rolePos = role:GetPosition()
	--固定坐标
	if originType == GE.SurvivalSkillOrigin.FixedPoint then
		return rolePos
	end
	--目标点
	if originType == GE.SurvivalSkillOrigin.AimTarget then
		if target then
			return self:GetAimPosition(rolePos, target, directionType, projectileSpeed, leadTime)
		end
		return nil
	end
	return rolePos
end

---@param fromPos Vector3
---@param toPos Vector3
---@return Vector3|nil
function SurvivalSkillManager:CalcDirectionTo(fromPos, toPos)
	local dx = toPos.x - fromPos.x
	local dz = toPos.z - fromPos.z
	local mag = math.sqrt(dx * dx + dz * dz)
	if mag > 0 then
		return Vector3(dx / mag, 0, dz / mag)
	end
	return nil
end

---@param projectileSpeed number|nil 子弹弹速（dist/speed 推算飞行时间）
---@param leadTime number|nil 固定预判时间（AoE 用 expandMaxTime，优先于弹速）
---@return Vector3
function SurvivalSkillManager:CalcPredictedAimPoint(origin, target, projectileSpeed, leadTime)
	local tpos = target:GetPosition()
	local moveDir = target:GetDirection()
	local moveSpeed = target:GetAttr(GE.SurvivalAttribType.MoveSpeed) or 0
	if moveDir == Vector3.zero or moveSpeed <= 0 then
		return tpos
	end
	local time = leadTime
	if not time or time <= 0 then
		local speed = projectileSpeed
		if not speed or speed <= 0 then
			return tpos
		end
		local dx = tpos.x - origin.x
		local dz = tpos.z - origin.z
		local dist = math.sqrt(dx * dx + dz * dz)
		time = dist / speed
	end
	return Vector3(
		tpos.x + moveDir.x * moveSpeed * time,
		tpos.y,
		tpos.z + moveDir.z * moveSpeed * time
	)
end

---@param projectileSpeed number|nil
---@param leadTime number|nil
---@return Vector3
function SurvivalSkillManager:GetAimPosition(origin, target, aimType, projectileSpeed, leadTime)
	if aimType == GE.SurvivalAimType.NearbyAimForward then
		return self:CalcPredictedAimPoint(origin, target, projectileSpeed, leadTime)
	end
	return target:GetPosition()
end

---按瞄准类型解析射击方向
---@param role SurvivalRole
---@param directionType integer|nil
---@param onlyList table
---@param priorityList table
---@param forbiddenList table
---@param overrideDirection Vector3|nil
---@param projectileSpeed number|nil 子弹弹速（预判落点用）
---@param leadTime number|nil AoE 固定预判时间 expandMaxTime
---@return boolean canAim, SurvivalRole|nil target, Vector3 shootDirection
function SurvivalSkillManager:ResolveSkillAim(role, directionType, onlyList, priorityList, forbiddenList, overrideDirection, projectileSpeed, leadTime)
	local defaultDir = role:GetDirection()
	if defaultDir == Vector3.zero then
		defaultDir = Vector3.forward
	end
	if not directionType or directionType <= 0 then
		if overrideDirection and overrideDirection ~= Vector3.zero then
			return true, nil, Vector3(overrideDirection.x, 0, overrideDirection.z).normalized
		end
		return true, nil, defaultDir
	end

	if directionType == GE.SurvivalAimType.NearbyDirection then
		if overrideDirection and overrideDirection ~= Vector3.zero then
			return true, nil, Vector3(overrideDirection.x, 0, overrideDirection.z).normalized
		end
		local target = self:GetTarget(role, directionType, onlyList, priorityList, forbiddenList)
		if not target then
			return false, nil, defaultDir
		end
		local dir = self:CalcDirectionTo(role:GetPosition(), target:GetPosition())
		if not dir then
			return false, target, defaultDir
		end
		return true, target, dir
	end

	local target = self:GetTarget(role, directionType, onlyList, priorityList, forbiddenList)
	if not target then
		return false, nil, defaultDir
	end
	local origin = role:GetPosition()
	local aimPos = self:GetAimPosition(origin, target, directionType, projectileSpeed, leadTime)
	local dir = self:CalcDirectionTo(origin, aimPos)
	if not dir then
		return false, target, defaultDir
	end
	return true, target, dir
end

---创建区域效果（冲击波/导弹AoE等）
---@param role SurvivalRole
---@param skillId integer
---@param overrideDirection Vector3|nil
---@param chargeBonus table<integer, number>|nil
---@return boolean, skillFeedBack?
function SurvivalSkillManager:CreateAreaEffect(role, skillId, overrideDirection, chargeBonus)
	local cfg = Config.GetSurvivorSkillInfo(skillId)
	if not cfg then
		LuaLogger.ws("SurvivalSkillManager:CreateAreaEffect: skill not found: ", skillId)
		return false
	end
	local skillParam = cfg.effectParameter
	local aimParam = skillParam[3] or {}
	local damageType = skillParam[4]
	local areaParam = skillParam[5] or {}
	local originType, directionType, aimRuleList = self:ParseAimParam(aimParam)
	local forbiddenList, priorityList, onlyList = self:ParseAimRules(aimRuleList)
	local settleMode = areaParam.settle or GE.SurvivalAreaSettle.ExpandSweep
	local shapeType = areaParam.shape or GE.SurvivalAreaShape.Circle
	local expandMaxTime = areaParam.expandMaxTime
	local sustainTime = areaParam.sustainTime or expandMaxTime
	local interval = areaParam.interval
	local knockbackSpeed = areaParam.knockbackSpeed
	local knockbackDuration = areaParam.knockbackDuration

	local canCreate = true
	local target = nil
	local centerPos = role:GetPosition()
	local effectiveOrigin = GE.SurvivalSkillOrigin.Self
	local beamAimType = 0
	local shootDirection = role:GetDirection()

	if self:IsManualSkill(cfg) then
		canCreate, target, shootDirection = self:ResolveManualSkillAim(role, overrideDirection)
		centerPos = role:GetPosition()
	else
		effectiveOrigin = originType
		local leadTime = expandMaxTime and expandMaxTime > 0 and expandMaxTime or nil
		local canAim, aimTarget, resolvedDir = self:ResolveSkillAim(
			role, directionType, onlyList, priorityList, forbiddenList, overrideDirection, nil, leadTime)
		if not canAim then
			canCreate = false
		else
			target = aimTarget
			shootDirection = resolvedDir
			if shootDirection == Vector3.zero then
				shootDirection = role:GetDirection()
			end
			local originPos = self:ResolveSkillOrigin(role, effectiveOrigin, directionType, target, nil, leadTime)
			if not originPos then
				canCreate = false
			else
				centerPos = originPos
			end
		end
		if shapeType == GE.SurvivalAreaShape.Beam and directionType == GE.SurvivalAimType.NearbyFollow then
			beamAimType = directionType
		end
	end

	if canCreate then
		local roleAttr = role:GetAllAttr()
		local beamDirection = Vector3(shootDirection.x, 0, shootDirection.z)
		if beamDirection == Vector3.zero then
			beamDirection = Vector3.forward
		else
			beamDirection = beamDirection.normalized
		end
		SurvivalManager.instance():GetAreaEffectMgr():CreateAreaEffect({
			skillId = skillId,
			ownerRoleId = role.id,
			roleAttribute = roleAttr,
			team = role:GetTeam(),
			damageType = damageType,
			onlyList = onlyList,
			forbiddenList = forbiddenList,
			priorityList = priorityList,
			originType = effectiveOrigin,
			settleMode = settleMode,
			shapeType = shapeType,
			centerPos = centerPos,
			beamDirection = beamDirection,
			beamTargetRoleId = target and target.id or 0,
			beamAimType = beamAimType,
			expandMaxTime = expandMaxTime,
			sustainTime = sustainTime,
			interval = interval,
			knockbackSpeed = knockbackSpeed,
			knockbackDuration = knockbackDuration,
			chargeBonus = chargeBonus,
			effectName = cfg.bullet,
		})
	end

	local feedBack = {
		direction = shootDirection,
		target = target,
	}
	return canCreate, feedBack
end

---旋转方向向量
---@param direction Vector3 原始方向
---@param angle number 旋转角度（度数）
---@return Vector3 旋转后的方向
function SurvivalSkillManager:RotateDirection(direction, angle)
    if angle == 0 then
        return direction
    end
    
    -- 将角度转换为弧度
    local rad = math.rad(angle)
    
    -- 2D旋转（假设在XY平面或XZ平面，这里以XZ平面为例）
    local cosAngle = math.cos(rad)
    local sinAngle = math.sin(rad)
    
    -- 根据你的坐标系调整，Unity通常使用XZ平面
    return Vector3(
        direction.x * cosAngle - direction.z * sinAngle,
        direction.y,
        direction.x * sinAngle + direction.z * cosAngle
    )
end

--#endregion
-------------------------技能相关函数-------------------------

---@class skillFeedBack
---@field direction Vector3? 技能方向
---@field target SurvivalRole? 技能目标
---执行技能 部分技能有执行结果判断
---@param role SurvivalRole	角色对象
---@param index integer 角色技能索引
---@param overrideDirection Vector3|nil 手动指定射击方向
---@param chargeRatio number|nil 蓄力比例 0~1
---@return boolean 是否成功使用 进cd
function SurvivalSkillManager:DoSkill(role, index, overrideDirection, chargeRatio)
	local skill = role:GetSkillByIndex(index)
	local cfg = Config.GetSurvivorSkillInfo(skill.skillId)
	if not cfg then
		LuaLogger.ws("SurvivalSkillManager:DoSkill: skill not found: ", skill.skillId)
		return false
	end
	local isSucceed = false
	local feedBack = {}
	local effectType = cfg.effectType
	local chargeBonus = self:CalcChargeBonus(skill.skillId, chargeRatio or 0)
	if self._skillFunctionList[effectType] then
		isSucceed, feedBack = self._skillFunctionList[effectType](self, role, skill.skillId, overrideDirection, chargeBonus)
	end
	return isSucceed, feedBack
end

--根据技能配置获取目标 敌方阵营
function SurvivalSkillManager:GetTarget(role, aimType, onlyList, priorityList, forbiddenList)
	local SurvivalRoleManager = SurvivalManager.instance():GetRoleMgr()
	local target = nil
	local team = role:GetTeam()
	local targetTeam = nil
	if team == GE.SurvivalTeam.enemy then
		targetTeam = GE.SurvivalTeam.friend
	elseif team == GE.SurvivalTeam.friend then
		targetTeam = GE.SurvivalTeam.enemy
	end
	local targetRoleList = {}
	local roleTypeList = SurvivalRoleManager:GetRoleTypeList(targetTeam)
	local targetRoleList = SurvivalRoleManager:GetRoleList(targetTeam, true)
	local filterResult = {}
	--仅对xxx类型生效
	if onlyList and #onlyList > 0 then
		for _, targetType in pairs(onlyList) do
			--有符合条件的角色
			local roleIdList = roleTypeList[targetType] or {}
			for _, roleId in pairs(roleIdList) do
				local r = SurvivalRoleManager:GetRole(roleId)
				if SurvivalRoleManager:IsCombatTarget(r) then
					insert(filterResult, r)
				end
			end
		end
	--不对xxx生效
	elseif forbiddenList and #forbiddenList > 0 then
		for _, forbiddenType in pairs(forbiddenList) do
			for shipType, roleIdList in pairs(roleTypeList) do
				if not tablex.contains(forbiddenList, shipType) then
					for _, roleId in pairs(roleIdList) do
						local r = SurvivalRoleManager:GetRole(roleId)
						if SurvivalRoleManager:IsCombatTarget(r) then
							insert(filterResult, r)
						end
					end
				end
			end
		end
	else
		for _, r in pairs(SurvivalRoleManager:GetRoleList(targetTeam, false)) do
			if SurvivalRoleManager:IsCombatTarget(r) then
				insert(filterResult, r)
			end
		end
	end
	--筛选结果为空，则没有目标
	if #filterResult == 0 then
		return nil
	end
	local priorityFilterResult = {}
	--在根据优先级筛选
	if priorityList and #priorityList > 0 then
		for i = #filterResult, 1, -1 do
			for _, targetType in pairs(priorityList) do
				if filterResult[i]:GetShipType() == targetType then
					--符合优先级条件
					--移除当前目标，添加到优先级筛选结果中
					local role = remove(filterResult, i)
					insert(priorityFilterResult, role)
					break	
				end
			end
		end
	end
	--优先级筛选结果为空，则返回所有结果
	local targetList = filterResult
	if #priorityFilterResult > 0 then
		targetList = priorityFilterResult
	end
	-- LuaLogger.ds("SurvivalSkillManager:GetTarget: 最终targetList: ", tablex.dump(targetList))
	--根据距离排序，选择最近的目标
	local minDistance = nil
	for _, targetRole in pairs(targetList) do
		if SurvivalRoleManager:IsCombatTarget(targetRole) then
			local distance = (targetRole:GetPosition() - role:GetPosition()).magnitude
			if minDistance == nil or distance < minDistance then
				minDistance = distance
				target = targetRole
			end
		end
	end
	return target
end

---触发trigger
---@param role SurvivalRole	角色对象
---@param type SurvivalSkillTriggerType	trigger类型
function SurvivalSkillManager:Trigger(role, type)
	if not role or not role:IsAlive() then
		return
	end
	for index, skill in pairs(role.skillList) do
		if not skill then
			goto continue
		end
		local cfg = Config.GetSurvivorSkillInfo(skill.skillId)
		if not cfg or not cfg.trigger or cfg.trigger[1] ~= type then
			goto continue
		end
		if skill.cdRemain > 0 then
			goto continue
		end
		local probability = cfg.trigger[2]
		if probability and math.random(1, 100) > probability then
			goto continue
		end
		local isUsed, feedBack = self:DoSkill(role, index)
		if isUsed then
			skill.cdRemain = skill.MaxCd
			role:_notifySkillCdChange(index)
		end
		::continue::
	end
end

---汇总角色已持有技能中的基础属性加成（effectType = AttributeBonus）
---@param role SurvivalRole
---@return table<SurvivalAttribType, number>
function SurvivalSkillManager:CollectSkillAttrBonus(role)
	local bonus = {}
	if not role or not role.skillList then
		return bonus
	end
	for _, skill in pairs(role.skillList) do
		local cfg = Config.GetSurvivorSkillInfo(skill.skillId)
		if cfg and cfg.effectType == GE.SurvivalSkillType.AttributeBonus and cfg.effectParameter then
			local attrMap = self:GetBaseAttrFormSkill(cfg.effectParameter)
			for attrId, value in pairs(attrMap) do
				bonus[attrId] = (bonus[attrId] or 0) + value
			end
		end
	end
	return bonus
end

---属性加成类技能（添加时由 RefreshAttr 结算，DoSkill 仅刷新属性）
---@param role SurvivalRole
---@return boolean, skillFeedBack?
function SurvivalSkillManager:ApplyAttributeBonus(role)
	if not role then
		return false
	end
	role:RefreshAttr(false)
	return true, {}
end

---实例化
---@return SurvivalSkillManager SurvivalSkillManager
function SurvivalSkillManager.instance()
	if (SurvivalSkillManager._instance == nil) then
		SurvivalSkillManager._instance = SurvivalSkillManager:new()
	end
	return SurvivalSkillManager._instance
end


function SurvivalSkillManager:Clear()
	
end

return SurvivalSkillManager