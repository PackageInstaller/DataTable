--- AI 行为基类：只依赖 Context，不直接引用 AutoChessManager / Controller
--- 子类可覆写 GetMarchGrid、OnGridReady 等扩展行为
---@class AIBase
local AIBase = class("AIBase")

local AIConst = require("AIConst")
local AILog = require("AILog")

---日志用：格式化单位标签 s{side}·{name}#{uid}
---@param entity AutoChessEntity?
---@return string
local function formatUnit(entity)
	if entity == nil then
		return "?"
	end
	local side = entity.GetSide and entity:GetSide() or "?"
	local cfg = entity.roleCfg
	local uid = entity.GetUID and entity:GetUID() or "?"
	if cfg ~= nil and cfg.name ~= nil and cfg.name ~= "" then
		return string.format("s%s·%s#%s", side, cfg.name, uid)
	end
	return string.format("s%s·%s#%s", side, entity:GetID(), uid)
end

---日志用：技能 id → 表名
---@param skillId integer
---@return string
local function formatSkill(skillId)
	local cfg = Config.GetAutoChessSkillTable(skillId)
	if cfg ~= nil and cfg.name ~= nil and cfg.name ~= "" then
		return cfg.name
	end
	return tostring(skillId)
end

local function formatGrid(gx, gy)
	return string.format("(%s,%s)", tostring(gx), tostring(gy))
end

---输出移动/决策类日志（受 AIConst.ENABLE_AI_LOG 控制）
---@param entity AutoChessEntity?
---@param fmt string
function AIBase:MoveLog(entity, fmt, ...)
	AILog.Move(self:GetTag(), "%s " .. fmt, formatUnit(entity), ...)
end

---@param ctx AutoChessAIContext 战斗桥接上下文
function AIBase:ctor(ctx)
	self.ctx = ctx
	self.aiTag = "AIBase"
end

---AI 脚本标识（日志 tag）
---@return string
function AIBase:GetTag()
	return self.aiTag
end

---根据 targetMask / 伤害类型推断技能意图
---@param cfg AutoChessSkillTable?
---@return string intent enemy|ally|self
function AIBase:GetSkillIntent(cfg)
	if cfg == nil then
		return "enemy"
	end
	local mask = cfg.targetMask or 0
	local hasEnemy = self.ctx:HasSearchMaskFlag(mask, GE.AutoChessSearchType.Enemy)
	local hasFriend = self.ctx:HasSearchMaskFlag(mask, GE.AutoChessSearchType.Friend)
	local hasMe = self.ctx:HasSearchMaskFlag(mask, GE.AutoChessSearchType.Me)
	local range = cfg.attackRange or 0
	local isHeal = (cfg.baseDamage or 0) < 0

	if hasEnemy and not hasFriend and not isHeal then
		return "enemy"
	end
	if hasEnemy then
		return "enemy"
	end
	if hasMe and not hasFriend then
		return "self"
	end
	if hasFriend and not hasMe then
		return "ally"
	end
	if hasMe and hasFriend then
		return "ally"
	end
	if isHeal then
		return "ally"
	end
	if not hasEnemy and not hasFriend and range <= 0 then
		return "self"
	end
	return "enemy"
end

---是否为对敌攻击类技能
---@param cfg AutoChessSkillTable?
---@return boolean
function AIBase:IsEnemySkill(cfg)
	return cfg ~= nil and self:GetSkillIntent(cfg) == "enemy"
end

---是否为自身增益/自保类技能（不主动移动靠近）
---@param cfg AutoChessSkillTable?
---@return boolean
function AIBase:IsSelfSupportSkill(cfg)
	if cfg == nil or self:IsEnemySkill(cfg) then
		return false
	end
	local mask = cfg.targetMask or 0
	if self.ctx:HasSearchMaskFlag(mask, GE.AutoChessSearchType.Me) then
		return true
	end
	return self:GetSkillIntent(cfg) == "self"
end

---是否为友方辅助类技能（不主动移动靠近友军）
---@param cfg AutoChessSkillTable?
---@return boolean
function AIBase:IsAllySupportSkill(cfg)
	if cfg == nil or self:IsEnemySkill(cfg) then
		return false
	end
	local mask = cfg.targetMask or 0
	return self.ctx:HasSearchMaskFlag(mask, GE.AutoChessSearchType.Friend)
end

---技能施法射程（世界距离，来自 attackRange）
---@param skillId integer
---@return number
function AIBase:GetSkillCastRange(skillId)
	local cfg = self.ctx:GetSkillCfg(skillId)
	if cfg ~= nil and cfg.attackRange ~= nil then
		return cfg.attackRange
	end
	return 0
end

---目标是否在指定技能的施法射程内（含 minAttackRange）
---@param target AutoChessEntity
---@param skillId integer
---@return boolean
function AIBase:IsWithinCastRangeOfSkill(target, skillId)
	local cfg = self.ctx:GetSkillCfg(skillId)
	if cfg == nil or cfg.attackRange == nil or cfg.attackRange <= 0 then
		return true
	end
	local entity = self.ctx:GetEntity()
	local dis = self.ctx:GetEntityDistance(entity, target)
	if dis < 0 then
		return false
	end
	local minR = cfg.minAttackRange or 0
	return dis <= cfg.attackRange and (minR <= 0 or dis >= minR)
end

---友方辅助技能是否值得对目标释放（如治疗仅残血时）
---@param cfg AutoChessSkillTable
---@param target AutoChessEntity?
---@return boolean
function AIBase:ShouldUseSupportSkill(cfg, target)
	if target == nil or self.ctx:IsDead(target) then
		return false
	end
	if (cfg.baseDamage or 0) < 0 then
		return target:GetHp() < target:GetHpMax()
	end
	return true
end

---自身技能是否值得释放
---@param cfg AutoChessSkillTable
---@return boolean
function AIBase:ShouldUseSelfSkill(cfg)
	local entity = self.ctx:GetEntity()
	if (cfg.baseDamage or 0) < 0 then
		return entity:GetHp() < entity:GetHpMax()
	end
	return true
end

---按技能意图解析施法目标（控制器锁定 → 索敌 → 射程内查找）
---@param skillId integer
---@param cfg AutoChessSkillTable
---@param intent string
---@return AutoChessEntity? target
function AIBase:ResolveSkillTarget(skillId, cfg, intent)
	local entity = self.ctx:GetEntity()
	if intent == "self" then
		return entity
	end
	local target = self.ctx:GetSkillTarget(skillId)
	if target ~= nil then
		if intent == "enemy" and (not self.ctx:IsEnemy(target) or self.ctx:IsDead(target)) then
			target = nil
		elseif intent == "ally" and (self.ctx:IsEnemy(target) or self.ctx:IsDead(target)) then
			target = nil
		else
			return target
		end
	end
	if intent == "enemy" then
		target = self.ctx:SearchAttackTarget(skillId)
		if target ~= nil and self.ctx:IsEnemy(target) and not self.ctx:IsDead(target) then
			return target
		end
		return self.ctx:FindEnemyInSkillRange(cfg)
	end
	return target
