-- OPENDEBUG()
local unpack = unpack or table.unpack
---------------------------------
-- 玩家技能管理器
SkillMgr = oo.class()
-- row ==> x  col ==> y
function SkillMgr:Init(card, list, aiSetting)

	self.card				= card
	self.team				= card.team
	self.list				= list
	self.arrDeathEvent		= {} -- 死亡事件

	self:InitSkill()
	LogTable(aiSetting, "aiSetting=")
	-- LogTable(list)
	self.aiSetting = aiSetting
	self:SetAI()
	-- ASSERT()
end

function SkillMgr:Destroy()
	LogDebugEx("SkillMgr:Destroy()")
    for k,v in pairs(self.skills) do
    	v:Destroy()
    end

    for k,v in pairs(self) do
        self[k] = nil
    end
end

-- 初始化技能
function SkillMgr:InitSkill()
	
	-- 保存原来的技能
	local srcSkills = {}
	for i,v in ipairs(self.skills or {}) do
		srcSkills[v.id] = v 
	end

	self.skills           = {} -- 所有技能(list)
	self.mapSkills        = {} -- 所有技能(map)按Group
	self.mapSlotSkills    = {} -- 主动技能按123
	self.initiativeSkills = {} -- 主动技能
	self.passiveSkills    = {} -- 被动技能
	self.equipSkills      = {} -- 装备技能
	self.oNormonSkill     = nil -- 普攻技能
	self.oOverloadSkill   = nil -- overload技能
	self.attrSkill = {} -- 属性技能(后端没用,前端显示用)

	for i,v in ipairs(self.list) do
		-- local config = skill[v]
		-- if config then
			local oSkill = srcSkills[v] or self:CreateSkill(v)
			if srcSkills[v] then -- 重新注册技能事件
				srcSkills[v]:RegisterEvent(self)
			end
			if oSkill.type ~= SkillType.Passive and oSkill.type ~= SkillType.Equip then
				self.initiativeSkills[v] = oSkill
				if oSkill.upgrade_type then
					self.mapSlotSkills[oSkill.upgrade_type] = oSkill
				end
				if oSkill.type == SkillType.Normon then
					-- 普攻
					self.oNormonSkill = oSkill
				elseif oSkill.upgrade_type == CardSkillUpType.OverLoad then
					self.oOverloadSkill = oSkill
				end
			else
				if oSkill.main_type == SkillMainType.Equip then
					table.insert(self.equipSkills, v)
				end
				table.insert(self.passiveSkills, oSkill)
			end
			table.insert(self.skills, oSkill)
			self.mapSkills[oSkill.skillGroup] = oSkill
		-- else
		-- 	table.insert(self.attrSkill, v)
		-- end
	end

	-- if self.card.bIsCommander then return end
	-- LogTable(srcSkills, "srcSkills:")
	ASSERT(self.oNormonSkill, self.card.name.."->没有设置普攻技能")
end

-- 设置ai策略
function SkillMgr:SetAI()
	local aiSetting = self.aiSetting
	if aiSetting then
		for i,v in ipairs(aiSetting) do
			-- {skillStrategy = skillStrategy, aiStrategy = aiStrategy, skillID = skillID}
			-- LogDebugEx("skill ", v.skillID)
			local oSkill = self:GetSkill(v.skillID)
			if oSkill then
				oSkill:AlterStrategy(v)
			end
		end

		self.bOverLoad = aiSetting.bOverLoad
		-- ASSERT()
	end
end

-- 获取可用技能
function SkillMgr:GetUseful()

	local list = {}
	for i,v in ipairs(self.skills) do
		local p = v:CanUse()
		if --[[v.isInitiative and]] p and p > 0 then
			table.insert(list, v)
		end
	end

	return list
end

-- 镜像技能
function SkillMgr:AddMirrorSkill(skillID)
	
	local oSkill = self:CreateSkill(skillID)
	self.oMirrorSkill = oSkill

	oSkill.fOnActionOver = oSkill.OnActionOver
	-- 重载技能回合结束 (或者加buff删掉)
	function oSkill:OnActionOver(caster, target, data)
		if not SkillJudger:IsCurrSkill(self, caster, target, res) then
			return
		end
		if self.fOnActionOver then
			self:fOnActionOver(caster, target, data)
		end
		self:DelMirrorSkill()
	end

	-- 重新注册技能事件(回合开始的时候注册事件)
	oSkill:RegisterEvent(self)

	self.initiativeSkills[skillID] = oSkill
	table.insert(self.skills, oSkill)
end

function SkillMgr:DelMirrorSkill()
	if not self.oMirrorSkill then return end
	local skillID = self.oMirrorSkill.id
	-- 重新注册技能事件
	self.oMirrorSkill:DeleteEvent()
	self.initiativeSkills[skillID] = nil
	for i,v in ipairs(self.skills) do
		if v == self.oMirrorSkill then 
			table.remove(self.skills, i)
			break
		end
	end

	self.oMirrorSkill = nil
	self.card.nMirrorSkillID = nil
	self.fOnActionOver = nil

	local log ={api="DelMirrorSkill", id = self.card.oid, nMirrorSkillID = skillID}
	
	self.log:Add(log)
end

-- CoolDown
function SkillMgr:CoolDown()

	local list = {}
	for i,v in ipairs(self.skills) do
		v:CoolDown()
	end

	return list
end

-- 获取客户端显示数据
function SkillMgr:GetClientSkillInfo()

	local list = {}
	if self.oMirrorSkill then --镜像技能
		list[self.oMirrorSkill.id] = {usable = 1,}
		return list
	end

	for i,v in ipairs(self.skills) do
		LogDebugEx("GetClientSkillInfo"..self.card.name..v.id..v.name)
		local can = v:CanUse()
		-- if v.isInitiative then

			if not can then
				local data = {
					usable = 0,
				}
				if v.curr_cd > 0 then data.cd = v.curr_cd end
				list[v.id] = data
			elseif can and can < 0 then
				list[v.id] = {
					usable = can,
				}
				if v.curr_cd and v.curr_cd > 0 then list[v.id].cd = v.curr_cd end
				-- list[v.id].usable = 0
			else
				list[v.id] = {
					usable = 1,
				}
			end
		-- end
	end

	return list
end

-- 判断是否能够释放OverLoad
-- -1 禁止使用, 1可以使用, 0 不可以使用

-- -2 cd中
-- -3 不可召唤
-- -4 没有可触发对象
-- -5 xp不足
-- -6 np不足
-- -7 sp不足

function SkillMgr:CanOverLoad(data)

	if not self.card.overLoad then return 0 end
	if not self.oOverloadSkill then return 0 end
	if self.card.silence then return -1 end	-- 沉默

	local np = self.oOverloadSkill.np or 20

	local mgr = self.team.fightMgr
	local teamID = self.card:GetTeamID()

	if not self.card:CheckSP(g_overLoadCheck) then
		LogDebugEx("SP不足", self.card.sp, g_overLoadCheck)
		return -7
	end

	if not mgr:CheckNP(teamID, np) then
		LogDebugEx("NP不足", np)
		return -6
	end

	return 1
end

function SkillMgr:AICanOverLoad(data)

	LogDebugEx("SkillMgr:AICanOverLoad(data)", self.id)
	if not self.card.overLoad then return 0 end
	if not self.oOverloadSkill then return 0 end
	if self.card.silence then return 0 end	-- 沉默

	local mgr = self.team.fightMgr
	if mgr:IsReserveSP() then return 0 end -- 保留sp

	local np = self.oOverloadSkill.np or 20
	np = np + mgr:ReserveNP() -- 预留np

	local teamID = self.card:GetTeamID()

	if not mgr:CheckNP(teamID, np) then
		LogDebugEx("NP不足", np)
		return 0
	end

	if not self.card:CheckSP(g_overLoadCheck) then
		LogDebugEx("SP不足", self.card.sp, g_overLoadCheck)
		return 0
	end

	--复活,判断有没有复活
	if self.oOverloadSkill.type == SkillType.Revive then
		-- 复活技能
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		local team = mgr:GetTeam(teamID)
		local tar = team.filter:GetDead()
		if #tar < 1 then
			LogDebugEx("AICanUse: Revive not target", self.id) 
			return 0
		end		
	end

	return 1
end
-- 
function SkillMgr:CanAttack(caster, target, skillID)
	-- local skillMgr = caster.skillMgr
	local skill = self:GetSkill(skillID)
	if not skill or not skill:CanUse() or skill:CanUse() < 0 then
		--LogTrace()
		return
	end
	if skill.type == SkillType.Unite then
		local arrUnite = caster.mapUnite or {}
		--LogTable(arrUnite, "arrUnite = ")
		--LogTable(caster.unite)
		for i, v in ipairs(target) do
			if not arrUnite[v.id] then
				LogDebugEx("不能合体", caster.name, caster.id, v.name, v.id)
				return
			end
		end
	end
	skill:Cost()

	return true
end

-- 创建临时技能(callskill/AutoFight没有技能就调用技能)
function SkillMgr:CreateSkillEx(skillID)
	LogDebugEx("AutoFight.nAutoSkillID", skillID)
	-- local skillMgr = mgr.currTurn.skillMgr
	local skl = self:GetSkill(skillID)
	if not skl then
		skl = self:CreateSkill(skillID)
		--LogDebugEx("CreateSkillEx", skillID, skl.skillGroup)
		table.insert(self.skills, skl)
		self.initiativeSkills[skillID] = skl
		self.mapSkills[skl.skillGroup] = skl
	end
	return skl
end


