--- 自走棋 AI 上下文适配器：AI 模块与 AutoChess 战斗框架的唯一桥接层
--- 迁移 AI 时只需替换本文件（或注入另一套 Context 实现）
---@class AutoChessAIContext
local AutoChessAIContext = class("AutoChessAIContext")

---@param entity AutoChessEntity 绑定的战斗单位
function AutoChessAIContext:ctor(entity)
	self.entity = entity
end

---当前上下文所属实体
---@return AutoChessEntity
function AutoChessAIContext:GetEntity()
	return self.entity
end

---是否处于 AI 演示战斗且战斗进行中
---@return boolean
function AutoChessAIContext:IsActive()
	local mgr = AutoChessManager.instance()
	return mgr.isBattleing and mgr.isAIBattle
end

---单位是否已死亡或销毁
---@param entity AutoChessEntity
---@return boolean
function AutoChessAIContext:IsDead(entity)
	return entity:IsDead()
end

---当前实体是否正在施法
---@return boolean
function AutoChessAIContext:IsCasting()
	local sc = self.entity.skillController
	return sc ~= nil and sc.castingSkill ~= nil
end

---当前实体是否正在移动（含格子移动与对齐）
---@return boolean
function AutoChessAIContext:IsMoving()
	local mc = self.entity.moveController
	return mc ~= nil and mc.isMoveing
end

---当前实体是否允许发起移动
---@return boolean
function AutoChessAIContext:CanMove()
	return self.entity:CanMove()
end

---战斗地图（地形、寻路）
---@return AutoChessMap?
function AutoChessAIContext:GetMap()
	return AutoChessManager.instance().map
end

---实体世界坐标是否已对齐格心（决策前需到位）
---@param entity AutoChessEntity
---@return boolean
function AutoChessAIContext:IsOnGridCenter(entity)
	return AutoChessManager.instance():IsEntityOnGridCenter(entity)
end

---世界坐标转格子坐标
---@param x number
---@param z number
---@return integer gx
---@return integer gy
function AutoChessAIContext:WorldToGrid(x, z)
	return AutoChessManager.instance():WorldPosToGridPos(x, z)
end

---逻辑占格（移动中固定为出发格，避免插值中途坐标抖动）
---@param entity AutoChessEntity
---@return integer gx
---@return integer gy
function AutoChessAIContext:GetGridPos(entity)
	entity = entity or self.entity
	if entity == nil then
		return 0, 0
	end
	return entity:GetLogicalGridPos()
end

---获取单位阵营（1=友方演示侧，2=敌方镜像）
---@param entity AutoChessEntity
---@return integer
function AutoChessAIContext:GetSide(entity)
	return entity:GetSide() or 1
end

---判断另一单位是否为敌方
---@param other AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsEnemy(other)
	if other == nil then
		return false
	end
	return other:GetSide() ~= self.entity:GetSide()
end

---敌方开局站位重心（无数据时回退地图对侧边缘）
---@param entity AutoChessEntity?
---@return integer gx
---@return integer gy
function AutoChessAIContext:GetEnemyDeployGrid(entity)
	entity = entity or self.entity
	return AutoChessManager.instance():GetEnemyDeployAnchor(entity)
end

---@param entity AutoChessEntity
---@return integer
function AutoChessAIContext:GetUID(entity)
	return entity:GetUID()
end

---A* 寻路（排除自身占格，返回逐格路点供 AI 取首步）
---@param gx integer
---@param gy integer
---@param tx integer
---@param ty integer
---@return Vector3[]?
function AutoChessAIContext:FindPath(gx, gy, tx, ty)
	local map = self:GetMap()
	if map == nil then
		return nil
	end
	return map:FindPath(gx, gy, tx, ty, self.entity:GetUID(), true)
end

---地图宽高（格子数）
---@return integer w
---@return integer h
function AutoChessAIContext:GetMapSize()
	local map = self:GetMap()
	if map == nil then
		return 0, 0
	end
	return map:GetMapSize()
end

---地形阻挡值（0=可走，非0=障碍）
---@param gx integer
---@param gy integer
---@return integer
function AutoChessAIContext:GetMapBlock(gx, gy)
	local map = self:GetMap()
	if map == nil then
		return 1
	end
	return map:GetMapBlockVal(gx, gy)
end

---技能释放优先级列表（来自技能控制器，按表 releasePriorityLv 排序）
---@return int[]?
function AutoChessAIContext:GetSkillPriority()
	local sc = self.entity.skillController
	if sc == nil then
		return nil
	end
	return sc.skillPriority