end

---索敌范围 = 所有技能 attackRange 的并集（取最远射程技能做圆形检测）
---@return number
function AIBase:GetSearchRange()
	return self:GetMaxCastRange()
end

---目标是否在索敌范围内（任一対敌技能 attackRange 圆内）
---@param target AutoChessEntity
---@return boolean
function AIBase:IsWithinSearchRange(target)
	if target == nil or self.ctx:IsDead(target) then
		return false
	end
	local priority = self.ctx:GetSkillPriority()
	if priority == nil then
		return false
	end
	for i = 1, #priority do
		local cfg = self.ctx:GetSkillCfg(priority[i])
		if cfg ~= nil and (cfg.attackRange or 0) > 0 and self:GetSkillIntent(cfg) == "enemy" then
			if self:IsWithinCastRangeOfSkill(target, priority[i]) then
				return true
			end
		end
	end
	return false
end

---在索敌范围内查找任一敌方（遍历全体敌人）
---@return AutoChessEntity?
function AIBase:FindEnemyInSearchRange()
	local skillId, cfg = self:GetSearchSkillCfg()
	if skillId == 0 or cfg == nil then
		return nil
	end
	local target = self.ctx:SearchAttackTarget(skillId)
	if target ~= nil and self.ctx:IsEnemy(target) and not self.ctx:IsDead(target) then
		return target
	end
	target = self.ctx:FindEnemyInSkillRange(cfg)
	if target ~= nil and self.ctx:IsEnemy(target) and not self.ctx:IsDead(target) then
		return target
	end
	return nil
end

---索敌范围内但技能射程外时，选一个可对敌移动的技能
---@return integer skillId
function AIBase:GetFirstEnemyApproachSkillId()
	local priority = self.ctx:GetSkillPriority()
	if priority == nil then
		return 0
	end
	for i = 1, #priority do
		local skillId = priority[i]
		local cfg = self.ctx:GetSkillCfg(skillId)
		if cfg ~= nil and self:GetSkillIntent(cfg) == "enemy" and (cfg.attackRange or 0) > 0 then
			return skillId
		end
	end
	return 0
end

---对敌技能目标解析（索敌内优先 searchEnemy，否则按技能索敌）
---@param skillId integer
---@param cfg AutoChessSkillTable
---@param searchEnemy AutoChessEntity?
---@return AutoChessEntity?
function AIBase:ResolveEnemySkillTarget(skillId, cfg, searchEnemy)
	local target = self:ResolveSkillTarget(skillId, cfg, "enemy")
	if target ~= nil then
		return target
	end
	if searchEnemy == nil or self.ctx:IsDead(searchEnemy) or not self.ctx:IsEnemy(searchEnemy) then
		return nil
	end
	if not self:IsWithinSearchRange(searchEnemy) then
		return nil
	end
	local range = cfg.attackRange or 0
	if range > 0 then
		return searchEnemy
	end
	return nil
end

---友方技能目标解析（射程内友军或 FindAllyInSkillRange）
---@param skillId integer
---@param cfg AutoChessSkillTable
---@param entity AutoChessEntity
---@return AutoChessEntity?
function AIBase:ResolveAllySkillTarget(skillId, cfg, entity)
	local target = self.ctx:GetSkillTarget(skillId)
	if target ~= nil then
		if self.ctx:IsEnemy(target) or self.ctx:IsDead(target) or target == entity then
			target = nil
		else
			return target
		end
	end
	return self.ctx:FindAllyInSkillRange(cfg)
end

---按表 priority 顺序尝试单个技能决策（自身→友方→对敌逻辑内联）
---@param skillId integer
---@param entity AutoChessEntity
---@param searchEnemy AutoChessEntity?
---@return string? action cast|move
---@return integer skillId
---@return AutoChessEntity? target
function AIBase:TryDecideSkill(skillId, entity, searchEnemy)
	if not self.ctx:CanCast(skillId) then
		return nil, 0, nil
	end
	local cfg = self.ctx:GetSkillCfg(skillId)
	if cfg == nil then
		return nil, 0, nil
	end
	if self:IsSelfSupportSkill(cfg) then
		if self:ShouldUseSelfSkill(cfg)
			and self.ctx:CanCastSkillOnTarget(skillId, self.ctx:GetUID(entity)) then
			return "cast", skillId, entity
		end
		return nil, 0, nil
	end
	if self:IsAllySupportSkill(cfg) then
		local target = self:FindBestAllyHealTarget(skillId, cfg, entity)
		if target ~= nil and target ~= entity
			and self:ShouldUseSupportSkill(cfg, target)
			and self:IsWithinCastRangeOfSkill(target, skillId)
			and self.ctx:CanCastSkillOnTarget(skillId, self.ctx:GetUID(target)) then
			return "cast", skillId, target
		end
		return nil, 0, nil
	end
	if self:IsEnemySkill(cfg) then
		local target = self:ResolveEnemySkillTarget(skillId, cfg, searchEnemy)
		if target == nil or not self.ctx:IsEnemy(target) then
			return nil, 0, nil
		end
		if self.ctx:CanCastSkillOnTarget(skillId, self.ctx:GetUID(target)) then
			return "cast", skillId, target
		end
		local range = cfg.attackRange or 0
		if range > 0 and not self:IsWithinCastRangeOfSkill(target, skillId) then
			return "move", skillId, target
		end
	end
	return nil, 0, nil
end

---决策：索敌外行军；索敌内按 releasePriorityLv 单循环选技能
---@return string action cast|move|march
---@return integer skillId
---@return AutoChessEntity? target
function AIBase:DecideAction()
	local priority = self.ctx:GetSkillPriority()
	if priority == nil then
		return "march", 0, nil
	end
	local entity = self.ctx:GetEntity()
	local searchEnemy = self:FindEnemyInSearchRange()

	if searchEnemy == nil then
		return "march", 0, nil
	end

	for i = 1, #priority do
		local action, skillId, target = self:TryDecideSkill(priority[i], entity, searchEnemy)
		if action ~= nil then
			return action, skillId, target
		end
	end

	local approachSkillId = self:GetFirstEnemyApproachSkillId()
	if approachSkillId ~= 0 then
		return "move", approachSkillId, searchEnemy
	end
	return "march", 0, nil
end

---待机时仅评估可立即施放的技能（索敌范围内）
---@return string? action
---@return integer skillId
---@return AutoChessEntity? target
function AIBase:DecideCastOnly()
	local priority = self.ctx:GetSkillPriority()
	if priority == nil or self:FindEnemyInSearchRange() == nil then
		return nil, 0, nil
	end
	local entity = self.ctx:GetEntity()
	local searchEnemy = self:FindEnemyInSearchRange()
	for i = 1, #priority do
		local action, skillId, target = self:TryDecideSkill(priority[i], entity, searchEnemy)
		if action == "cast" then
			return action, skillId, target
		end
	end
	return nil, 0, nil