-- 删除技能
function SkillMgr:DelSkillEx(skillID)
	LogDebugEx("SkillMgr.DelSkillEx", skillID)
	local oSkill = self:GetSkill(skillID)

	if not oSkill then return end
	if not oSkill.bIsCanDel then return end -- 不可删除的技能

	-- LogDebugEx("SkillMgr:DelSkill", caster.name, target.name, skillID)
	oSkill:DeleteEvent() -- 删除事件

	-- if self.mapSkills[oSkill.skillGroup] == oSkill then 
		self.mapSkills[oSkill.skillGroup] = nil
	-- end
	self.initiativeSkills[skillID] = nil
	for i,v in ipairs(self.skills) do
		if v == oSkill then 
			table.remove(self.skills, i)
			break
		end
	end
end

-- 获取可用技能(AI使用) 
function SkillMgr:GetNext()

	-- LogTrace()
	LogDebugEx("SkillMgr:GetNext",self.card.name ,self.card.silence , self.bOverLoad, self.card.nAutoSkillID)
	if self.card.silence then
		-- 沉默/AI只用普攻
		-- ASSERT(nil,"没有可用的技能")
		if self.card.bAIOnTurn then-- bIgnoreUseCommon忽略只用普攻设置
		else
			return self.oNormonSkill
		end
	end	

	-- 指定要放的技能
	if self.card.nAutoSkillID then
		local oSkill = self:GetSkillByID(self.card.nAutoSkillID)
		--LogDebugEx("nAutoSkillID", self.card.nAutoSkillID)
		self.card.nAutoSkillID = nil
		LogDebugEx("isUseCommon====", oSkill and "1" or "0", oSkill and (oSkill:AICanUse() and "CanUse" or "CanUse false") or "not skill" )
		if oSkill and oSkill:AICanUse() then
			return oSkill
		end
	end

	-- -- 自动战斗时的技能选择
	-- if self.card.isUseCommon then
	-- 	local oSkill = self.mapSlotSkills[self.card.isUseCommon] --self:GetSkill(self.card.isUseCommon)
	-- 	-- LogDebugEx("isUseCommon====", oSkill and "1" or "0", oSkill and (oSkill:CanUse() and "CanUse" or "CanUse false") or "not skill" )
	-- 	if oSkill and oSkill:CanUse() then
	-- 		return oSkill
	-- 	else--if self.card.isUseCommon == 2 then -- 第二技能不满足条件就用普攻
	-- 		return self.oNormonSkill
	-- 	end
	-- end

	-- local arrExType = {} -- (np sp 保留时)需要排除的类型
	-- arrExType[SkillType.Passive] = true
	-- arrExType[SkillType.Equip] = true
	-- arrExType[SkillType.OverLoad] = true
	-- arrExType[SkillType.Summon] = true
	-- arrExType[SkillType.Unite] = true
	-- arrExType[SkillType.Transform] = true

	-- boss出现前(副本中的boss还是战斗中的boss??)


	-- 自动战斗允许使用Overload技能
	if self.bOverLoad and self.oOverloadSkill then 
		local p =self:AICanOverLoad()
		-- local p = self.oOverloadSkill:CanUse()
		if p and p > 0 then -- 能放
			if self.oOverloadSkill.range_key == "one_except_self" then -- 用于队友的技能需要判断队友是否存在
				local arr = self.card.team.filter:GetAll(self.card)
				-- local arr = target.team.arrCard
				local count = #arr
				if count > 0 then 
					return self.oOverloadSkill
				end
			else
				return self.oOverloadSkill
			end
		end
	end

	local skill = self.oNormonSkill
	local priority = -1
	for i,v in ipairs(self.skills) do
		if v.type ~= SkillType.Passive and v.type ~= SkillType.Equip and v.upgrade_type ~= CardSkillUpType.OverLoad then
			local p = v:AICanUse()
			LogDebugEx("GetNext", priority, v.id, v:GetPriority())
			if p and p > priority then
				priority = p
				skill = v
			end
		end
	end

	LogDebugEx("SkillMgr:GetNext 222",self.card.name, skill.id)
	
	return skill
end

-- 获取普通技能
function SkillMgr:GetNormon()

	for i,v in ipairs(self.skills) do
		if v.type == SkillType.Normon then
			return v
		end
	end
	ASSERT(nil,"没有可用的技能")
	return 
end

-- 主动技能
function SkillMgr:GetSkill(skillID)
	-- LogDebugEx("SkillMgr:GetSkill(skillID)",skillID, self.card.name)
	return self.initiativeSkills[skillID]
end

-- 获取技能
function SkillMgr:GetSkillByID(skillID)
	return self.mapSkills[skillID]
end

-- 被动技能
function SkillMgr:GetPassiveSkills()
	if #self.passiveSkills > 0 then return self.passiveSkills end
end

function SkillMgr:CreateSkill(skillID)

	-- LogDebugEx("CreateSkill", skillID)
	local s = self:CreateTempSkill(skillID)

	-- print("old = ", s)
	-- s = table.CreateDebug(s)
	-- print("new = ", s)
	-- table.Debug(s, "order")

	-- s.card = self.card
	-- s.team = self.team
	-- s.fightMgr = self.team.fightMgr
	-- s.log = self.team.fightMgr.log
	s:RegisterEvent(self)
	return s
end

g_mapSkillLoaded = {}
function SkillMgr:CreateTempSkill(skillID)

	LogDebugEx("CreateSkill", skillID)
	local skill = g_mapSkillLoaded["Skill"..skillID]
	if not skill then
		if g_SkillList["Skill"..skillID] then
			--LogDebugEx(g_SkillPath.."Skill"..skillID)
			require(g_SkillPath.."Skill"..skillID)
			skill = _G["Skill"..skillID]
			g_mapSkillLoaded["Skill"..skillID] = _G["Skill"..skillID]
			_G["Skill"..skillID] = nil
			package.loaded[g_SkillPath.."Skill"..skillID] = nil
		else
			skill = SkillBase
		end
	end

	local s = skill(skillID, self.card)
	return s
end

function SkillMgr:DeleteEvent()
	for i,v in ipairs(self.skills) do
		v:DeleteEvent()
	end
end

-- 重新注册技能
function SkillMgr:ReviveRegisterEvent()

	self.arrDeathEvent = {}
	-- self.arrDeathEvent2 = {}
	for i,v in ipairs(self.skills) do
		v:RegisterEvent(self)
	end
end


function SkillMgr:BufferDeleteEvent()
	for i,v in ipairs(self.skills) do
		if v.main_type == SkillMainType.CardTalent or 
			v.main_type == SkillMainType.CardSubTalent or 
			v.main_type == SkillMainType.Equip or 
			v.type == SkillType.Passive then 
			LogDebugEx("删除事件", v.name)
			v:DeleteEvent()
		end
	end
end

-- 重新注册技能
function SkillMgr:RegisterEvent()
	if not self.card:IsLive() then return end
	for i,v in ipairs(self.skills) do
		v:RegisterEvent(self)
	end
end

-- 处理死亡事件
function SkillMgr:DoDeathEvent(caster, target)

	-- local target = self.card
	-- local caster = self.card.currKiller
	-- if not caster then return end
	-- ASSERT(caster)

	for i,skill in ipairs(self.arrDeathEvent) do
		-- skill.order = 0
		skill:OnDeath(caster, target)
	end

	-- for i,skill in ipairs(self.arrDeathEvent2) do
	-- 	skill:OnDeath2(caster, target)
	-- end	
end

-- 减少所有技能属性
function SkillMgr:AddSkillAttr(attr, val)
	self.tRestoreLog = self.tRestoreLog or {}
	local log		= self.team.fightMgr.log
	for k,skill in pairs(self.initiativeSkills) do
		skill[attr] = skill[attr] or 0
		skill[attr] = skill[attr] + val
		if val<0 and skill[attr] < 0 then skill[attr] = 0 end

		-- 修改技能属性
		local tlog = {api="UpdateSkill", id = self.card.oid, skillID = skill.id, attr = attr, val = skill[attr]}
		table.insert(self.tRestoreLog, tlog)
		log:Add(tlog)
	end
end


-- 减少所有技能属性(百分比)
function SkillMgr:AddSkillAttrPct(attr, val)
	self.tRestoreLog = self.tRestoreLog or {}
	local log		= self.team.fightMgr.log
	for k,skill in pairs(self.initiativeSkills) do
		skill[attr] = skill[attr] or 0
		skill[attr] = math.ceil(skill[attr] * (1+val))
		if val<0 and skill[attr] < 0 then skill[attr] = 0 end

		-- 修改技能属性
		local tlog = {api="UpdateSkill", id = self.card.oid, skillID = skill.id, attr = attr, val = skill[attr]}
		table.insert(self.tRestoreLog, tlog)
		log:Add(tlog)
	end
end



-- 减少一个技能属性
function SkillMgr:AddOneSkillAttr(attr, val, upgrade_type, limit)
	self.tRestoreLog = self.tRestoreLog or {}
	local log		= self.team.fightMgr.log
	limit = limit or 1

	local oSkill = self.mapSlotSkills[upgrade_type]
	if oSkill then return end
	-- if oSkill.bAddOneSkillAttr or oSkill.bAddOneSkillAttr >= limit then return end

	for k,skill in pairs(self.initiativeSkills) do
		oSkill[attr] = oSkill[attr] or 0
		oSkill[attr] = oSkill[attr] + val
		if val<0 and oSkill[attr] < 0 then oSkill[attr] = 0 end

		-- 修改技能属性
		local tlog = {api="UpdateSkill", id = self.card.oid, skillID = oSkill.id, attr = attr, val = oSkill[attr]}
		table.insert(self.tRestoreLog, tlog)
		log:Add(tlog)
	end
end

function SkillMgr:Restore()
	if not self.tRestoreLog then return end

	local log = self.team.fightMgr.log
	for i,tlog in ipairs(self.tRestoreLog) do
		log:Add(tlog)
	end
end

