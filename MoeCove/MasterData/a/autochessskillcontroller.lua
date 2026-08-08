local AutoChessSkill = require("AutoChessSkill")
local acMgr = AutoChessManager.instance()

---@class AutoChessSkillController
local AutoChessSkillController = class("AutoChessSkillController")

---@param owner AutoChessEntity
function AutoChessSkillController:ctor(owner)
	self.owner = owner

	---@type AutoChessSkill? 当前释放技能 
	self.castingSkill = nil

	---@type table<integer, number> 技能cd列表
	self.cdMap = {}

	---@type table<int, AutoChessSkill>
	self.skillDict = {}

	---@type int[] 技能优先级顺序
	self.skillPriority = {}
end

---初始化技能列表
---添加技能组
---@param skillIds int[]
function AutoChessSkillController:AddSkills(skillIds)
	for i = 1, #skillIds do
		local skillId = skillIds[i]
		self:AddSkill(skillId)
	end
end


---添加技能
---@param skillId int
function AutoChessSkillController:AddSkill(skillId)
	if self.skillDict[skillId] ~= nil then
		LuaLogger.es("当前技能已经添加 id:" .. skillId)
		return
	end
	local skill = AutoChessSkill:new(self.owner, skillId)
	self.skillDict[skillId] = skill

	self:RefreshSkillPriority()
end

---移除技能
---@param skillId int
function AutoChessSkillController:RemoveSkill(skillId)
	if self.skillDict[skillId] == nil then
		return
	end
	local skill = self.skillDict[skillId]
	if self.castingSkill == skill then
		skill:Break()
		self.castingSkill = nil
	end
	skill:ClearCache()
	self.skillDict[skillId] = nil

	self:RefreshSkillPriority()
end


---刷新技能优先级
function AutoChessSkillController:RefreshSkillPriority()
    local count = 0
    for id, _ in pairs(self.skillDict) do
        count = count + 1
        self.skillPriority[count] = id
    end

    for i = count + 1, #self.skillPriority do
        self.skillPriority[i] = nil
    end

    local dict = self.skillDict
    table.sort(self.skillPriority, function(idA, idB)
        local cfgA = dict[idA].skillCfg
        local cfgB = dict[idB].skillCfg
		local a_lv = cfgA.releasePriorityLv
		local b_lv = cfgB.releasePriorityLv
        return a_lv > b_lv
    end)
end




---@param dt number
function AutoChessSkillController:Update(dt)

	for skillId, cd in pairs(self.cdMap) do
		local c = cd - dt
		c = math.max(c, 0)
		self.cdMap[skillId] = c
	end

	if self.castingSkill then
		self.castingSkill:Update(dt)
		if self.castingSkill.isComplete then
			self.castingSkill = nil
		end
	end
end

---判断当前技能是否可以释放 不会判断距离
---@param skillId integer
---@return boolean canUse 是否可以释放
function AutoChessSkillController:CanCast(skillId)

	local cd = self.cdMap[skillId]
	if cd ~= nil and cd > 0 then
		return false
	end

	if self.castingSkill ~= nil then
		return false
	end

	local skillCfg = Config.GetAutoChessSkillTable(skillId)
	if skillCfg == nil then
		return false
	end

	---禁魔
	if self.owner:HasFlag(GE.AutoChessFlag.eStatus_Silence) then
		return false
	end

	--不能攻击
	if self.owner:HasFlag(GE.AutoChessFlag.eStatus_NoAttack) then
		return false
	end
	---判断消耗
	return true
end

---目标是否在技能施法距离内（不含 CD、施法中判断）
---@param skillId integer
---@param targetId integer
---@return boolean
function AutoChessSkillController:CanCastOnTarget(skillId, targetId)
	local skillCfg = Config.GetAutoChessSkillTable(skillId)
	if skillCfg == nil then
		return false
	end
	local targetEntity = acMgr:GetEntity(targetId)
	if targetEntity == nil or targetEntity.isDead or targetEntity.destroyed then
		return false
	end
	local dis = acMgr:GetEnitytDistance(self.owner:GetUID(), targetId)
	if dis == -1 or dis > skillCfg.attackRange then
		return false
	end
	if skillCfg.minAttackRange ~= 0 and dis < skillCfg.minAttackRange then
		return false
	end
	return true