end

---治疗技能：在射程内选血量比例最低的友方
---@param skillId integer
---@param cfg AutoChessSkillTable
---@param entity AutoChessEntity
---@return AutoChessEntity?
function AIBase:FindBestAllyHealTarget(skillId, cfg, entity)
	if (cfg.baseDamage or 0) >= 0 then
		return self:ResolveAllySkillTarget(skillId, cfg, entity)
	end
	local best, bestRatio = nil, 1.0
	self.ctx:ForEachAlly(function(ally)
		if ally == entity or self.ctx:IsDead(ally) then
			return
		end
		if not self:ShouldUseSupportSkill(cfg, ally) then
			return
		end
		if not self:IsWithinCastRangeOfSkill(ally, skillId) then
			return
		end
		local maxHp = ally:GetHpMax()
		if maxHp <= 0 then
			return
		end
		local ratio = ally:GetHp() / maxHp
		if ratio < bestRatio then
			best, bestRatio = ally, ratio
		end
	end)
	if best ~= nil then
		return best
	end
	return self:ResolveAllySkillTarget(skillId, cfg, entity)
end

---清除「真堵死」标记（找到可移动邻格或成功移动后）
function AIBase:ClearMovementSealed()
	self.ctx:SetCache(AIConst.CACHE_MOVEMENT_SEALED, nil)
end

---标记当前处于真堵死状态（八邻格均无法落脚）
function AIBase:SetMovementSealed()
	self.ctx:SetCache(AIConst.CACHE_MOVEMENT_SEALED, 1)
end

---是否已标记为真堵死
---@return boolean
function AIBase:IsMovementSealedFlag()
	return self.ctx:GetCache(AIConst.CACHE_MOVEMENT_SEALED) ~= nil
end

---索敌用：取对敌技能中 attackRange 最大的技能配置
---@return integer skillId
---@return AutoChessSkillTable? cfg
function AIBase:GetSearchSkillCfg()
	local priority = self.ctx:GetSkillPriority()
	if priority == nil then
		return 0, nil
	end
	local bestSkillId = 0
	local bestRange = 0
	local bestCfg = nil
	for i = 1, #priority do
		local skillId = priority[i]
		local cfg = self.ctx:GetSkillCfg(skillId)
		if cfg ~= nil and self:GetSkillIntent(cfg) == "enemy"
			and cfg.attackRange ~= nil and cfg.attackRange > bestRange then
			bestSkillId = skillId
			bestRange = cfg.attackRange
			bestCfg = cfg
		end
	end
	return bestSkillId, bestCfg
end

---在索敌范围内查找敌人并返回关联索敌技能 id
---@return AutoChessEntity? target
---@return integer skillId
function AIBase:SearchEnemy()
	local target = self:FindEnemyInSearchRange()
	if target == nil then
		return nil, 0
	end
	local skillId, _ = self:GetSearchSkillCfg()
	return target, skillId
end

---尝试对目标释放技能（含 CanCast 校验与攻击日志）
---@param skillId integer
---@param target AutoChessEntity
---@return boolean
function AIBase:TryCastSkill(skillId, target)
	if target == nil or skillId == 0 then
		return false
	end
	self.ctx:SetAttackTarget(target:GetUID())
	local targetUid = target:GetUID()
	if not self.ctx:CanCastSkillOnTarget(skillId, targetUid) then
		return false
	end
	local entity = self.ctx:GetEntity()
	if self.ctx:CastSkill(skillId, targetUid) then
		AILog.AttackSuccess(formatUnit(entity), formatUnit(target), formatSkill(skillId))
		return true
	end
	return false
end

---TryCastSkill 别名（兼容旧调用）
---@param searchSkillId integer
---@param target AutoChessEntity
function AIBase:TryAttack(searchSkillId, target)
	self:TryCastSkill(searchSkillId, target)
end

---螺旋搜索最近可走格（地形障碍时回退）
---@param map AutoChessMap
---@param gx integer
---@param gy integer
---@return integer walkableGx
---@return integer walkableGy
local function findWalkableGrid(map, gx, gy)
	local w, h = map:GetMapSize()
	gx = mathx.clamp(gx, 1, w)
	gy = mathx.clamp(gy, 1, h)
	if map:GetMapBlockVal(gx, gy) == 0 then
		return gx, gy
	end
	for r = 1, math.max(w, h) do
		for dy = -r, r do
			for dx = -r, r do
				local nx, ny = gx + dx, gy + dy
				if nx >= 1 and nx <= w and ny >= 1 and ny <= h then
					if map:GetMapBlockVal(nx, ny) == 0 then
						return nx, ny
					end
				end
			end
		end
	end
	return gx, gy
end

---目标是否在任一（或指定）技能的施法射程内
---@param target AutoChessEntity
---@param skillId integer?
---@return boolean
function AIBase:IsWithinCastRangeOfAnySkill(target, skillId)
	if skillId ~= nil and skillId ~= 0 then
		return self:IsWithinCastRangeOfSkill(target, skillId)
	end
	local priority = self.ctx:GetSkillPriority()
	if priority == nil then
		return false
	end
	for i = 1, #priority do
		if self:IsWithinCastRangeOfSkill(target, priority[i]) then
			return true
		end
	end
	return false
end

---索敌技能的最大施法射程
---@return number
function AIBase:GetMaxCastRange()
	local _, cfg = self:GetSearchSkillCfg()
	if cfg ~= nil and cfg.attackRange ~= nil then
		return cfg.attackRange
	end
	return 0
end

---@param wx number
---@param wz number
---@param enemy AutoChessEntity
---@param maxRange number
---@return boolean
---候选站位是否在追击目标「身后」（相对己方位置），追击敌人时不应选此类格
local function isStandCellBeyondUnit(selfGx, selfGy, focusGx, focusGy, cx, cy)
	local tfx, tfy = focusGx - selfGx, focusGy - selfGy
	local tcx, tcy = cx - selfGx, cy - selfGy
	local len2 = tfx * tfx + tfy * tfy
	if len2 < 0.001 then
		return false
	end
	return (tcx * tfx + tcy * tfy) > len2
end

---@param wx number
---@param wz number
---@param enemy AutoChessEntity
---@param maxRange number
---@return boolean
local function isWorldPosWithinCastRange(wx, wz, enemy, maxRange)
	local pos = enemy:GetPosition()
	local ddx, ddz = wx - pos.x, wz - pos.z
	return (ddx * ddx + ddz * ddz) <= maxRange * maxRange
end