-- function SkillMgr:AddAttr(attr, val)
-- 	for k,skill in pairs(self.initiativeSkills) do
-- 		skill[attr] = skill[attr] or 0
-- 		skill[attr] = skill[attr] + val
-- 	end
-- end

----------------------------------------------
-- 指挥官技能管理器
CommanderSkillMgr = oo.class(SkillMgr)
function CommanderSkillMgr:Init(card, list)
	SkillMgr.Init(self, card, list)
end

-- 初始化技能
function CommanderSkillMgr:InitSkill()
	self.skills	= {}
	self.mapSkills = {}
	self.initiativeSkills = {}

	for i,v in ipairs(self.list) do
		local skill = self:CreateSkill(v)
		self.initiativeSkills[v] = skill
		table.insert(self.skills, skill)
		self.mapSkills[skill.skillGroup] = skill
	end
end

-- 获取客户端显示数据
function CommanderSkillMgr:GetClientSkillInfo()
	local list = {}
	for i,v in ipairs(self.skills) do
		LogDebugEx("GetClientSkillInfo"..self.card.name..v.id)
		if v.curr_cd > 0 then
			-- cd
			list[v.id] = {
				usable = 0,
				cd = v.curr_cd
			}
			-- 次数
		else
			list[v.id] = {
				usable = 1,
			}
		end

	end

	return list
end

function CommanderSkillMgr:CanAttack(caster, target, skillID)
	local skill = self:GetSkill(skillID)
	if not skill or skill.curr_cd > 0 then
		return
	end
	skill.curr_cd = skill.cd or 0

	return true
end

function CommanderSkillMgr:OnTurn()
	for k,v in pairs(self.initiativeSkills) do
		if v.curr_cd > 0 then
			v.curr_cd = v.curr_cd - 1
		end
	end
end

-- 给所有指挥官技能+-cd
function CommanderSkillMgr:AddCD(n)
	for k,v in pairs(self.initiativeSkills) do
		if v.curr_cd > 0 then
			v.curr_cd = v.curr_cd + n
			if v.curr_cd < 0 then
				v.curr_cd = 0
			end
		end
	end
end

----------------------------------------------
-- 一个参数时为优先级, 多个参数按后面的规则
-- 4.np判断 参数 [4,类型(1np2sp3xp),np,符合条件时优先级,不符合的优先级] 例如np>50时优先级为3否则为0 :[4,1,50,3,0], 下同
-- 5.敌方人数 参数 [5,人数,符合条件时优先级,不符合的优先级]
-- 6.我方人数 参数 [6,人数,符合条件时优先级,不符合的优先级]
-- 7.buff判断 参数 [7,目标类型,type,id,num,符合条件时优先级,不符合的优先级] 其中 目标类型:1我方2敌方3自己;type:1group,2好坏,3id,4type
-- 8.血量比 参数 [8,比例,符合条件时优先级,不符合的优先级]
-- 9.随机优先级 参数 [9,优先级1,优先级2...]
-- 10.循环优先级 参数 [10,优先级1,优先级2...]
-- 11.友方存在低于x血量比    参数 [11,比例,符合条件时优先级,不符合的优先级]
-- 12.横排最大人数大于等于N 参数 [12,人数,符合条件时优先级,不符合的优先级]
-- 13.竖排最大人数大于等于N 参数 [13,人数,符合条件时优先级,不符合的优先级]
-- 14.田字最大人数大于等于N 参数 [14,人数,符合条件时优先级,不符合的优先级]
-- 15.同调判断有没有同调对象 参数 [15,符合条件时优先级,不符合的优先级]


-- AI处理技能优先级策略函数簇
local arrPriorityStrategyFuns = {}

-- np/sp/xp判断
arrPriorityStrategyFuns[4] = function(self)
	local skillStrategy	= self.skillStrategy

	local typ = skillStrategy[2] -- 类型
	local cost = skillStrategy[3]
	local flag = false

	if typ == 1 then --np 
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		flag = mgr:CheckNP(teamID, cost)
	elseif typ == 2 then --sp
		flag = self.card:CheckSP(cost)
	elseif typ == 3 then --xp
		flag = self.card:CheckXP(cost)
	else
		ASSERT()
	end

	if flag then
		return skillStrategy[4]
	else
		return skillStrategy[5]
	end

	return 0
end

-- 敌方人数
arrPriorityStrategyFuns[5] = function(self)
	local skillStrategy	= self.skillStrategy
	LogTable(skillStrategy, "skillStrategy")

	local mgr = self.team.fightMgr
	local team = mgr:GetTeam(mgr:GetEnemyTeamID(self.card))

	if team:LiveCount() > skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end

-- 我方人数
arrPriorityStrategyFuns[6] = function(self)
	local skillStrategy	= self.skillStrategy

	if self.team:LiveCount() > skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end

-- buff判断
arrPriorityStrategyFuns[7] = function(self)
	local skillStrategy	= self.skillStrategy

	-- LogTrace()

	local mgr = self.team.fightMgr
	

	local targertyp	= skillStrategy[2] -- 目标类型
	local typ		= skillStrategy[3] -- buff类型
	local group		= skillStrategy[4] -- buff类型对应的值
	local num		= skillStrategy[5] -- 数量

	local sfun = nil
	local count = 0

	if typ == 1 then
		sfun = "GetBufferCountGroup"
	elseif typ == 2 then
		sfun = "GetBufferCountQuality"
	elseif typ == 3 then
		sfun = "GetBufferCountID"
	elseif typ == 4 then
		sfun = "GetBufferCountType"
	elseif typ == 5 then
		sfun = "GetCount"		
	else
		ASSERT()
	end

	if targertyp == 1 then
		-- 我方
		local team = self.team
		for k,v in ipairs(team.arrCard) do
			if v:IsLive() then
				count = count + v.bufferMgr[sfun](v.bufferMgr, group)
			end
		end
	elseif targertyp == 2 then
		-- 敌方
		local team = mgr:GetTeam(mgr:GetEnemyTeamID(self.card))
		for k,v in ipairs(team.arrCard) do
			if v:IsLive() then
				count = count + v.bufferMgr[sfun](v.bufferMgr, group)
			end
		end
	elseif targertyp == 3 then
		-- 自己
		local bufferMgr = self.card.bufferMgr
		count = bufferMgr[sfun](bufferMgr, group)
	end

	LogDebugEx("count > num", count , num)

	if count > num then
		return skillStrategy[6]
	else
		return skillStrategy[7]
	end

	return 0
end

-- 自己血量比
arrPriorityStrategyFuns[8] = function(self)
	local skillStrategy	= self.skillStrategy

	local myPercent = self.card.hp/self.card:Get("maxhp")

	if myPercent > skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end