end

---按优先级选取对目标可施放的最高优先级技能
---@param targetId integer
---@return integer skillId
function AutoChessSkillController:GetBestSkillIdForTarget(targetId)
	if self.skillPriority == nil then
		return 0
	end
	for i = 1, #self.skillPriority do
		local id = self.skillPriority[i]
		if not self:CanCast(id) or not self:CanCastOnTarget(id, targetId) then
			goto continue
		end
		local skillCfg = Config.GetAutoChessSkillTable(id)
		local targetEntity = acMgr:GetEntity(targetId)
		if skillCfg ~= nil and targetEntity ~= nil
			and acMgr:CheckSearchFilter(self.owner, targetEntity, skillCfg.targetMask) then
			return id
		end
		::continue::
	end
	return 0
end


function AutoChessSkillController:CanAttackTarget(skillId, targetId)
	local skillCfg = Config.GetAutoChessSkillTable(skillId)
	if skillCfg == nil then
		return false
	end
	local entity = acMgr:GetEntity(targetId)
	if entity == nil then
		return false
	end
end


---释放技能
---@param skillId integer 技能id
---@param targetId integer 目标id
---@param releastPos Vector3 释放位置
---@return boolean success 是否释放成功
function AutoChessSkillController:CastSkill(skillId, targetId, releastPos)
	if not self:CanCast(skillId) then
		return false
	end
	local skillCfg = Config.GetAutoChessSkillTable(skillId)
	if skillCfg == nil then
		return false
	end

	if self.castingSkill ~= nil then
		return false
	end

	local targetEntity = acMgr:GetEntity(targetId)
	if targetEntity == nil or targetEntity.isDead or targetEntity.destroyed then
		return false
	end

	---//判断距离
	local dis = acMgr:GetEnitytDistance(self.owner:GetUID(), targetId)
	if dis == -1 then
		return false
	end
	if dis > skillCfg.attackRange then
		return false
	end
	if skillCfg.minAttackRange ~= 0 and dis < skillCfg.minAttackRange then
		return false
	end

	local skill = self.skillDict[skillId]
	if skill == nil then
		return false
	end
	local filter = acMgr:CheckSearchFilter(self.owner, targetEntity, skillCfg.targetMask)
	if not filter then
		return false
	end
	skill:Start(targetId, releastPos)
	self.castingSkill = skill
	self.cdMap[skillId] = skillCfg.cd
	return true
end

---获取技能cd
---@param skillId integer
---@return number
function AutoChessSkillController:GetSkillCd(skillId)
	if self.cdMap[skillId] == nil then
		return 0
	end
	return self.cdMap[skillId]
end

---设置技能cd
---@param skillId integer
---@param cd number
function AutoChessSkillController:SetSkillCd(skillId, cd)
	if self.cdMap[skillId] == nil then
		return
	end
	self.cdMap[skillId] = cd
end


---打断技能
function AutoChessSkillController:BreakSkill()
	if self.castingSkill == nil then
		return
	end
	self.castingSkill:Break()
	self.castingSkill = nil
end

---获得下一个优先使用的技能id
---@return integer skillId 技能id
function AutoChessSkillController:GetBestSkillId()
	if self.skillPriority == nil then
		return 0
	end
	for i = 1, #self.skillPriority do
		local id = self.skillPriority[i]
		if self:CanCast(id) then
			return id
		end
	end
	return 0
end