---@param ctx AutoChessAIContext
---@param gx integer
---@param gy integer
---@param cx integer
---@param cy integer
---@return boolean
local function isStandBeyondAnyEnemy(ctx, gx, gy, cx, cy)
	local beyond = false
	ctx:ForEachEnemy(function(e)
		local egx, egy = ctx:GetGridPos(e)
		if isStandCellBeyondUnit(gx, gy, egx, egy, cx, cy) then
			beyond = true
		end
	end)
	return beyond
end

local GREEDY_DIRS = {
	{ 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 },
	{ 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 },
}

---是否为一格步长（含斜向，与棋盘 DIAGONAL 模式一致）
local function isOneGridStep(gx, gy, nx, ny)
	if nx == gx and ny == gy then
		return false
	end
	return math.abs(nx - gx) <= 1 and math.abs(ny - gy) <= 1
end

---@param ctx AutoChessAIContext
local function isMapWalkable(ctx, gx, gy)
	local w, h = ctx:GetMapSize()
	if gx < 1 or gx > w or gy < 1 or gy > h then
		return false
	end
	return ctx:GetMapBlock(gx, gy) == 0
end

---朝行军目标 X 的前进方向（-1/0/1）
local function marchForwardDx(gx, destGx)
	if destGx < gx then return -1 end
	if destGx > gx then return 1 end
	return 0
end

---@param ctx AutoChessAIContext
local function isForwardMapBlocked(ctx, gx, gy, destGx)
	local dx = marchForwardDx(gx, destGx)
	if dx == 0 then return false end
	return not isMapWalkable(ctx, gx + dx, gy)
end

---统计一行上的障碍格数量
---@param ctx AutoChessAIContext
local function countRowWallCells(ctx, gy)
	local w = ctx:GetMapSize()
	local count = 0
	for x = 1, w do
		if not isMapWalkable(ctx, x, gy) then
			count = count + 1
		end
	end
	return count
end

---该行是否构成横墙/隘口（与零星立柱区分，按地图宽度比例判定）
---@param ctx AutoChessAIContext
local function isHorizontalChokeRow(ctx, gy)
	local w = ctx:GetMapSize()
	if w <= 0 then
		return false
	end
	local wallCount = countRowWallCells(ctx, gy)
	return wallCount >= math.max(3, math.ceil(w * 0.3))
end

---横墙隘口行上：朝敌方向被墙挡，但左右仍有可通行格（需侧向绕出）
---@param ctx AutoChessAIContext
local function isOnChokeGapEdge(ctx, gx, gy, destGx)
	if not isHorizontalChokeRow(ctx, gy) then
		return false
	end
	if not isForwardMapBlocked(ctx, gx, gy, destGx) then
		return false
	end
	return isMapWalkable(ctx, gx - 1, gy) or isMapWalkable(ctx, gx + 1, gy)
end

---当前行以下（含）地图上最南的可通行行
---@param ctx AutoChessAIContext
local function getOpenBandBottomGy(ctx, fromGy)
	local w, h = ctx:GetMapSize()
	for y = h, fromGy, -1 do
		for x = 1, w do
			if isMapWalkable(ctx, x, y) then
				return y
			end
		end
	end
	return fromGy
end

---朝敌方向相邻格是否被友军占住（地图墙不算）
---@param ctx AutoChessAIContext
---@param entity AutoChessEntity
local function isForwardAllyLandingBlocked(ctx, entity, gx, gy, destGx)
	local dx = marchForwardDx(gx, destGx)
	if dx == 0 then
		return false
	end
	local nx, ny = gx + dx, gy
	if not isMapWalkable(ctx, nx, ny) then
		return false
	end
	return ctx:IsGridBlockedForLanding(nx, ny, entity)
end

---行军步是否缩短与目标的曼哈顿距离（基于地图阻挡与目标的通用绕路规则）
---@param ctx AutoChessAIContext
---@param entity AutoChessEntity?
local function isMarchStepAdvancing(ctx, entity, gx, gy, nx, ny, destGx, destGy)
	local before = math.abs(destGx - gx) + math.abs(destGy - gy)
	local after = math.abs(destGx - nx) + math.abs(destGy - ny)
	if after < before then
		return true
	end
	local forwardBlocked = isForwardMapBlocked(ctx, gx, gy, destGx)
	local horizontalChoke = isHorizontalChokeRow(ctx, gy)
	-- 行军目标在更低行：允许先向下靠近目标 Y
	if ny > gy and destGy > gy then
		return true
	end
	-- 朝敌方向被地图墙挡：允许距离略增的下行（绕立柱或接近横墙开口）
	if ny > gy and forwardBlocked and after <= before + 1 then
		return true
	end
	-- 同层横移逼近敌方（含绕开立柱）
	if ny == gy and math.abs(destGx - nx) < math.abs(destGx - gx) then
		return true
	end
	-- 横墙开口边：允许暂时横移远离敌方以绕出墙区
	if ny == gy and nx ~= gx and forwardBlocked and horizontalChoke then
		if math.abs(nx - destGx) > math.abs(gx - destGx) and isOnChokeGapEdge(ctx, gx, gy, destGx) then
			return true
		end
	end
	-- 前方友军占位：允许侧移/下行换路
	if entity ~= nil and isForwardAllyLandingBlocked(ctx, entity, gx, gy, destGx) then
		if ny > gy or (ny == gy and nx ~= gx) then
			return true
		end
	end
	return false
end

---@param ctx AutoChessAIContext
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param nx integer
---@param ny integer
---@param preferGx integer
---@param preferGy integer
---@param marchMode boolean?
---@return number
local function scoreAdjacentStep(ctx, entity, gx, gy, nx, ny, preferGx, preferGy, marchMode)
	local score = math.abs(nx - preferGx) + math.abs(ny - preferGy)
	if marchMode then
		local side = entity:GetSide()
		local forwardSign = (side == 2) and -1 or 1
		local xBack = (nx - gx) * forwardSign < 0
		local forwardBlocked = isForwardMapBlocked(ctx, gx, gy, preferGx)
		local forwardAllyBlocked = isForwardAllyLandingBlocked(ctx, entity, gx, gy, preferGx)
		local horizontalChoke = isHorizontalChokeRow(ctx, gy)
		local towardLowerDest = preferGy > gy
		local lateralDetour = ny == gy and nx ~= gx and forwardBlocked and horizontalChoke
			and isOnChokeGapEdge(ctx, gx, gy, preferGx)
			and math.abs(nx - preferGx) > math.abs(gx - preferGx)
		if xBack then
			if (forwardBlocked or forwardAllyBlocked) and ny > gy then
				score = score + 12
			elseif lateralDetour then
				score = score + 12
			else
				score = score + 80
			end
		end
		if forwardAllyBlocked and (ny > gy or ny == gy) then
			score = score - 2
		end
		if towardLowerDest or forwardBlocked then
			if ny > gy then
				score = score - 1.2
			elseif ny < gy then
				score = score + 200
			end
		else
			local progress = math.abs(preferGx - nx) + math.abs(preferGy - ny)
				- (math.abs(preferGx - gx) + math.abs(preferGy - gy))
			if progress > 0 then
				if not (towardLowerDest and ny > gy) then
					score = score + 300
				end
			elseif progress == 0 then
				if not (ny == gy and math.abs(preferGx - nx) < math.abs(preferGx - gx)) then
					score = score + 60
				end
			end
			if towardLowerDest and ny > gy then
				score = score - 1.5
			end
		end
	end
	local lastGx = ctx:GetCache(AIConst.CACHE_LAST_GRID_X)
	local lastGy = ctx:GetCache(AIConst.CACHE_LAST_GRID_Y)
	if lastGx ~= nil and lastGy ~= nil and nx == lastGx and ny == lastGy then
		-- 必要绕路下行/侧移时不因折返惩罚挡住
		local necessaryDetour = marchMode and (
			(ny > gy and (preferGy > gy or isForwardMapBlocked(ctx, gx, gy, preferGx)))
			or (ny == gy and nx ~= gx and isOnChokeGapEdge(ctx, gx, gy, preferGx))
		)
		if not necessaryDetour then
			score = score + 500
		end
	end
	return score