end

---读取技能表配置
---@param skillId integer
---@return AutoChessSkillTable?
function AutoChessAIContext:GetSkillCfg(skillId)
	return Config.GetAutoChessSkillTable(skillId)
end

---按技能索敌规则搜索攻击目标
---@param skillId integer
---@return AutoChessEntity?
function AutoChessAIContext:SearchAttackTarget(skillId)
	local sc = self.entity.skillController
	if sc == nil or sc.SearchAttackTarget == nil then
		return nil
	end
	return sc:SearchAttackTarget(skillId)
end

---获取技能控制器当前锁定的目标
---@param skillId integer
---@return AutoChessEntity?
function AutoChessAIContext:GetSkillTarget(skillId)
	local sc = self.entity.skillController
	if sc == nil or sc.GetSkillTarget == nil then
		return nil
	end
	return sc:GetSkillTarget(skillId)
end

---技能 targetMask 是否包含指定索敌类型
---@param mask integer
---@param flag integer
---@return boolean
function AutoChessAIContext:HasSearchMaskFlag(mask, flag)
	return AutoChessManager.instance():HasFlag(mask, flag)
end

---在技能射程内查找敌方单位
---@param skillCfg AutoChessSkillTable
---@return AutoChessEntity?
function AutoChessAIContext:FindEnemyInSkillRange(skillCfg)
	return AutoChessManager.instance():FindEnemyInSkillRange(self.entity, skillCfg)
end

---在技能射程内查找友方单位
---@param skillCfg AutoChessSkillTable
---@return AutoChessEntity?
function AutoChessAIContext:FindAllyInSkillRange(skillCfg)
	return AutoChessManager.instance():FindAllyInSkillRange(self.entity, skillCfg)
end

---查找最近敌方（不限定技能射程）
---@return AutoChessEntity?
function AutoChessAIContext:FindNearestEnemy()
	return AutoChessManager.instance():FindNearestEnemy(self.entity)
end

---@param entity AutoChessEntity
---@param target AutoChessEntity
---@return number dis -1 表示失败
function AutoChessAIContext:GetEntityDistance(entity, target)
	return AutoChessManager.instance():GetEnitytDistance(self:GetUID(entity), self:GetUID(target))
end

---技能控制器推荐的可释放技能 id
---@return integer
function AutoChessAIContext:GetBestSkillId()
	local sc = self.entity.skillController
	if sc == nil then
		return 0
	end
	return sc:GetBestSkillId()
end

---对指定目标推荐的可释放技能 id
---@param targetUid integer
---@return integer
function AutoChessAIContext:GetBestSkillIdForTarget(targetUid)
	local sc = self.entity.skillController
	if sc == nil or sc.GetBestSkillIdForTarget == nil then
		return 0
	end
	return sc:GetBestSkillIdForTarget(targetUid)
end

---格上是否已有单位站立或已被他人预约
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity
---@return boolean
function AutoChessAIContext:IsGridOccupied(gx, gy, entity)
	return AutoChessManager.instance():IsGridOccupiedByUnit(gx, gy, self:GetUID(entity))
end

---选步时是否不能落脚（等同 IsGridBlockedForLanding，历史别名）
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridBlockedForStep(gx, gy, entity)
	entity = entity or self.entity
	return AutoChessManager.instance():IsGridBlockedForLanding(entity, gx, gy)
end

---过境格是否被敌方阻挡（友军可穿过）
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridBlockedForTransit(gx, gy, entity)
	entity = entity or self.entity
	return AutoChessManager.instance():IsGridBlockedForTransit(entity, gx, gy)
end

---落脚格是否被占（敌方、友方非让位、他人预约）
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridBlockedForLanding(gx, gy, entity)
	entity = entity or self.entity
	return AutoChessManager.instance():IsGridBlockedForLanding(entity, gx, gy)
end

---仅判断格上是否已有单位站立或已预留（移动目标格）
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridStandOccupied(gx, gy, entity)
	return AutoChessManager.instance():IsGridOccupiedByUnit(gx, gy, self:GetUID(entity))
end

---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridStandOccupiedByAlly(gx, gy, entity)
	entity = entity or self.entity
	local other = AutoChessManager.instance():GetEntityAtGrid(gx, gy, self:GetUID(entity))
	if other == nil then
		return false
	end
	return other:GetSide() == entity:GetSide()
end

---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridStandOccupiedByEnemy(gx, gy, entity)
	entity = entity or self.entity
	return AutoChessManager.instance():IsGridStandOccupiedByEnemy(gx, gy, entity)