-- 随机
arrPriorityStrategyFuns[9] = function(self)
	local skillStrategy	= self.skillStrategy
	local index = math.random(#self.skillStrategy-1)   -- 用于AI必须用系统的随机
	--self.card:Rand(#self.skillStrategy-1)

	if skillStrategy[index+1] then
		return skillStrategy[index+1]
	end

	return 0
end

-- 循环优先级
arrPriorityStrategyFuns[10] = function(self)
	local skillStrategy	= self.skillStrategy

	local index = self.card.nUseCount % (#self.skillStrategy-1) + 2
	-- LogDebugEx("循环优先级",self.card.name, self.id, self.card.nUseCount, index, skillStrategy[index])
	if skillStrategy[index] then
		return skillStrategy[index]
	end

	return 0
end

-- 友方血量比
arrPriorityStrategyFuns[11] = function(self)
	local skillStrategy	= self.skillStrategy

	-- 我方
	local team = self.team
	for k,v in ipairs(team.arrCard) do
		if v:IsLive() then
			local myPercent = v.hp/v:Get("maxhp")
			if myPercent <= skillStrategy[2] then
				return skillStrategy[4]
			end
		end
	end

	return skillStrategy[3]
end

-- 横排最大人数大于等于N
arrPriorityStrategyFuns[12] = function(self)
	local skillStrategy	= self.skillStrategy

	local mgr = self.team.fightMgr
	local team = mgr:GetTeam(mgr:GetEnemyTeamID(self.card))

	if #team.filter:GetMaxRow() >= skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end

-- 竖排最大人数大于等于N
arrPriorityStrategyFuns[13] = function(self)
	local skillStrategy	= self.skillStrategy

	local mgr = self.team.fightMgr
	local team = mgr:GetTeam(mgr:GetEnemyTeamID(self.card))

	if #team.filter:GetMaxCol() >= skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end


-- 田字最大人数大于等于N
arrPriorityStrategyFuns[14] = function(self)
	local skillStrategy	= self.skillStrategy

	local mgr = self.team.fightMgr
	local team = mgr:GetTeam(mgr:GetEnemyTeamID(self.card))

	if #team.filter:GetMaxTian() >= skillStrategy[2] then
		return skillStrategy[3]
	else
		return skillStrategy[4]
	end

	return 0
end


-- 同调判断是否存在对象
arrPriorityStrategyFuns[15] = function(self)
	local skillStrategy	= self.skillStrategy

	local team = self.team


	if #team.filter:GetUnite(self.card) > 0 then
		return skillStrategy[2]
	else
		return skillStrategy[3]
	end

	return 0
end

----------------------------------------------
-- 技能基类
SkillBase = oo.class(FightAPI)

function SkillBase:Init(skillID, card)

	self.id			= skillID
	self.card		= card
	self.team		= card.team
	self.fightMgr	= card.team.fightMgr
	self.log		= card.team.fightMgr.log

	self.curr_cd   = 0 -- 当前cd
	
	self:LoadConfig()
end

-- 注册事件
function SkillBase:RegisterEvent(skillMgr)

	if self.isRegisterEvent then return end -- 防止重复注册
	
	local mgr = self.team.fightMgr
	for k,v in ipairs(arrPassiveTiming) do
		if self[v] then
			--LogDebugEx("注册技能事件", self.name, self.id, v)
			mgr.oFightEventMgr:AddSkillEvent(v, self)
			if v == "OnDeath" then
				-- LogDebugEx("注册死亡事件", self.id, self.card.name)
				table.insert(skillMgr.arrDeathEvent, self)
			-- elseif v == "OnDeath2" then
			-- 	table.insert(skillMgr.arrDeathEvent2, self)
			end
		end
	end

	self.isRegisterEvent = true
end

-- 删除事件
function SkillBase:DeleteEvent()
	local mgr = self.team.fightMgr
	-- LogDebugEx("删除技能事件", self.id, k)
	mgr.oFightEventMgr:DelSkill(self)

	self.isRegisterEvent = nil

	if self.todoOnDel then
		for i,v in ipairs(self.todoOnDel) do
			v.cb(v.arg)
		end
		self.todoOnDel = nil
	end
end


-- 删除回调
function SkillBase:AddTodoOnDelete(cb, arg)
	LogDebugEx("SkillBase:AddTodoOnDelete", self.name)
	self.todoOnDel = self.todoOnDel or {}
	table.insert(self.todoOnDel, {cb = cb, arg = arg})
end


function SkillBase:LoadConfig()
	local config = skill[self.id]
	ASSERT(config, "找不到技能配置 id = "..self.id)

	for k,v in pairs(config) do
		if type(v) ~= "table" then
			self[k] = v
		end
	end

	self.aiStrategy = config.aiStrategy
	self.aiStrategy_src = config.aiStrategy -- 原配置的ai, 用于技能调用
	
	if config.skillStrategy then
		self.skillStrategy = table.copy(config.skillStrategy)
	end

	-- AI处理技能优先级策略
	if self.skillStrategy and #self.skillStrategy >= 3 then
		self.GetPriority = arrPriorityStrategyFuns[self.skillStrategy[1]]
	end

	-- 开场cd/ 普攻不支持开场cd
	if self.type ~= SkillType.Normon and self.begin_cd then
		self.curr_cd = self.begin_cd
	end
end

-- 修改AI
function SkillBase:AlterStrategy(config)

	-- {skillStrategy = skillStrategy, aiStrategy = aiStrategy, skillID = skillID}
	LogDebugEx("SkillBase:AlterStrategy", self.id)
	LogTable(config, "SkillBase:AlterStrategy")
	self.aiStrategy = config.aiStrategy
	
	if config.skillStrategy then
		self.skillStrategy = table.copy(config.skillStrategy)
	end

	-- AI处理技能优先级策略
	if self.skillStrategy and #self.skillStrategy >= 3 then
		-- LogDebugEx("1111111111111111")
		self.GetPriority = arrPriorityStrategyFuns[self.skillStrategy[1]]
	else
		-- LogDebugEx("222222222222")
		self.GetPriority = self.GetPriorityEx
	end
end

-- 技能优先级
function SkillBase:GetPriority()
	LogDebugEx("SkillBase:GetPriority()")
	if not self.skillStrategy then return 0 end
	return self.skillStrategy[1] or 0
end

function SkillBase:GetPriorityEx()
	LogDebugEx("SkillBase:GetPriorityEx()")
	if not self.skillStrategy then return 0 end
	return self.skillStrategy[1] or 0
end

function SkillBase:CanSummon()
end

-- 返回参数 大于0为优先级
-- -1 沉默只能用普攻
-- -2 cd中
-- -3 不可召唤
-- -4 没有可触发对象
-- -5 xp不足
-- -6 np不足
-- -7 sp不足

function SkillBase:CanUse()
	-- LogDebugEx("SkillBase:CanUse", self.id)
	if self.curr_cd > 0 then 
		LogDebugEx("CanUse: on cool down", self.id)
		return -2
	end

	-- 召唤合体判断
	if self.type == SkillType.Summon or self.type == SkillType.SummonUnite then
		if not self:CanSummon() then
			LogDebugEx("CanUse: can not Summon", self.id) 
			return -3
		end	
	elseif self.type == SkillType.Revive then
		-- 复活技能
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		local team = mgr:GetTeam(teamID)
		local tar = team.filter:GetDead()
		if #tar < 1 then
			LogDebugEx("CanUse: Revive not target", self.id) 
			return -4
		end		
	end
	if self.card.silence and self.type ~= SkillType.Normon then
		-- 沉默
		LogDebugEx("CanUse: Can not OverLoad by silence", self.id)
		return -1
	end

	if self.range_key == "one_except_self" then
		if self.team:LiveCount(0) <= 1 then 
			LogDebugEx("CanUse: one_except_self", self.id)
			return -4
		else
			LogDebugEx("one_except_self", self.team:LiveCount(0))
		end
	end

	local ty = self.card:GetType()
	if ty == CardType.Monster or ty == CardType.Boss then 
		--检测xp
		if self.xp and self.xp > 0 then
			if not self.card:CheckXP(self.xp) then
				LogDebugEx("CanUse: no enough xp = ", self.id, self.xp)
				return -5
			end
		end
	else
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()

		-- 扣除cost
		if self.np and self.np > 0 then
			if not mgr:CheckNP(teamID, self.np) then
				LogDebugEx("CanUse: no enough NP", self.id, self.np)
				return -6
			end
		end

	end

	if self.sp and self.sp > 0 then
		if not self.card:CheckSP(self.sp) then
			LogDebugEx("CanUse: no enough SP", self.id, self.sp)
			return -7
		end
	end

	LogDebugEx("CanUse:GetPriority", self.id, self:GetPriority())
	return self:GetPriority()
end

function SkillBase:AICanUse()
	LogDebugEx("SkillBase:AICanUse", self.id, self.sp, self.np)
	if self.curr_cd > 0 then 
		LogDebugEx("AICanUse: on cool down", self.id)
		return 
	end

	-- 召唤合体判断
	if self.type == SkillType.Summon or self.type == SkillType.SummonUnite then
		if not self:CanSummon() then
			LogDebugEx("AICanUse: can not Summon", self.id) 
			return 
		end	
	elseif self.type == SkillType.Revive then
		-- 复活技能
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		local team = mgr:GetTeam(teamID)
		local tar = team.filter:GetDead()
		if #tar < 1 then
			LogDebugEx("AICanUse: Revive not target", self.id) 
			return
		end		
	end
	if self.card.silence and self.type ~= SkillType.Normon then
		-- 沉默
		LogDebugEx("AICanUse: Can not OverLoad by silence", self.id)
		return -1
	end

	if self.range_key == "one_except_self" then
		if self.team:LiveCount(0) <= 1 then 
			LogDebugEx("AICanUse: one_except_self", self.id)
			return 
		else
			LogDebugEx("AICanUse: one_except_self", self.team:LiveCount(0))
		end
	end

	local ty = self.card:GetType()
	--LogDebugEx("ty=", ty)
	if ty == CardType.Monster or ty == CardType.Boss then 
		--LogDebugEx("xxxxxxxxxxxx")
		--检测xp
		if self.xp and self.xp > 0 then
			if not self.card:CheckXP(self.xp) then
				LogDebugEx("AICanUse: no enough xp = ", self.id, self.xp)
				return
			end
		end

		if self.sp and self.sp > 0 then
			if not self.card:CheckSP(self.sp) then
				LogDebugEx("AICanUse: no enough SP", self.id, self.sp)
				return
			end
		end
	else
		--LogDebugEx("1111111111111111111111")
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		-- 扣除cost
		if self.np and self.np > 0 then
			local np = mgr:ReserveNP() -- 预留np
			if not mgr:CheckNP(teamID, self.np + np) then
				LogDebugEx("AICanUse: no enough NP", self.id, self.np)
				return
			end
		end
		--LogDebugEx("2222222222222222")
		if self.sp and self.sp > 0 then
			--LogDebugEx("3333333333333333")
			if mgr:IsReserveSP() and (self.upgrade_type or 4) > 3 then  -- upgrade_type[1-3]的不限制
				LogDebugEx("AICanUse:sp保留")
				return 
			end -- 保留sp

			if not self.card:CheckSP(self.sp) then
				LogDebugEx("AICanUse: no enough SP", self.id, self.sp)
				return
			end
		end
	end

	LogDebugEx("AICanUse:GetPriority end", self.id, self:GetPriority())
	return self:GetPriority()
end
-- 技能消耗
function SkillBase:Cost()
	local ty = self.card:GetType()
	if ty == CardType.Monster or ty == CardType.Boss then 
		--检测xp
		if self.xp and self.xp > 0 then
			if self.card:CheckXP(self.xp) then
				self.card:AddXP(-self.xp)
			else
				LogDebugEx("Cost", self.xp)
				return
			end
		end
	else
		local mgr = self.team.fightMgr
		local teamID = self.card:GetTeamID()
		-- 扣除cost
		if self.np and self.np > 0 then
			if mgr:CheckNP(teamID, self.np) then
				local effect = SkillEffect[72001]
				mgr:AddNP(teamID, -self.np, effect.apiSetting)
			else
				LogDebugEx("Cost", self.np)
				return
			end
		end
	end

	if self.sp and self.sp > 0 then
		if self.card:CheckSP(self.sp) then
			self.card:AddSP(-self.sp, nil, true)
		else
			LogDebugEx("Cost", self.sp)
			return
		end
	end

	return self:GetPriority()
end

-- 回合开始
function SkillBase:RoundBegin(caster, target, ret)
	
end

-- 回合结束
function SkillBase:RoundOver(caster, target, ret)

end

-- 冷却
function SkillBase:CoolDown()
	self.curr_cd = self.curr_cd - 1
	if self.curr_cd < 0 then 
		self.curr_cd = 0
	end
end

function SkillBase:AddCD(num)
	self.curr_cd = self.curr_cd + num
end

-- 重置CD
function SkillBase:ResetCD(effect, caster, target, data, cd)

	--LogDebugEx("SkillBase:ResetCD", self.cd, cd, self.curr_cd, self.id)
	--LogTrace()
	self.curr_cd = cd or self.cd or 0
end

function SkillBase:AddOrder(effect, caster, target, data)
	self.order = self.order + 1
end

XpcallCB = XpcallCB or
function ( msg, ... )
	-- local info = GetServerInfoStr()
	-- msg = info .. (msg or "")
	LogInfo("----------------------------------------")
	LogInfo("LUA ERROR: " .. tostring(msg) .. "\n")
	LogInfo(debug.traceback())
	LogTable({...}, "XpcallCB")
	LogInfo("----------------------------------------")
end
---------------------------------------------------
-- 执行技能(主动)
function SkillBase:Apply(caster, targets, pos, data)
	LogDebugEx("SkillBase:Apply", caster.name, self.id, self.type)
	LogTable(data, "SkillBase:Apply")
	caster.currentSkill = self
	local mgr = self.team.fightMgr
	-- mgr.bCallSkill = nil
	mgr:ResetSkillSign()
	self:ResetCD() -- 上cd

	-- -- 某些技能使源对象死亡
	-- ASSERT(targets[1], "没有攻击对象"..self.id)

	self.order = 0
	self.currentAtkTargets = {} -- 当前回合被攻击的对象
	self.bIsCrit = nil -- 本回合是否触发过暴击
	mgr.currTips = {} -- 当前回合提示过的内容
	mgr.currentDeathsBySkill = {} -- 当前回合被击杀对象(技能导致的死亡)
	mgr.lstCallSkill = {}
	mgr.bIsApply = true

	-- ASSERT()
	local log = {api="OnSkill", id = caster.oid, skillID = self.id, protectId = data.protectId}
	if pos then
		log.grid = {row = pos[1],col = pos[2]}
	else
		ASSERT()
	end

	self.log:Add(log)
	self.log:StartSub("DoSkill")

	self:PreSkill(caster, targets, data)

	if self.type == SkillType.Revive then
		local target = mgr:GetCardByOID(data.target.reliveID)
		ASSERT(target,"找不到复活对象"..data.target.reliveID)
		targets = {target}
		--LogDebugEx("111111111111")
	elseif self.type == SkillType.Summon or self.type == SkillType.SummonUnite then
		targets = {caster}
		--LogDebugEx("2222222222222")
	end

	-- 某些技能使源对象死亡
	if not targets[1] then 
		mgr:ClientError(caster.uid or "", "没有攻击对象"..self.id)
	end
	ASSERT(targets[1], "没有攻击对象"..self.id)   -- 某些玩家死了, 还能调用到死亡事件, 导致删掉了这个位置的怪物
	-- for i,target in ipairs(targets) do
	mgr:DoEventWithLog("OnActionBegin", caster, targets[1], data)
	-- end
	mgr.currentDeathsBySkill = {} -- 当前回合被击杀对象(技能导致的死亡)
	
	if self.isCanHurt then
		for i,target in ipairs(targets) do
			mgr:DoEventWithLog("OnAttackBegin", caster, target, data)
		end
	end

	self:DoSkillEx(caster, targets, pos, data, "DoSkill")

	if self.isCanHurt then

		self:DoDeathEventWithLog()

		for i,target in ipairs(self.currentAtkTargets) do
			target:OnBeAttack(caster)
		end

		for i,target in ipairs(self.currentAtkTargets) do
			-- target:OnBeAttack(caster)
			mgr:DoEventWithLog("OnAttackOver", caster, target, data)-- 攻击者表现还没完成, 还有镜头
		end
		for i,target in ipairs(self.currentAtkTargets) do
			-- target:OnBeAttack(caster)
			mgr:DoEventWithLog("OnAttackOver2", caster, target, data)-- 攻击者表现还没完成, 还有镜头
		end

		self.currentAtkTargets = nil
	else
		if mgr.currentDeathsBySkill and #mgr.currentDeathsBySkill > 0 then
			mgr:ClientError(caster.uid or "", "不是伤害技能但是有死亡"..self.id)
			ASSERT(nil, "不是伤害技能但是有死亡"..self.id)
		end
	end

	local log = {api="OnActionOver"}
	self.log:Add(log)
	self.log:StartSub("datas")

	-- buff 回合-1结算时机调整为，当前回合主体单位，（主动行动结束）时扣除，反击，协战不会影响

	if caster.bIsCommander then
	else
		caster.bufferMgr:OnUpdateBuffer()-- 结算buff回合-1
	end

	mgr:DoEvent("OnActionOver", caster, targets[1], data) -- ?行动结束事件也会导致角色死亡, 无法处理死亡事件
	mgr:DoEvent("OnActionOver2", caster, targets[1], data)


	self:DoDeathEventWithLog()


	-- 行动结束追击反击
	mgr:DealCallSkill()

	-- 4.0 追击反击也可能出现死亡[怪物被动是死亡时候恢复我方角色np，但这个怪物被反击或者额外攻击杀死的时候不会恢复np]
	self:DoDeathEventWithLog()

	self.log:EndSub("datas")

	-- end
	self:AftSkill(caster, targets, data)

	

	self.log:EndSub("DoSkill")

	LogTable(self.log:Get(), "self.log:Get()")
	caster.currentSkill = nil
	
	mgr.lstCallSkill = nil
	mgr.bIsApply = nil
	return {}
end

-- DoSkill调用
function SkillBase:DoSkillEx(caster, targets, pos, data, api)
	if self.DoSkillFuns then 
		self.order = 0
		for d,fun in ipairs(self.DoSkillFuns) do
			self.order = self.order + 1
			for i,target in ipairs(targets) do
				LogDebugEx("攻击者ID = ", caster.name, "受击者id = ", target.name)
				self.nTargetIndex = i
				fun(self, caster, target, data)
			end
		end
	else
		for i,target in ipairs(targets) do
			LogDebugEx(api.."攻击者ID = ", caster.name, "受击者id = ", target.name)
			self.order = 0
			self.nTargetIndex = i
			self:DoSkill(caster, target, data)
		end
	end
end

-- 添加攻击对象
function SkillBase:AddAtkTargets(target)
	self.currentAtkTargets = self.currentAtkTargets or {}
	for i,v in ipairs(self.currentAtkTargets) do
		if v == target then 
			return
		end
	end

	table.insert(self.currentAtkTargets, target)
end

function SkillBase:AddDeaths(target, caster)
	--LogTrace()
	LogDebugEx("SkillBase:AddDeaths", target.name, caster.name)
	local mgr = self.team.fightMgr
	mgr.currentDeathsBySkill = mgr.currentDeathsBySkill or {}
	for i,v in ipairs(mgr.currentDeathsBySkill) do
		if v.target == target then 
			return
		end
	end

	table.insert(mgr.currentDeathsBySkill, {target = target, caster = caster})
end


-- function SkillBase:DoDeathEvent()
-- 	local mgr = self.team.fightMgr
-- 	if mgr.currentDeathsBySkill then
-- 		for i,v in ipairs(mgr.currentDeathsBySkill) do
-- 			v.target:OnDeath(v.caster)
-- 			mgr:DoEventWithSub("OnDeath", v.caster, v.target, data)
-- 			-- mgr:DoEventWithSub("OnDeath2", v.caster, v.target, data)
-- 		end

-- 		mgr.currentDeathsBySkill = nil
-- 	end
-- end

function SkillBase:DoDeathEventWithLog()
	local mgr = self.team.fightMgr
	if mgr.currentDeathsBySkill then
		for i,v in ipairs(mgr.currentDeathsBySkill or {}) do

			local log = {api="OnDeath", id = v.caster.oid, targetID = v.target.oid}
			self.log:Add(log)
			self.log:StartSub("datas")

			v.target:OnDeath(v.caster)
			mgr:DoEvent("OnDeath", v.caster, v.target, data)
			-- mgr:DoEvent("OnDeath2", v.caster, v.target, data)

			self.log:EndSub("datas")
			-- LogTrace()
		end
		mgr.currentDeathsBySkill = nil
	end
end


-- 协战
function SkillBase:OnHelp(effectID, caster, helper, target, pos, data)
	-- 无法行动时不触发
	local isMotionless = helper:IsMotionless()
	if isMotionless then

		-- 牢笼时攻击牢笼
		if eMotionlessType.Cage == isMotionless then
			local buff = helper.bufferMgr:GetBufferByID(3008, 1)
			if buff[1] then
				buff[1]:AttackCage(SkillEffect[effectID], helper, target, data, 1)
			end
		end
		-- LogDebugEx("无法行动时不触发")
		return
	end

	-- -- 普攻是群攻就不协助
	-- local oSkill = caster.currentSkill
	local oSkill = helper.skillMgr:GetNormon()
	
	--暂时屏蔽
	-- if not oSkill.isSingle then return end

	local mgr = self.team.fightMgr
	if mgr.bInHelp then return end -- 禁止协战中触发协战

	mgr.bInHelp = true
	-- 群攻技能协战
	local tgtData = {target}
	if not oSkill.isSingle then
		local tgtIds = helper:GetSkillRange(oSkill.id, target)
		local tmpData = {}
		for i,oid in ipairs(tgtIds) do
			local card = mgr:GetCardByOID(oid)
			table.insert(tmpData, card)
		end
		if not table.empty(tmpData) then
			tgtData = tmpData
		end
	end
	local ret = oSkill:OnCallSkill(effectID, helper, tgtData --[[realTagets]], pos, data)
	mgr.bInHelp = nil

	return ret
end

-- 调用技能
function SkillBase:OnCallSkill(effectID, caster, targets, pos, data, api)
	self.currentAtkTargets = self.currentAtkTargets or {}
	if not targets or not targets[1] then return end
	if not caster:IsLive() then 
		-- 二段伤害攻击方可能被在第一次攻击时已经被反伤致死
		LogDebugEx("OnCallSkill攻击方死亡")
		return 
	end

	api=api or "OnHelp"
	LogDebug("调用技能{%s}id{%s}", api, self.id)
	local mgr = self.team.fightMgr
	local lastSkill = caster.currentSkill
	local currTurn = mgr.currTurn
	mgr.currTurn = caster

	self.callSkillType = api
	caster.currentSkill = self
	caster:ResetDamageStats(self)

	self.order = 0
	local log = {api=api, id = caster.oid, skillID = self.id, effectID = effectID, protectId = data.protectId}
	if pos then
		log.grid = {row = pos[1],col = pos[2]}
	end
	self.log:Add(log)

	self.log:StartSub("DoSkill")

	mgr:DoEventWithLog("OnActionBegin", caster, targets[1], data)
	if self.isCanHurt then
		for i,target in ipairs(targets) do
			mgr:DoEventWithLog("OnAttackBegin", caster, target, data)
		end
	end

	self:DoSkillEx(caster, targets, pos, data, api)
	-- for i,target in ipairs(targets) do
	-- 	LogDebugEx(api.."攻击者ID = ", caster.name, "受击者id = ", target.name)
	-- 	self.order = 0
	-- 	self.nTargetIndex = i
	-- 	self:DoSkill(caster, target, data)
	-- end

	if self.isCanHurt then
		
		self:DoDeathEventWithLog()

		self.currentAtkTargets = self.currentAtkTargets or {} -- 这里不知道什么事件把他清掉了
		
		for i,target in ipairs(self.currentAtkTargets) do
			target:OnBeAttack(caster)
			-- mgr:DoEventWithLog("OnAttackOver", caster, target, data)
		end
		for i,target in ipairs(self.currentAtkTargets) do
			-- target:OnBeAttack(caster)
			mgr:DoEventWithLog("OnAttackOver", caster, target, data)
		end
		for i,target in ipairs(self.currentAtkTargets) do
			-- target:OnBeAttack(caster)
			mgr:DoEventWithLog("OnAttackOver2", caster, target, data)
		end

		self.currentAtkTargets = {} --不能设为nil 防止Apply循环报错
	-- else
	-- 	if mgr.currentDeathsBySkill then
	-- 		ASSERT(nil, "不是伤害技能但是有死亡")
	-- 	end
	end

	local log = {api="OnActionOver"}
	self.log:Add(log)
	self.log:StartSub("datas")

	mgr:DoEvent("OnActionOver", caster, targets[1], data)
	mgr:DoEvent("OnActionOver2", caster, targets[1], data)

	-- LogTrace()
	LogDebugEx("OnCallSkill mgr.bIsApply=", mgr.bIsApply, self.id)
	if not mgr.bIsApply then -- 非技能中, 其他事件的调用
		-- 行动结束追击反击
		mgr.bIsApply = true
		mgr:DealCallSkill()
		mgr.bIsApply = nil  -- 102300205，被打后，不会触发反击。
	end
	LogDebugEx("OnCallSkill end", mgr.bIsApply, self.id)
	
	self.log:EndSub("datas")

	-- mgr:DoEventWithLog("OnActionOver", caster, targets[1], data)


	self.log:EndSub("DoSkill")

	self.callSkillType = nil
	caster.currentSkill = lastSkill
	mgr.currTurn = currTurn
	LogDebug("调用技能结束{%s}id{%s}----------", api, self.id)
	return {}
end

-- 执行技能之前
function SkillBase:PreSkill(caster, target)
	self.card:ResetDamageStats(self)
	self.card:OnAttack(caster, target, self)
end

-- 执行技能
function SkillBase:DoSkill(caster, target, data)

	LogDebugEx("--------------DoSkill------------------------", self.attackType, self.id)
	if self.attackType then
		if self.attackType == 1 then
			self:DamagePhysics({}, caster, target, data, 1, self.attackNum)
		elseif self.attackType == 2 then
			self:DamageLight({}, caster, target, data, 1, self.attackNum)
		else
			-- self:Damage(0, caster, target, 4, 1, self.attackNum)
			ASSERT(nil, "attackType类型错误")
		end
	end 
end

-- 执行技能之后
function SkillBase:AftSkill(caster, target)
	self.card:AfterAttack(caster, target, self)
end
---------------------------------------------------
-- 事件

-- -- 暴击
-- function SkillBase:OnCrit(caster, target)
-- end

-- 主动攻击
function SkillBase:OnAttack(caster, target)
end

-- 受击
function SkillBase:OnBeAttack(caster, target)
	LogDebugEx("SkillBase:OnBeAttack", caster.name, target.name)
end

------------------通用api---------------------------------
-- 技能效果 (主动)

-- 兵种克制
function CorpsAdjust(caster, target)
	
	-- -- 天赋2、飞行兵种攻击地面单位伤害增加（可以修改飞行兵技能Damage函数）
	-- if caster:CanFly() then
	-- 	if target:CanFly() then end --飞行对飞行(无效果)
	-- 	local config = caster:GetSign("FlyAdjust") -- 飞行兵种加成
	-- 	if not config then return end
	-- 	-- 某些地面兵种技能无视飞行兵种天赋
	-- 	if target:GetTempSign("ImmuneFlyAdjust") then -- 免疫飞行兵种加成
	-- 		return true, 0
	-- 	end

	-- 	local r = caster:Rand(10000)
	-- 	if r <= config.rand then
	-- 		return true, config.percent
	-- 	end
	-- end

	-- 天赋1、飞行兵种一定几率MISS地面兵种攻击（判断target是飞行且有天赋，caster是地面）
	-- if target:CanFly() then
		-- if caster:CanFly() then return end --飞行对飞行(无效果)
		local config = target:GetSign("MissSurface") -- MISS地面兵种
		local config2 = target:GetSign("MissSurface2") -- MISS地面兵种
		if not config and not config2 then return end
		local rand = 0
		if config then 
			rand = config.rand
			-- LogDebug("[%s]:MissSurface=[%s]", target.name, config.rand)
		end

		if config2 then 
			rand = rand + config2.rand
			-- LogDebug("[%s]:MissSurface2=[%s]", target.name, config2.rand)
		end

		local r = caster:Rand(10000)
		LogDebug("CorpsAdjust[%s] rand[%s], MissSurface=%s",target.name, r, rand)
		if r <= rand then
			return true, 0
		end
	-- end
end

function DealDamage(oSkill, log, caster, target, data, eDamage)

	target.nShareDamage = nil
	local _, shield, hpDamage = target:DealShield(-log.value, caster)

	if hpDamage < 0 and not caster.bIgnoreShareDamage then
		local isshare = target:GetValue("rateShareDamage")
		
		if isshare and isshare > 0 then
			local arr = target.team.filter:GetAll(target)
			local count = #arr
			if count > 0 then -- 有队友
				local nShareDamage = math.floor(-hpDamage*isshare)
				LogDebugEx("分摊前/后伤害", hpDamage, hpDamage + nShareDamage)
				hpDamage = hpDamage + nShareDamage -- 真正的伤害
				target.nShareDamage = math.floor((nShareDamage)/count) -- 分摊到每个队友的伤害量
			end 
		end
	end

	local tisdeath, _ , num, abnormalities = target:AddHp(hpDamage, caster, true, true)--先分摊还是先免疫?
	log.hpDamage = -num
	oSkill.card.nSkillDamage = oSkill.card.nSkillDamage - num 
	oSkill.card.nLastHitDamage = -num

	if eDamage == eDamageType.Physics then 
		target.nBeSkillDamagePhysics = target.nBeSkillDamagePhysics - num 
	elseif eDamage == eDamageType.Light then 
		target.nBeSkillDamageLight = target.nBeSkillDamageLight - num 
	end

	log.shieldDamage = shield
	log.hp = target:Get("hp")
	log.abnormalities = abnormalities

	oSkill.log:EndSub("OnAttack")

	if num ~= 0 then
		-- 活的才掉伤害事件(可能之前就被反弹死)
		-- if caster:IsLive() then
		local mgr = oSkill.team.fightMgr
		mgr:DoEventWithSub("OnAfterHurt", caster, target, data)
		-- end
	end
end

-- 通用伤害 eDamageType 攻击类型
function SkillBase:Damage(effect, caster, target, data, percent, count, maxcount, eDamage, careerAdjust)
	LogDebugEx("SkillBase:Damage",  caster.name, target.name)
	-- target.GetDamage = FightCardBase.GetDamageCommon
	-- local effect = SkillEffect[effectID]

	if maxcount and maxcount > count then
		local r = self.card:Rand(maxcount - count)
		count = count + r
	end

	local bIgnoreSingleAttack = nil

	LogDebugEx("SkillBase:Damage---", target.name, target.bIgnoreSingleAttack, self.isSingle)
	-- 无视单攻
	if self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
		bIgnoreSingleAttack = true
	end

	LogDebugEx("SkillBase:Damage", percent, self.percent)
	percent = percent * self.percent
	eDamage = eDamage or eDamageType.Damage
	caster.currentEDamage = eDamage -- 当前技能伤害类型

	self.log:Add({api="Damage", id = target.oid, type = eDamage, 
		order = self.order, effectID = effect.apiSetting})
	self.log:StartSub("datas")

	count = count or 1
	local isdeath = nil
	local bIsLive = target:IsLive() -- 记录原来的状态, 死了就不再添加死亡列表
	local mgr = self.team.fightMgr

	for i=1,count do
		
		local log = {}
		self.log:Add(log)
		log.restrain = careerAdjust -- 1物理2能量
		
		mgr:DoEventWithSub("OnBefourCritHurt", caster, target, data)
		
		-- 大多数都是在OnBefourHurt中判断IsCrit
		local crit = target:IsCrit(caster)
		mgr.isCrit = crit

		mgr:DoEventWithSub("OnBefourHurt", caster, target, data)

		if crit then
			log.crit = crit
			self.bIsCrit = true
			mgr:DoEventWithSub("OnCrit", caster, target, data)
		end

		self.log:StartSub("OnAttack")
		--LogDebugEx("-------target:GetDamage--------", percent, crit, eDamage, careerAdjust)
		local attack = target:GetDamage(caster, percent, crit, eDamage, careerAdjust, log)
		local isAdjust, corpsAdjust= CorpsAdjust(caster, target)
		log.value = attack
		local isMiss = bIgnoreSingleAttack

		if isAdjust then -- 兵种克制
			if corpsAdjust == 0 then
				log.miss = true
				isMiss = true
			else
				log.value = math.floor(log.value * corpsAdjust)
			end
		end
		
		if not isMiss --[[and target:IsLive()]] then
			
			DealDamage(self, log, caster, target, data, eDamage)

		elseif isMiss then
			self.log:EndSub("OnAttack")
			log.miss = true
			log.hp = target:Get("hp")
		else
			self.log:EndSub("OnAttack")
		end
		mgr.isCrit = nil

		mgr:ResetTempAttr()
		if not caster:IsLive() then break end -- 可能被之前乱七八糟的事件弄死了
	end

	caster.currentEDamage = nil
	isdeath = not target:IsLive()
	if bIsLive and isdeath then --本来活的, 现在死了才加入
		self:AddDeaths(target, caster)
	end

	self.log:EndSub("datas")
	self.log:Alter("death", isdeath)

	self:AddAtkTargets(target)
	return attack, crit, isdeath
end

-- -- 额外伤害
function SkillBase:ExtraDamage(effect, caster, target, data, percent, count, maxcount, eDamage)
	-- local effect = SkillEffect[effectID]
	if maxcount and maxcount > count then
		local r = self.card:Rand(maxcount - count)
		count = count + r
	end

	local bIgnoreSingleAttack = nil
	-- 无视单攻
	if self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
		bIgnoreSingleAttack = true
	end

	LogDebugEx("SkillBase:ExtraDamage", percent, self.percent)
	percent = percent * self.percent
	eDamage = eDamage or eDamageType.Extra

	self.log:Add({api="ExtraDamage", id = target.oid, type = eDamage, 
		order = self.order, effectID = effect.apiSetting})
	self.log:StartSub("datas")

	count = count or 1
	local isdeath = nil
	local bIsLive = target:IsLive() -- 记录原来的状态, 死了就不再添加死亡列表
	local mgr = self.team.fightMgr

	for i=1,count do
		-- mgr:DoEventWithSub("OnBefourHurt", caster, target, data)

		local crit = target:IsCrit(caster)
		local log = {crit = crit}
		self.log:Add(log)
		
		-- if crit then
		-- 	mgr:DoEventWithSub("OnCrit", caster, target, data)
		-- end

		self.log:StartSub("OnAttack")
		local attack = target:GetDamage(caster, percent, crit)
		log.value = attack
			
		if not bIgnoreSingleAttack and target:IsLive() then
			

			local tisdeath, shield, num, abnormalities = target:AddHp(-attack, caster, true)
			log.hpDamage = -num
			self.card.nSkillDamage = self.card.nSkillDamage - num
			self.card.nLastHitDamage = -num

			log.shieldDamage = shield
			log.hp = target:Get("hp")
			log.abnormalities = abnormalities
			isdeath = tisdeath
			target:OnBeAttack(caster)

			self.log:EndSub("OnAttack")

			-- if num ~= 0 then
			-- 	mgr:DoEventWithSub("OnAfterHurt", caster, target, data)
			-- end

			if bIsLive and isdeath then --本来活的, 现在死了才加入
				self:AddDeaths(target, caster)
			end
		elseif bIgnoreSingleAttack then
			self.log:StartSub("OnAttack")
			log.miss = bIgnoreSingleAttack
			log.hp = target:Get("hp")
		else
			self.log:StartSub("OnAttack")
		end
	end

	self.log:EndSub("datas")
	self.log:Alter("death", isdeath)
	return attack, crit, isdeath
end


-- 物理伤害
function SkillBase:DamagePhysics(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("SkillBase:DamagePhysics", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career, caster:Get("damagePhysics"))
	percent = percent * caster:Get("damagePhysics")
	local careerAdjust = nil
	if target.career == eCareer.Light then
		-- 物理克制
		careerAdjust = 1 
	end
	return self:Damage(effect, caster, target, data, percent, count, maxcount, eDamageType.Physics, careerAdjust)
end

-- 光束伤害
function SkillBase:DamageLight(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("SkillBase:DamageLight", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career, caster:Get("damageLight"))

	percent = percent * caster:Get("damageLight")
	local careerAdjust = nil
	if target.career == eCareer.Physics then
		-- 能量克制
		careerAdjust = 2
	end
	return self:Damage(effect, caster, target, data, percent, count, maxcount, eDamageType.Light, careerAdjust)
end

-- 特殊伤害(已废弃)
function SkillBase:DamageSpecial(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("SkillBase:DamageSpecial", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career)

	percent = percent * caster:Get("damageSpecial")
	local careerAdjust = nil

	--  特殊克特殊
	if target.career == eCareer.Special then
		careerAdjust = true
	end
	return self:Damage(effect, caster, target, data, percent, count, maxcount, eDamageType.Special, careerAdjust)
end

-- 召唤
function SkillBase:Summon(effect, caster, target, data, monsterID, ty, pos, sdata)
	-- local effect = SkillEffect[effectID]
	local mgr = self.team.fightMgr
	local teamID = 0
	if ty == 1 then
		teamID = caster:GetTeamID()
		if mgr.oDuplicate then
			mgr.oDuplicate:OnBorn({ caster.cuid })
		end
	elseif ty == 2 then
		teamID = target:GetTeamID()
	else
		ASSERT()
	end
	local card = mgr:Summon(caster, teamID, monsterID, pos, sdata)

	local datas = {card:GetShowData()}
	if card.oRelevanceCard then
		for i,v in ipairs(card.oRelevanceCard) do
			table.insert(datas, v:GetShowData())
		end
	end

	self.log:Add({api="Summon", id = caster.oid, uid=caster.uid, datas = datas, effectID = effect.apiSetting})
	
	-- 解决召唤在出生之前
	mgr:OnBorn(card, true)

	return card
end

-- 合体
function SkillBase:Unite(effect, caster, target, data, monsterID, sdata)
	LogDebugEx("SkillBase:Unite", caster.sp , target.sp)
	-- if target.sp < 100 then 
	-- 	ASSERT("无法同调sp不够")
	-- 	return 
	-- end

	local mgr = self.team.fightMgr

	local card = mgr:Unite(caster, target, monsterID, sdata)
	if not card then return end

	-- 修改合体模型(合体皮肤)
	if caster.modelA and caster.modelA > 0 then 
		card.model = caster.modelA
	end

	if mgr.oDuplicate then
		mgr.oDuplicate:Unite({ caster.cuid })
	end

	self.log:Add({api="Unite", id = caster.oid, ids ={caster.oid,target.oid}, 
		datas = {card:GetShowData()}, effectID = effect.apiSetting})

	card:AddBuff(card, g_UniteBuffer) --合体无法加sp的buff
	mgr:OnBorn(card, true)

	return card
end

-- 机神同调
function SkillBase:SummonUnite(effect, caster, target, data, monsterID, ty, pos, sdata)

	local mgr = self.team.fightMgr
	local teamID = 0
	if ty == 1 then
		teamID = caster:GetTeamID()
		if mgr.oDuplicate then
			mgr.oDuplicate:OnBorn({ caster.cuid })
		end
	elseif ty == 2 then
		teamID = target:GetTeamID()
	else
		ASSERT()
	end

	-- 获取原机神
	local team = mgr:GetTeam(teamID)--self.arrTeam[teamID]
    ASSERT(team)
    local site = mgr:GetPosCard(teamID, pos)
    if site and site:IsLive() then
		-- 注销原机神
        team:RemoveCard(site)
    else
        return
    end


	-- 给原召唤主和当前召唤主加免死buff


	-- 创建新机神
	local card = team:Summon(caster, monsterID, pos, data)
	card.isSummonUnite = true -- 同调机神

	local datas = {card:GetShowData()}
	if card.oRelevanceCard then
		for i,v in ipairs(card.oRelevanceCard) do
			table.insert(datas, v:GetShowData())
		end
	end

	self.log:Add({api="SummonUnite", id = caster.oid, uid=caster.uid, datas = datas, effectID = effect.apiSetting})
	
	-- 解决召唤在出生之前
	mgr:OnBorn(card, true)

	return card
end


-- 指定技能攻击
function SkillBase:CallSkillFun(effect, caster, target, data, skillID, api)
	LogDebugEx("SkillBase:CallSkillFun", self.id, api, caster.name, target.name)
	-- LogTrace()
	-- local attacker = caster
	-- local beattacker = target

	-- 死了就不能调用技能
	if not caster:IsLive() then return end

	local skillMgr = caster.skillMgr
	local skl = nil --skillMgr:GetNormon()
	local mgr = self.team.fightMgr
	
	local isMotionless = caster.bufferMgr:IsMotionless()
	-- 无法行动
	if isMotionless then return end

	-- 有技能并且不是沉默状态
	if skillID and not caster.silence then
		skl = skillMgr:GetSkill(skillID)
		if not skl then
			skl = skillMgr:CreateSkill(skillID)
			table.insert(skillMgr.skills, skl)
			skillMgr.initiativeSkills[skillID] = skl
			skillMgr.mapSkills[skl.skillGroup] = skl
		end
	else
		skl = skillMgr:GetNormon()
		skillID = skl.id
	end
	ASSERT(skl, "没有技能配置"..skillID)
	local skillData = {
		casterID	= caster.oid,
		skillID		= skillID,
	}

	-- 获取攻击对象
	if target and target:IsLive() then
		local targetdata	= caster:AIGetTargetPos(skillID, target, {})
		skillData.pos		= targetdata.pos
		skillData.targetIDs	= caster:GetSkillRange(skillID, targetdata)

		-- LogTable(skillData)
		if #skillData.targetIDs == 0 then
			-- ASSERT(nil, "没有攻击对象"..skillID)
			-- return
			table.insert(skillData.targetIDs, target.oid)
			-- LogTrace()
		end
	else
		skillData = caster:AIGetTarget(skillID)
	end

	if not skillData.targetIDs or table.empty(skillData.targetIDs) then return end

	local mgr = self.team.fightMgr
	skillData.targetIDs = mgr:CheckProtectEx(caster, skillData.targetIDs, skillData, skl)

	local realTagets = {}
	for i,oid in ipairs(skillData.targetIDs or {}) do
		local card = mgr:GetCardByOID(oid)
		table.insert(realTagets, card)
	end

	skl:OnCallSkill(effect.apiSetting, caster, realTagets, pos, skillData, api)

	-- 调用技能后处理
	-- mgr:DoEventWithSub("AfterCallSkill", caster, target, data)

	return true
end

-- 调用技能(AI选择目标)
function SkillBase:CallSkillEx(effect, caster, target, data, skillID, api)

	LogDebugEx("SkillBase:CallSkillEx", caster.name, skillID)
	--LogTrace()
	-- 死了就不能调用技能
	if not caster:IsLive() then return end
	
	local skillMgr = caster.skillMgr
	local skl = skillMgr:GetSkill(skillID)
	local mgr = self.team.fightMgr
	local isMotionless = caster.bufferMgr:IsMotionless()
	-- 无法行动
	if isMotionless then return end

	if not skl then
		skl = skillMgr:CreateSkill(skillID)
		table.insert(skillMgr.skills, skl)
		skillMgr.initiativeSkills[skillID] = skl
		skillMgr.mapSkills[skl.skillGroup] = skl
	end

	local skillData = caster:AIGetTarget(skillID)
	--LogDebugEx("------------------")
	--LogTable(skillData);
	if not skillData.targetIDs or table.empty(skillData.targetIDs) then return end

	local mgr = self.team.fightMgr
	skillData.targetIDs = mgr:CheckProtectEx(caster, skillData.targetIDs, skillData, skl)

	local realTagets = {}
	for i,oid in ipairs(skillData.targetIDs or {}) do
		local card = mgr:GetCardByOID(oid)
		table.insert(realTagets, card)
	end

	skl:OnCallSkill(effect.apiSetting, caster, realTagets, pos, skillData, "CallSkill")

	-- 调用技能后处理
	mgr:DoEventWithSub("AfterCallSkill", caster, target, data)
end

-- 调用自己技能技能
function SkillBase:CallOwnerSkill(effect, caster, target, data, skillID, api)

	-- local currentAtkTargets = self.currentAtkTargets

	-- self.currentAtkTargets = {}
	local caster = self.card
	if not target:IsLive() then return end-- 目标死了就不能调用技能
	-- self:CallSkillEx(effect, self.card, target, data, skillID, api)
	LogDebugEx("CallOwnerSkill", caster.name, "攻击", target.name)

	local skillMgr = caster.skillMgr
	local skl = skillMgr:GetSkill(skillID)
	local mgr = self.team.fightMgr
	local isMotionless = caster.bufferMgr:IsMotionless()
	-- 无法行动
	if isMotionless then return end

	-- 对面死光会打自己人--?

	if not skl then
		skl = skillMgr:CreateSkill(skillID)
		table.insert(skillMgr.skills, skl)
		skillMgr.initiativeSkills[skillID] = skl
		skillMgr.mapSkills[skl.skillGroup] = skl
	end

	local skillData = {
		casterID	= caster.oid,
		skillID		= skillID,
	}

	local targetdata	= caster:AIGetTargetPos(skillID, target, {})
	skillData.pos		= targetdata.pos
	skillData.targetIDs	= caster:GetSkillRange(skillID, targetdata)

	if #skillData.targetIDs == 0 then
		table.insert(skillData.targetIDs, target.oid)
	end

	if not skillData.targetIDs or table.empty(skillData.targetIDs) then return end

	local mgr = self.team.fightMgr
	skillData.targetIDs = mgr:CheckProtectEx(caster, skillData.targetIDs, skillData, skl)

	local realTagets = {}
	for i,oid in ipairs(skillData.targetIDs or {}) do
		local card = mgr:GetCardByOID(oid)
		table.insert(realTagets, card)
		--LogDebugEx("card.name=", card.name)
	end

	--LogTable(skillData, "skillData = ")

	skl:OnCallSkill(effect.apiSetting, caster, realTagets, pos, skillData, "CallSkill")

	-- self.currentAtkTargets = currentAtkTargets
end


function SkillBase:CallSkill(effect, caster, target, data, skillID, api)
	--LogTrace()
	LogDebugEx("CallSkill", caster.name, "攻击", target.name)
	
	local data = {
		obj = self,
		fun = self.CallSkillEx,
		arg = {effect, self.card, target, data, skillID, "CallSkill"}
	}

	-- 无法行动时不触发
	local isMotionless = caster:IsMotionless()
	if isMotionless then return end

	local mgr = self.team.fightMgr
	mgr.lstCallSkill = mgr.lstCallSkill or {}

	for i,v in ipairs(mgr.lstCallSkill) do
		-- 同一个人的一个技能只会调一次
		if v.arg[5] and v.arg[5] == skillID and v.arg[2] == self.card then
			return
		end
	end

	-- if mgr.lstCallSkill and #mgr.lstCallSkill > 0 then return end
	-- if mgr.bCallSkill then return end
	table.insert(mgr.lstCallSkill, data)
	mgr.bCallSkill = true

	-- LogTrace()
end

-- 追击
function SkillBase:BeatAgain(effect, caster, target, data, skillID)
	-- 死了就不能调用追击
	if not caster:IsLive() then return end

	-- 无法行动时不触发
	local isMotionless = caster:IsMotionless()
	if isMotionless then return end

	local data = {
		obj = self,
		fun = self.CallSkillFun,
		arg = {effect, caster, target, data, skillID, "BeatAgain"}
	}

	local mgr = self.team.fightMgr
	-- if mgr.lstCallSkill and #mgr.lstCallSkill > 0 then return end
	if mgr.bBeatAgain then return end
	LogDebug("{%s}追击,目标是{%s}, index{%s}",caster.name, target.name, index or "0")

	mgr.lstCallSkill = mgr.lstCallSkill or {}

	--追击在反击前(不是同一方插到前面去)
	if #mgr.lstCallSkill > 0 then
		for i,v in ipairs(mgr.lstCallSkill) do
			if v.arg[6] and v.arg[6] == "BeatBack" and v.arg[2]:GetTeamID() ~= caster:GetTeamID() then
				table.insert(mgr.lstCallSkill, i, data)
				mgr.bBeatAgain = true
				return
			end
		end
	end

	table.insert(mgr.lstCallSkill, data)
	-- mgr.bCallSkill = true
	mgr.bBeatAgain = true
end

-- 反击
function SkillBase:BeatBack(effect, caster, target, data, skillID, index)
	LogDebug("{%s}反击,目标是{%s}, index{%s}",caster.name, target.name, index or "0")
	-- 死了就不能调用反击
	if not caster:IsLive() or not target:IsLive() then return end

	-- 无法行动时不触发
	local isMotionless = caster:IsMotionless()
	if isMotionless then return end

	-- 免疫反击 
	if caster:GetSign("ImmuneBeatBack") then return end

	LogTable(target:GetSign("ImmuneBeatBack"),"target ImmuneBeatBack=")
	LogTable(caster:GetSign("ImmuneBeatBack"),"caster ImmuneBeatBack=")
	--LogDebugEx("SkillBase:BeatBack------------1")
	-- -- 已经死了就不触发反击
	-- if not target:IsLive() then return end

	local data = {
		obj = self,
		fun = self.CallSkillFun,
		arg = {effect, target, caster, data, skillID, "BeatBack"}
	}

	local mgr = self.team.fightMgr
	-- if mgr.lstCallSkill and #mgr.lstCallSkill > 0 then return end

	-- index 支持同一回合多次触发
	mgr.bBeatBack = mgr.bBeatBack or {}
	index = index or 0
	LogDebugEx("SkillBase:BeatBack------------3", index)
	if mgr.bBeatBack[index] then return end
	mgr.lstCallSkill = mgr.lstCallSkill or {}
	table.insert(mgr.lstCallSkill, data)
	mgr.bBeatBack[index] = true

	LogDebugEx("SkillBase:BeatBack------------end")
end


-- 变身
function SkillBase:Transform(effect, caster, target, data, sdata)
	-- ASSERT(data.target.bTransfoState)
	-- 容错处理(没有指定变身状态, 未变身变身, 已变身恢复)
	data.target = data.target or {}
	if  not data.target.bTransfoState then
		if target.nTransformState then
			data.target.bTransfoState = 0
		else
			data.target.bTransfoState = 1
		end
	end

	target:Transform(data.target.bTransfoState)

	if sdata then
		for k,v in pairs(sdata) do
			target[k] = v
		end
	end
end

-- 镜像技能
function SkillBase:AddMirrorSkill(effect, caster, target, data, sdata)

	caster:AddMirrorSkill(self, target)

	if sdata then
		for k,v in pairs(sdata) do
			caster[k] = v
		end
	end
end


function SkillBase:GetTargetIndex()
	return self.nTargetIndex or 1
end