end

local function isLastGridStep(ctx, nx, ny)
	local lastGx = ctx:GetCache(AIConst.CACHE_LAST_GRID_X)
	local lastGy = ctx:GetCache(AIConst.CACHE_LAST_GRID_Y)
	return lastGx ~= nil and lastGy ~= nil and nx == lastGx and ny == lastGy
end

---八邻格是否存在可落脚步（真堵死判定的正向条件）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return boolean
function AIBase:HasAnyAdjacentLandingStep(entity, gx, gy)
	local map = self.ctx:GetMap()
	if map == nil then
		return false
	end
	local w, h = self.ctx:GetMapSize()
	for i = 1, #GREEDY_DIRS do
		local dir = GREEDY_DIRS[i]
		local nx, ny = gx + dir[1], gy + dir[2]
		if nx >= 1 and nx <= w and ny >= 1 and ny <= h then
			if map:GetMapBlockVal(nx, ny) == 0 and not self:IsStepLandingBlocked(entity, nx, ny) then
				return true
			end
		end
	end
	return false
end

---单步落脚是否被挡（敌方占格或友方/预约占格）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return boolean
function AIBase:IsStepLandingBlocked(entity, gx, gy)
	if self.ctx:IsGridBlockedByEnemy(gx, gy, entity) then
		return true
	end
	return self.ctx:IsGridBlockedForLanding(gx, gy, entity)
end

---在八邻格中选评分最优的一步（贪心/行军/绕路评分共用）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param preferGx integer
---@param preferGy integer
---@param marchMode boolean?
---@return integer? stepGx
---@return integer? stepGy
function AIBase:PickBestAdjacentStep(entity, gx, gy, preferGx, preferGy, marchMode)
	local map = self.ctx:GetMap()
	if map == nil then return nil, nil end
	local w, h = self.ctx:GetMapSize()
	local bestGx, bestGy, bestScore = nil, nil, nil
	local fallbackGx, fallbackGy, fallbackScore = nil, nil, nil
	for i = 1, #GREEDY_DIRS do
		local dir = GREEDY_DIRS[i]
		local nx, ny = gx + dir[1], gy + dir[2]
		if nx < 1 or nx > w or ny < 1 or ny > h then goto continue end
		if map:GetMapBlockVal(nx, ny) ~= 0 then goto continue end
		if self:IsStepLandingBlocked(entity, nx, ny) then goto continue end
		local score = scoreAdjacentStep(self.ctx, entity, gx, gy, nx, ny, preferGx, preferGy, marchMode)
		if marchMode and not isMarchStepAdvancing(self.ctx, entity, gx, gy, nx, ny, preferGx, preferGy) then
			score = score + 40
		end
		if isLastGridStep(self.ctx, nx, ny) then
			if fallbackScore == nil or score < fallbackScore then
				fallbackGx, fallbackGy, fallbackScore = nx, ny, score
			end
		elseif bestScore == nil or score < bestScore then
			bestGx, bestGy, bestScore = nx, ny, score
		end
		::continue::
	end
	if bestGx ~= nil then return bestGx, bestGy end
	return fallbackGx, fallbackGy
end

---在敌人射程环内选离自己最近的可站立格（避免双方抢路径上同一格导致穿越）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param enemy AutoChessEntity
---@param maxRange number?
---@return integer? standGx
---@return integer? standGy
function AIBase:FindBestCastStandGrid(entity, gx, gy, enemy, maxRange)
	maxRange = maxRange or self:GetMaxCastRange()
	if maxRange <= 0 then
		return nil, nil
	end
	local map = self.ctx:GetMap()
	if map == nil then
		return nil, nil
	end
	local ex, ey = self.ctx:GetGridPos(enemy)
	local mySide = self.ctx:GetSide(entity)
	local blockBeyond = self.ctx:GetSide(enemy) ~= mySide
	local flankBias = (self.ctx:GetUID(entity) % 2 == 0) and 1 or -1
	local w, h = self.ctx:GetMapSize()
	local span = self.ctx:SkillRangeToGridCount(maxRange) + 1
	local bestGx, bestGy, bestScore = nil, nil, nil
	for dx = -span, span do
		for dy = -span, span do
			local cx, cy = ex + dx, ey + dy
			if cx >= 1 and cx <= w and cy >= 1 and cy <= h then
				if cx ~= ex or cy ~= ey then
					if blockBeyond and isStandBeyondAnyEnemy(self.ctx, gx, gy, cx, cy) then
						-- 不选任何敌人身后的射程格
					elseif map:GetMapBlockVal(cx, cy) == 0 then
						local wx, wz = map:GridToWorldPos(cx, cy)
						if isWorldPosWithinCastRange(wx, wz, enemy, maxRange) then
							local occupiedPenalty = self.ctx:IsGridStandOccupied(cx, cy, entity) and 300 or 0
							local flankPenalty = math.abs(cy - ey - flankBias) * 80
							local score = math.abs(cx - gx) + math.abs(cy - gy)
								+ occupiedPenalty + flankPenalty
							if bestScore == nil or score < bestScore then
								bestGx, bestGy, bestScore = cx, cy, score
							end
						end
					end
				end
			end
		end
	end
	return bestGx, bestGy
end

---行军步：朝敌方半场推进；墙前优先下行绕路，禁止无意义折返
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param destGx integer
---@param destGy integer
---@return integer? stepGx
---@return integer? stepGy
function AIBase:FindMarchStepGrid(entity, gx, gy, destGx, destGy)
	return self:PickBestAdjacentStep(entity, gx, gy, destGx, destGy, true)
end

---寻路失败时退化为贪心选步（行军用 march 模式评分）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param marchGx integer
---@param marchGy integer
---@return integer? stepGx
---@return integer? stepGy
function AIBase:FindGreedyStepGrid(entity, gx, gy, marchGx, marchGy)
	return self:PickBestAdjacentStep(entity, gx, gy, marchGx, marchGy, false)