---在技能攻击距离内查找目标（复用 filterSort 规则，AI 索敌用）
---@param skillId integer
---@return AutoChessEntity?
function AutoChessSkillController:SearchAttackTarget(skillId)
	if skillId == nil or skillId == 0 then
		return nil
	end
	local target = self:GetSkillAttackTarget(skillId)
	if target ~= nil then
		return target
	end
	local cfg = Config.GetAutoChessSkillTable(skillId)
	if cfg == nil then
		return nil
	end
	if acMgr:HasFlag(cfg.targetMask, GE.AutoChessSearchType.Enemy) then
		return acMgr:FindEnemyInSkillRange(self.owner, cfg)
	end
	return nil
end

---按技能表 targetMask / filterSort 选取目标（不限敌友）
---@param skillId integer
---@return AutoChessEntity?
function AutoChessSkillController:GetSkillTarget(skillId)
	return self:GetSkillAttackTarget(skillId)
end

---获取技能攻击目标
---@param skillId integer 技能ID
---@return AutoChessEntity?
function AutoChessSkillController:GetSkillAttackTarget(skillId)
	if skillId == 0 then
		return nil
	end
	if self.skillDict[skillId] == nil then
		return nil
	end
	local cfg = Config.GetAutoChessSkillTable(skillId)
	if cfg == nil then
		return
	end
	local r = cfg.attackRange
	local searchMask = cfg.targetMask
	---筛选（表内 filterSort 可能是嵌套表，也可能是未展开的预设 id 数字）
	---@type int[][]|integer
	local filterSort = cfg.filterSort
	if type(filterSort) ~= "table" or tablex.empty(filterSort) then
		local entity = acMgr:GetNearestEntityInRange(self.owner:GetPosition(), r, self.owner, searchMask, nil)
		return entity
	end
	local selectEntities = acMgr:GetEntitiesInRange(self.owner:GetPosition(), r, self.owner, searchMask, nil)

	table.sort(selectEntities, function(a, b)
		if filterSort ~= nil then
			for i = 1, #filterSort do
				local p = filterSort[i]
				if p == nil then
					goto continue
				end
				local v = 0
				if p[1] == GE.AutoChessFilterSortType.Profession then
					v = self:FilterSortType_Profession(a, b, p[2])
				elseif p[1] == GE.AutoChessFilterSortType.Hp then
					v = self:FilterSortType_Hp(a, b, p[2])
				end
				if v ~= 0 then
					return v > 0
				end
				::continue::
			end
		end
		---默认距离排序
		local aDis = acMgr:GetEnitytDistance(self.owner:GetUID(), a:GetUID())
		local bDis = acMgr:GetEnitytDistance(self.owner:GetUID(), b:GetUID())
		return aDis < bDis
	end)
	return selectEntities[1]
end


---舰种排序
---@param a AutoChessEntity
---@param b AutoChessEntity
---@param p int[] 舰种优先级
---@return int
function AutoChessSkillController:FilterSortType_Profession(a, b, p)
	local aid = a:GetID()
	local bid = b:GetID()
	local acfg = Config.GetAutoChessHeroTable(aid)
	local bcfg = Config.GetAutoChessHeroTable(bid)
	local av = tablex.indexof(p, acfg.restraintType)
	if av == -1 then
		av = #p + 1
	end
	local bv = tablex.indexof(p, bcfg.restraintType)
	if bv == -1 then
		bv = #p + 1
	end
	return bv - av
end


---@param a AutoChessEntity
---@param b AutoChessEntity
---@param p int[] index1表示 hp排序方法,  index2表示升序(1)还是降序(2)
---@return int
function AutoChessSkillController:FilterSortType_Hp(a, b, p)
	local av = a:GetHp()
	local bv = b:GetHp()
	local sortType = p[1]		--1 hp绝对值 2hp 百分比
	local isAscending = p[2]	---1升序 2降序

	if sortType == 2 then
		av = av / a:GetHpMax()
		bv = bv / b:GetHpMax()
	end
	
	if isAscending == 1 then
		return bv - av
	else
		return av - bv
	end
	return 0
end




return AutoChessSkillController