end

---@param gx integer
---@param gy integer
---@param entity AutoChessEntity?
---@return boolean
function AutoChessAIContext:IsGridBlockedByEnemy(gx, gy, entity)
	entity = entity or self.entity
	return AutoChessManager.instance():IsGridBlockedByEnemy(gx, gy, entity)
end

---遍历所有敌方单位
---@param fn fun(enemy: AutoChessEntity)
function AutoChessAIContext:ForEachEnemy(fn)
	AutoChessManager.instance():ForEachEnemyOf(self.entity, fn)
end

---遍历所有友方单位（含自身）
---@param fn fun(ally: AutoChessEntity)
function AutoChessAIContext:ForEachAlly(fn)
	AutoChessManager.instance():ForEachAllyOf(self.entity, fn)
end

---世界技能射程转格子步数（用于站位搜索半径）
---@param range number
---@return integer
function AutoChessAIContext:SkillRangeToGridCount(range)
	return AutoChessManager.instance():SkillRangeToGridCount(range)
end

---同格重叠时按 UID 较大者挪开
---@param entity AutoChessEntity
function AutoChessAIContext:ResolveGridOverlap(entity)
	AutoChessManager.instance():ResolveEntityGridOverlap(entity)
end

---目标格若被其他单位占据，则落到附近空格
---@param gx integer
---@param gy integer
---@param entity AutoChessEntity
---@return integer
---@return integer
function AutoChessAIContext:ResolveVacantGrid(gx, gy, entity)
	return AutoChessManager.instance():FindNearestVacantGrid(gx, gy, self:GetUID(entity))
end

---技能 CD / 资源等是否满足释放条件
---@param skillId integer
---@return boolean
function AutoChessAIContext:CanCast(skillId)
	local sc = self.entity.skillController
	if sc == nil then
		return false
	end
	return sc:CanCast(skillId)
end

---技能对指定目标是否可释放（含射程与 targetMask）
---@param skillId integer
---@param targetUid integer
---@return boolean
function AutoChessAIContext:CanCastSkillOnTarget(skillId, targetUid)
	local sc = self.entity.skillController
	if sc == nil or sc.CanCastOnTarget == nil then
		return false
	end
	if not sc:CanCast(skillId) or not sc:CanCastOnTarget(skillId, targetUid) then
		return false
	end
	local cfg = Config.GetAutoChessSkillTable(skillId)
	if cfg == nil then
		return false
	end
	local target = AutoChessManager.instance():GetEntity(targetUid)
	if target == nil then
		return false
	end
	return AutoChessManager.instance():CheckSearchFilter(self.entity, target, cfg.targetMask)
end

---向技能控制器发起施法
---@param skillId integer
---@param targetUid integer
---@return boolean
function AutoChessAIContext:CastSkill(skillId, targetUid)
	local sc = self.entity.skillController
	if sc == nil then
		return false
	end
	return sc:CastSkill(skillId, targetUid, nil)
end

---设置普攻/技能锁定目标 uid
---@param targetUid integer
function AutoChessAIContext:SetAttackTarget(targetUid)
	self.entity.attackId = targetUid
end

---发起一格格子移动（含意图落脚格 destGx/destGy 供预约与让位）
---@param nextPos Vector3
---@param onArrive fun(entity: AutoChessEntity)?
---@param destGx integer?
---@param destGy integer?
function AutoChessAIContext:MoveToGrid(nextPos, onArrive, destGx, destGy)
	local mc = self.entity.moveController
	if mc == nil then
		return
	end
	local param = nil
	if destGx ~= nil and destGy ~= nil then
		param = { destGx = destGx, destGy = destGy }
	end
	mc:MoveTo({ nextPos }, GE.AutoChessMoveType.Grid, param, onArrive)
end

---平滑对齐到当前逻辑格格心（决策前调用）
---@param onReady fun(entity: AutoChessEntity)?
function AutoChessAIContext:AlignToGridCenter(onReady)
	local mc = self.entity.moveController
	if mc == nil then
		return
	end
	mc:AlignToNearestGridCenter(onReady)
end

---读取实体 cache（决策冷却、上一格、堵死标记等）
---@param key string
---@return any
function AutoChessAIContext:GetCache(key)
	return self.entity:GetCacheDataVal(key)
end

---写入实体 cache
---@param key string
---@param val any
function AutoChessAIContext:SetCache(key, val)
	self.entity:SetCacheDataVal(key, val)
end

return AutoChessAIContext