end

---行军/追击贪心步（技能靠近时排除最末行格，避免无意义折返）
---@return integer? stepGx
---@return integer? stepGy
function AIBase:PickGreedyStep(entity, gx, gy, skillId, focusUnit, marchGx, marchGy)
	local isMarch = (skillId == nil or skillId == 0) and focusUnit == nil
	if isMarch then
		local destGx, destGy = self:GetMarchDestinationGrid(entity, gx, gy)
		local stepGx, stepGy = self:FindMarchStepGrid(entity, gx, gy, destGx, destGy)
		if stepGx ~= nil and stepGy ~= nil and not isLastGridStep(self.ctx, stepGx, stepGy) then
			return stepGx, stepGy
		end
		stepGx, stepGy = self:PickFirstMarchStepGrid(entity, gx, gy, destGx, destGy)
		if stepGx ~= nil and stepGy ~= nil and not isLastGridStep(self.ctx, stepGx, stepGy) then
			return stepGx, stepGy
		end
		return self:FindMarchStepGrid(entity, gx, gy, destGx, destGy)
	end
	return self:FindGreedyStepGrid(entity, gx, gy, marchGx, marchGy)
end

---寻路至行军远端目标，取评分最优的相邻首步
---@return integer? stepGx
---@return integer? stepGy
function AIBase:PickFirstMarchStepGrid(entity, gx, gy, destGx, destGy)
	local waypoints = self.ctx:FindPath(gx, gy, destGx, destGy)
	if waypoints == nil or #waypoints == 0 then
		return nil, nil
	end
	local bestGx, bestGy, bestScore = nil, nil, nil
	for i = 1, #waypoints do
		local wp = waypoints[i]
		local stepGx, stepGy = self.ctx:WorldToGrid(wp.x, wp.z)
		if stepGx == gx and stepGy == gy then
		elseif not isOneGridStep(gx, gy, stepGx, stepGy) then
		elseif self:IsStepLandingBlocked(entity, stepGx, stepGy) then
		else
			local score = scoreAdjacentStep(self.ctx, entity, gx, gy, stepGx, stepGy, destGx, destGy, true)
			if bestScore == nil or score < bestScore then
				bestGx, bestGy, bestScore = stepGx, stepGy, score
			end
		end
	end
	if bestGx ~= nil and isLastGridStep(self.ctx, bestGx, bestGy) then
		local altGx, altGy = self:FindMarchStepGrid(entity, gx, gy, destGx, destGy)
		if altGx ~= nil and not isLastGridStep(self.ctx, altGx, altGy) then
			return altGx, altGy
		end
	end
	return bestGx, bestGy
end

---从寻路结果取首步（落脚被占则换路，不原地等）
---@return integer? stepGx
---@return integer? stepGy
---@return string? reason
function AIBase:PickFirstPathStep(entity, gx, gy, marchGx, marchGy, focusUnit)
	local waypoints = self.ctx:FindPath(gx, gy, marchGx, marchGy)
	if waypoints == nil or #waypoints == 0 then
		return nil, nil, "no_path"
	end
	local bestGx, bestGy, bestScore = nil, nil, nil
	for i = 1, #waypoints do
		local wp = waypoints[i]
		local stepGx, stepGy = self.ctx:WorldToGrid(wp.x, wp.z)
		if stepGx == gx and stepGy == gy then
		elseif not isOneGridStep(gx, gy, stepGx, stepGy) then
		else
			if focusUnit ~= nil then
				local fx, fy = self.ctx:GetGridPos(focusUnit)
				if stepGx == fx and stepGy == fy then
					return nil, nil, "focus_block"
				end
			end
			if self:IsStepLandingBlocked(entity, stepGx, stepGy) then
			else
				local score = scoreAdjacentStep(self.ctx, entity, gx, gy, stepGx, stepGy, marchGx, marchGy, false)
				if bestScore == nil or score < bestScore then
					bestGx, bestGy, bestScore = stepGx, stepGy, score
				end
			end
		end
	end
	if bestGx ~= nil and isLastGridStep(self.ctx, bestGx, bestGy) then
		local altGx, altGy = self:FindGreedyStepGrid(entity, gx, gy, marchGx, marchGy)
		if altGx ~= nil and not isLastGridStep(self.ctx, altGx, altGy) then
			return altGx, altGy, "alt_route"
		end
	end
	if bestGx ~= nil then
		return bestGx, bestGy, "path"
	end
	return nil, nil, "path_blocked"
end

---寻路优先，失败则贪心；返回首步坐标与原因标签
---@return integer? stepGx
---@return integer? stepGy
---@return string? reason path|贪心靠近|greedy|blocked|...
function AIBase:ResolveNextMoveStep(entity, gx, gy, marchGx, marchGy, skillId, focusUnit)
	local isMarch = (skillId == nil or skillId == 0) and focusUnit == nil
	local stepGx, stepGy, reason = self:PickFirstPathStep(entity, gx, gy, marchGx, marchGy, focusUnit)
	if stepGx ~= nil and stepGy ~= nil then
		return stepGx, stepGy, reason
	end
	stepGx, stepGy = self:PickGreedyStep(entity, gx, gy, skillId, focusUnit, marchGx, marchGy)
	if stepGx ~= nil and stepGy ~= nil and (stepGx ~= gx or stepGy ~= gy) then
		if isMarch then
			return stepGx, stepGy, "贪心靠近"
		end
		return stepGx, stepGy, "greedy"
	end
	return nil, nil, reason or "blocked"
end

---真堵死：八邻格均无法落脚时才 sealed（有邻格可绕则不算堵死）
---@return boolean
function AIBase:IsMovementSealed(entity, gx, gy, marchGx, marchGy, skillId, focusUnit)
	if self:HasAnyAdjacentLandingStep(entity, gx, gy) then
		self:ClearMovementSealed()
		return false
	end
	self:SetMovementSealed()
	return true
end

---朝 focus 靠近一格（站位/寻路失败时的行军落点）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param focus AutoChessEntity?
---@return integer
---@return integer
function AIBase:GetMarchTowardFocusGrid(entity, gx, gy, focus)
	if focus == nil or self.ctx:IsDead(focus) then
		return self:GetDefaultMarchGrid(entity, gx, gy)
	end
	local fx, fy = self.ctx:GetGridPos(focus)
	local stepGx, stepGy = self:FindGreedyStepGrid(entity, gx, gy, fx, fy)
	if stepGx ~= nil and stepGy ~= nil then
		return stepGx, stepGy
	end
	return gx, gy
end

---朝敌方向的相邻格是否无法落脚（地图墙或友军占位）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param destGx integer
---@return boolean
function AIBase:IsMarchForwardLandingBlocked(entity, gx, gy, destGx)
	local dx = marchForwardDx(gx, destGx)
	if dx == 0 then
		return false
	end
	local nx, ny = gx + dx, gy
	if not isMapWalkable(self.ctx, nx, ny) then
		return true
	end
	return self:IsStepLandingBlocked(entity, nx, ny)
end

---行军远端目标：敌方 deploy 重心，横墙隘口时拉到底行包抄
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return integer destGx
---@return integer destGy
function AIBase:GetMarchDestinationGrid(entity, gx, gy)
	local deployGx, deployGy = self.ctx:GetEnemyDeployGrid(entity)
	local w, h = self.ctx:GetMapSize()
	local destGx = deployGx
	-- 行军 Y 不低于当前行，避免 deploy 重心 y 把单位拉回上方
	local destGy = math.max(gy, deployGy)
	-- 仅在横墙隘口行且前方受阻时，才把行军 Y 拉到开阔带最南行引导包抄
	local horizontalChoke = isHorizontalChokeRow(self.ctx, gy)
	local needFlank = false
	if horizontalChoke then
		if isOnChokeGapEdge(self.ctx, gx, gy, destGx) then
			needFlank = true
		elseif isForwardMapBlocked(self.ctx, gx, gy, destGx) then
			needFlank = true
		else
			local dx = marchForwardDx(gx, destGx)
			if dx ~= 0 then
				local fx, fy = gx + dx, gy
				if isMapWalkable(self.ctx, fx, fy) and self:IsStepLandingBlocked(entity, fx, fy) then
					needFlank = true
				end
			end
		end
	end
	if needFlank then
		destGy = math.max(destGy, getOpenBandBottomGy(self.ctx, gy))
	end
	if w > 0 then
		destGx = mathx.clamp(destGx, 1, w)
	end
	if h > 0 then
		destGy = mathx.clamp(destGy, 1, h)
	end
	return destGx, destGy
end

---默认行军格：敌方半场远端列（具体 Y 由 GetMarchDestinationGrid 决定）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return integer targetGx
---@return integer targetGy
function AIBase:GetDefaultMarchGrid(entity, gx, gy)
	-- 返回敌方半场远端列，由 PickFirstPathStep 寻路绕行障碍/让开友军
	return self:GetMarchDestinationGrid(entity, gx, gy)
end

---子类可覆写的行军目标格（默认等同 GetDefaultMarchGrid）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return integer targetGx
---@return integer targetGy
function AIBase:GetMarchGrid(entity, gx, gy)
	return self:GetDefaultMarchGrid(entity, gx, gy)
end

---计算本步移动的目标格：追击站位 / 朝 deploy 行军 / 原地 hold
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param focusUnit AutoChessEntity? 追击目标（敌或友）
---@param castSkillId integer?
---@return integer targetGx
---@return integer targetGy
---@return string reason chase|march|hold
function AIBase:GetMoveTargetGrid(entity, gx, gy, focusUnit, castSkillId)
	local focus = focusUnit
	if focus ~= nil and not self.ctx:IsDead(focus) then
		if not self.ctx:IsEnemy(focus) then
			self:MoveLog(entity, "停步: 移动目标非敌方 focus=%s", formatUnit(focus))
			return gx, gy, "hold"
		end
		local castRange = self:GetSkillCastRange(castSkillId or 0)
		if castSkillId ~= nil and castSkillId ~= 0 then
			if self:IsWithinCastRangeOfSkill(focus, castSkillId) then
				self:MoveLog(entity, "停步: 技能[%s]目标%s已在射程内 self=%s target=%s",
					formatSkill(castSkillId), formatUnit(focus), formatGrid(gx, gy),
					formatGrid(self.ctx:GetGridPos(focus)))
				return gx, gy, "hold"
			end
		elseif self:IsWithinCastRangeOfAnySkill(focus) then
			self:MoveLog(entity, "停步: 目标%s已在任一技能射程内 self=%s target=%s",
				formatUnit(focus), formatGrid(gx, gy), formatGrid(self.ctx:GetGridPos(focus)))
			return gx, gy, "hold"
		end
		local standGx, standGy = self:FindBestCastStandGrid(entity, gx, gy, focus, castRange > 0 and castRange or nil)
		if standGx ~= nil and standGy ~= nil then
			if standGx ~= gx or standGy ~= gy then
				self:MoveLog(entity, "追击: focus=%s skill=%s self=%s stand=%s",
					formatUnit(focus), formatSkill(castSkillId or 0), formatGrid(gx, gy), formatGrid(standGx, standGy))
				return standGx, standGy, "chase"
			end
			self:MoveLog(entity, "停步: 已在最佳站位 self=%s focus=%s", formatGrid(gx, gy), formatUnit(focus))
			return gx, gy, "hold"
		end
		self:MoveLog(entity, "未找到站位: focus=%s skill=%s self=%s, 改朝敌人推进",
			formatUnit(focus), formatSkill(castSkillId or 0), formatGrid(gx, gy))
	end
	local tx, ty = self:GetMarchTowardFocusGrid(entity, gx, gy, focus)
	self:MoveLog(entity, "朝敌方阵营推进: self=%s target=%s deploy=%s focus=%s",
		formatGrid(gx, gy), formatGrid(tx, ty), formatGrid(self:GetMarchDestinationGrid(entity, gx, gy)), formatUnit(focus))
	return tx, ty, "march"
end

---是否需要向目标靠近才能施法
---@param target AutoChessEntity
---@param skillId integer?
---@return boolean
function AIBase:NeedMoveCloser(target, skillId)
	if skillId ~= nil and skillId ~= 0 then
		return not self:IsWithinCastRangeOfSkill(target, skillId)
	end
	return not self:IsWithinCastRangeOfAnySkill(target)
end

---向 GetMoveTargetGrid 目标移动一格（技能追击或行军入口）
---@param skillId integer
---@param focusUnit AutoChessEntity?
---@return boolean moved
function AIBase:MoveOneGridStep(skillId, focusUnit)
	if self.ctx:IsMoving() or not self.ctx:CanMove() then
		local entity = self.ctx:GetEntity()
		self:MoveLog(entity, "停步: moving=%s canMove=%s", tostring(self.ctx:IsMoving()), tostring(self.ctx:CanMove()))
		return false
	end
	local entity = self.ctx:GetEntity()
	if self.ctx:GetMap() == nil then
		self:MoveLog(entity, "停步: map=nil")
		return false
	end
	local gx, gy = self.ctx:GetGridPos(entity)
	local marchGx, marchGy, reason = self:GetMoveTargetGrid(entity, gx, gy, focusUnit, skillId)
	if reason == "hold" or (gx == marchGx and gy == marchGy) then
		self:MoveLog(entity, "不移动: reason=%s self=%s target=%s focus=%s skill=%s",
			tostring(reason), formatGrid(gx, gy), formatGrid(marchGx, marchGy),
			formatUnit(focusUnit), formatSkill(skillId or 0))
		self:SetDecisionCooldown(0.35)
		return false
	end
	self:MoveLog(entity, "准备移动: reason=%s self=%s target=%s focus=%s skill=%s",
		tostring(reason), formatGrid(gx, gy), formatGrid(marchGx, marchGy),
		formatUnit(focusUnit), formatSkill(skillId or 0))
	local moved = self:MoveOneStepToGrid(marchGx, marchGy, skillId, focusUnit)
	if moved then
		self.ctx:SetCache(AIConst.CACHE_DECISION_COOLDOWN, nil)
	else
		self:SetDecisionCooldown(0.35)
	end
	return moved
end

---向指定行军/站位格移动一格（ResolveNextMoveStep 选步 + MoveToGrid）
---@param marchGx integer
---@param marchGy integer
---@param skillId integer?
---@param focusUnit AutoChessEntity?
---@return boolean moved
function AIBase:MoveOneStepToGrid(marchGx, marchGy, skillId, focusUnit)
	if self.ctx:IsMoving() or not self.ctx:CanMove() then
		local entity = self.ctx:GetEntity()
		self:MoveLog(entity, "停步: MoveOneStep 前置失败 moving=%s canMove=%s", tostring(self.ctx:IsMoving()), tostring(self.ctx:CanMove()))
		return false
	end
	local entity = self.ctx:GetEntity()
	local gx, gy = self.ctx:GetGridPos(entity)
	local curPos = entity:GetPosition()
	local map = self.ctx:GetMap()
	if gx == marchGx and gy == marchGy then
		self:MoveLog(entity, "停步: 已在目标格 %s", formatGrid(gx, gy))
		return false
	end
	local stepGx, stepGy, reason = self:ResolveNextMoveStep(entity, gx, gy, marchGx, marchGy, skillId, focusUnit)
	if stepGx == nil or stepGy == nil or (stepGx == gx and stepGy == gy) then
		self:MoveLog(entity, "停步: 无路可走 reason=%s self=%s target=%s", tostring(reason), formatGrid(gx, gy), formatGrid(marchGx, marchGy))
		return false
	end
	self:ClearMovementSealed()
	self:MoveLog(entity, "发起移动(%s): %s -> %s", tostring(reason), formatGrid(gx, gy), formatGrid(stepGx, stepGy))
	self.ctx:SetCache(AIConst.CACHE_LAST_GRID_X, gx)
	self.ctx:SetCache(AIConst.CACHE_LAST_GRID_Y, gy)
	local wx, wz = map:GridToWorldPos(stepGx, stepGy)
	self.ctx:MoveToGrid(Vector3.New(wx, curPos.y, wz), nil, stepGx, stepGy)
	return true
end

---决策前对齐格心，完成后回调 onReady（通常进入 OnGridReady）
---@param onReady fun(entity: AutoChessEntity)?
function AIBase:EnsureGridCenter(onReady)
	local entity = self.ctx:GetEntity()
	if self.ctx:IsOnGridCenter(entity) then
		if onReady then
			onReady(entity)
		end
		return
	end
	if self.ctx:IsMoving() then
		return
	end
	if self.ctx:GetCache(AIConst.CACHE_GRID_ALIGNING) ~= nil then
		return
	end
	self.ctx:SetCache(AIConst.CACHE_GRID_ALIGNING, 1)
	self.ctx:AlignToGridCenter(function(e)
		self.ctx:SetCache(AIConst.CACHE_GRID_ALIGNING, nil)
		self.ctx:ResolveGridOverlap(e)
		if onReady then
			onReady(e)
		end
	end)
end

---决策冷却：停步/无路时短暂避免同一帧重复决策
---@param seconds number
function AIBase:SetDecisionCooldown(seconds)
	if Time ~= nil and Time.time ~= nil then
		self.ctx:SetCache(AIConst.CACHE_DECISION_COOLDOWN, Time.time + seconds)
	end
end

---是否处于决策冷却中
---@return boolean
function AIBase:IsDecisionOnCooldown()
	if Time == nil or Time.time == nil then
		return false
	end
	local untilTime = self.ctx:GetCache(AIConst.CACHE_DECISION_COOLDOWN)
	return untilTime ~= nil and Time.time < untilTime
end

---格心就绪后的主决策入口：cast → move → march；真堵死时待机施法
---@param entity AutoChessEntity
function AIBase:OnGridReady(entity)
	if self.ctx:IsDead(entity) or self.ctx:IsCasting() then
		self:MoveLog(entity, "跳过决策: dead=%s casting=%s", tostring(self.ctx:IsDead(entity)), tostring(self.ctx:IsCasting()))
		return
	end
	if self:IsDecisionOnCooldown() then
		return
	end
	local action, skillId, target = self:DecideAction()
	local gx, gy = self.ctx:GetGridPos(entity)
	self:MoveLog(entity, "决策: pos=%s action=%s skill=%s target=%s",
		formatGrid(gx, gy), tostring(action), formatSkill(skillId or 0), formatUnit(target))
	if target ~= nil then
		self.ctx:SetCache(AIConst.CACHE_LOCKED_TARGET, self.ctx:GetUID(target))
	else
		self.ctx:SetCache(AIConst.CACHE_LOCKED_TARGET, nil)
	end
	if action == "cast" then
		self:ClearMovementSealed()
		self:TryCastSkill(skillId, target)
		return
	end
	if action == "move" and target ~= nil then
		self:ClearMovementSealed()
		self:MoveOneGridStep(skillId, target)
		return
	end
	local marchGx, marchGy, reason = self:GetMoveTargetGrid(entity, gx, gy, target, 0)
	if reason == "hold" or (gx == marchGx and gy == marchGy) then
		self:MoveLog(entity, "不移动: reason=%s", tostring(reason))
		return
	end
	if self:IsMovementSealed(entity, gx, gy, marchGx, marchGy, 0, target) then
		self:MoveLog(entity, "真堵死待机: pos=%s", formatGrid(gx, gy))
		local castAction, castSkill, castTarget = self:DecideCastOnly()
		if castAction == "cast" then
			self:MoveLog(entity, "待机中施法: skill=%s target=%s", formatSkill(castSkill), formatUnit(castTarget))
			self:TryCastSkill(castSkill, castTarget)
		end
		self:SetDecisionCooldown(0.35)
		return
	end
	self:ClearMovementSealed()
	self:MoveOneGridStep(0, target)
end

---每帧驱动：非移动/非施法且对齐格心后触发 OnGridReady
---@param dt number
function AIBase:Update(dt)
	if not self.ctx:IsActive() then
		return
	end
	local entity = self.ctx:GetEntity()
	if self.ctx:IsDead(entity) then
		return
	end
	if self.ctx:IsCasting() or self.ctx:IsMoving() then
		return
	end
	self:EnsureGridCenter(function(e)
		self:OnGridReady(e)
	end)
end

return AIBase
