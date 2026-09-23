-- -- OPENDEBUG(false)
----------------------------------------------
-- 战队阵列
Team = oo.class()
-- row ==> x  col ==> y
function Team:Init(teamID, fightMgr, row, col)
	self.id = id
	self.teamID = teamID
	self.arrCard = {} -- 可行动的卡牌队列
	self.map = {} -- 阵容地图
	self.mapchace = {} -- 地图缓存(占格,合体,召唤位等用已缓存旧数据)
	self.fightMgr = fightMgr
	self.log = fightMgr.log
	ASSERT(self.log)
end

function Team:Destroy()
	LogDebugEx("Team:Destroy()")

	for k,v in pairs(self.arrCard) do
		v:Destroy()
	end    
	if self.oCommander then
		self.oCommander:Destroy()
	end

	for k,v in pairs(self) do
		self[k] = nil
	end
end

function Team:InitMap(row, col)
	self.arrCard = {} -- 可行动的卡牌队列
	self.map = {} -- 阵容地图
	self.row = row
	self.col = col

	for i = 1, row + 1 do
		self.map[i] = {}
		self.mapchace[i] = {}
	end

	-- 筛选器
	self.filter = Filter(self, self.teamID, row, col)
end

function Team:LoadConfig(id, stage, hpinfo)
	LogTable(hpinfo, "Team:LoadConfig:hpinfo")
	-- LogTrace()
	-- LogDebugEx("Team:LoadConfig", id, stage)
	self.id = id
	local config = MonsterGroup[self.id]
	if not config then
		ASSERT(false, "Team:LoadConfig not find config in MonsterGroup id:" .. self.id)
	end

	-- DT(config, "Team:LoadConfig")
	local stageconfig = config.stage[stage]
	if not stageconfig then
		ASSERT(false, "Team:LoadConfig not find config in MonsterGroup id:" .. self.id .. " stage:" .. stage)
	end

	self.stage = stage
	self.formationID = stageconfig.formation
	self.monsters = stageconfig.monsters

	local formation = MonsterFormation[self.formationID]
	if not formation then
		ASSERT(false, "Team:LoadConfig not find config in MonsterFormation formationID: " .. self.formationID)
	end

	self:InitMap(formation.size[1], formation.size[2])

	if hpinfo then
		for i, pos in ipairs(formation.coordinate) do
			local monsterID = self.monsters[i]
			if hpinfo[i] and hpinfo[i].hp and hpinfo[i].hp > 0 and monsterID and monsterID ~= 0 then
				local card = self:AddCard(pos[1], pos[2], monsterID)
				-- LogTable(hpinfo[i], "direct_hpinfo[i]==============");
				card.hp = hpinfo[i].hp
				if hpinfo[i].sp then
					card.sp = hpinfo[i].sp
				end
				card.configIndex = i
			end
		end

	else
		for i, pos in ipairs(formation.coordinate) do
			local monsterID = self.monsters[i]
			if monsterID and monsterID ~= 0 then
				local card = self:AddCard(pos[1], pos[2], monsterID)
				card.configIndex = i
			end
		end
	end
end

function Team:LoadData(data, typ, tCommanderSkill)
	self.nCardCount = #data -- 进战斗时的卡牌数量
	for k, v in ipairs(data) do
		local card = self:SetCard(v, typ)
		if card then card.nIndex = k end
	end

	-- 指挥官技能
	if tCommanderSkill then
		local card = FightCard(self, 10000, self:GetTeamID(), self.uid, {skills = tCommanderSkill, bIsCommander = true}, typ)
		card.oid = self.teamID
		self.oCommander = card
	end
end

function Team:LoadBossConfig(id, stage)
	self.id = id
	local config = MonsterGroup[self.id]
	ASSERT(config)
	-- DT(config, "Team:LoadConfig")
	local stageconfig = config.stage[stage]
	ASSERT(stageconfig)

	self.stage = stage
	self.formationID = stageconfig.formation
	self.monsters = stageconfig.monsters

	local formation = MonsterFormation[self.formationID]
	ASSERT(formation)

	self:InitMap(formation.size[1], formation.size[2])

	for i, pos in ipairs(formation.coordinate) do
		local monsterID = self.monsters[i]
		if monsterID and monsterID ~= 0 then
			local card = self:AddBoss(pos[1], pos[2], monsterID)
			if card then
				return card
			end
		end
	end
	ASSERT(nil, "找不到boss配置")
end

-- 召唤  isSummon2Summon[[召唤怪召唤的]]
function Team:Summon(caster, monsterID, pos, data, isSummon2Summon)
	--'Summon',	'10000001,1,{0,1},{progress=600}'
	LogDebugEx("Team:Summon", monsterID, pos[1], pos[2])
	-- LogTable(data)
	local card = self:AddSummonCard(pos[1], pos[2], monsterID)
	card.type = CardType.Summon
	card.oSummonOwner = caster -- 设置召唤主
	caster.oSummoner = card -- 设置召唤物
	card.uid = caster.uid
	if not isSummon2Summon then
		caster.oSummonObj = card -- 设置召唤物
	end
	card:LoadMonsterNumerical(caster.level)
	
	-- 自定义的特殊数值
	if data then
		for k, v in pairs(data) do
			card[k] = v
		end
	end

	LogDebugEx("card.model", caster.modelA)
	-- 购买皮肤后, 机神皮肤也需要更换(此处确认没有机神皮肤, 先屏蔽)
	if caster.modelA then 
		card.model = caster.modelA
	end
	-- -- self.fightMgr:OnBorn(card, true)

	if data then
		-- 关联召唤怪
		if data.arrRelevance and #data.arrRelevance > 0 then
			local arrRelevance = {}
			table.insert(arrRelevance, card)

			for i, v in ipairs(data.arrRelevance) do
				ASSERT(v.id)
				ASSERT(v.pos)
				local oRelevanceCard = self:Summon(caster, v.id, v.pos, v.data, true)
				table.insert(arrRelevance, oRelevanceCard)
			end

			for i, oSummonObj in ipairs(arrRelevance) do
				--LogDebugEx("设置关联11", oSummonObj.name)
				for j, oRelevanceCard in ipairs(arrRelevance) do
					if oSummonObj ~= oRelevanceCard then
						oSummonObj.oRelevanceCard = oSummonObj.oRelevanceCard or {}
						table.insert(oSummonObj.oRelevanceCard, oRelevanceCard)
					--LogDebugEx("设置关联", oRelevanceCard.name)
					end
				end
			end

		-- ASSERT()
		end
	end

	--- [[ 给召唤物添加生活buff加成
	local damage = caster.damage_add or 0
	local bedamage = caster.bedamage_add or 0
	-- 对敌方的伤害增加的百分比
	if damage ~= 0 then
		card.damage = card.damage or 1
		card.damage = card.damage + damage
		if card.damage < 0 then
			card.damage = 0
		end
	end

	-- 受到的伤害增加的百分比
	if bedamage ~= 0 then
		card.bedamage = card.bedamage or 1
		card.bedamage = card.bedamage + bedamage
		if card.bedamage < 0 then
			card.bedamage = 0
		end
	end
	--- 给召唤物添加生活buff加成 ]]

	return card
end

-- 召唤队友
function Team:SummonTeammate(caster, monsterID, pos, data, typ)
	--'Summon',	'10000001,1,{0,1},{progress=600}'
	LogDebugEx("Team:SummonTeammate", monsterID, pos[1], pos[2])
	-- LogTable(data)

	if not self:CanSummon(pos) then return end

	LogTable(pos, "SummonTeammate pos = ")
	self:Print()

	local card = self:AddSummonCard(pos[1], pos[2], monsterID)
	card.uid = caster.uid
	card.oSummonOwner = caster -- 设置召唤主
	card:LoadMonsterNumerical(caster.level)
	card.type = typ or caster.type
	card.bSummonTeammate = true -- 召唤出来的, 结束不要用到这个卡牌的数据

	-- 自定义的特殊数值
	if data then
		for k, v in pairs(data) do
			card[k] = v
		end
	end
	-- self.fightMgr:OnBorn(card, true)

	return card
end
-- 合体
function Team:Unite(list, monsterID, data)
	LogDebugEx("Team:Unite", monsterID)
	if not list or not list[1] then
		ASSERT()
		return
	end

	local monsterCfg = CardData[monsterID]
	if not monsterCfg then
		ASSERT(nil, "没有配置同调角色ID"..monsterID)
		return
	end

	local p = list[1]:GetPos()
	local level = list[1].level
	-- local minpos = p
	-- local coordinate = {}
	for i, v in ipairs(list) do
		self:RemoveCard(v)
		-- v.isLive = false
		-- v.isRemove = true -- 禁止复活
		-- local g = v:GetGrids()
		-- v.skillMgr:DeleteEvent() -- 注销技能事件
		-- for _, pos in ipairs(g) do
		-- 	self.map[pos[1]][pos[2]] = nil
		-- 	-- table.insert(coordinate, {pos[1], pos[2]})
		-- 	-- if (pos[1] < p[1]) or (pos[1] == p[1] and pos[2] < p[2]) then
		-- 	-- 	minpos = pos
		-- 	-- end
		-- end
	end

	-- if not self:CheckGridsEx(coordinate, monsterCfg.grids, minpos) then
	-- 	ASSERT()
	-- 	return
	-- end

	local card = self:AddUniteCard(p[1], p[2], monsterID, list, data, list[1]:GetGrids())
	ASSERT(card)
	card.sp = card.maxsp -- 加满sp
	LogDebugEx("合体oid = ", card.oid)
	-- card:LoadMonsterNumerical(level)
	return card
end

-- 移除卡牌
function Team:RemoveCard(v)
	if not v then return end
	v.isLive = false
	v.isRemove = true -- 禁止复活
	local g = v:GetGrids()
	v.skillMgr:DeleteEvent() -- 注销技能事件
	for _, pos in ipairs(g) do
		self.map[pos[1]][pos[2]] = nil
	end
end

-- 解体
function Team:Resolve(card, bnotlog)
-- *解除同调后，血量计算：									
-- 	@解除同调后主/辅角色生命 = 主、辅角色生命上限 * 同调角色生命百分比（解除同调时）
-- 	@同调角色被击败，则解除同调后，主、辅角色血量均为1

	if card.isResolve then return end -- 战斗结束, 解除合体角色, 导致解体两次, 此处禁止调用两次解体
	card.isResolve = true

	-- LogTrace()
	local percent = card.hp/card:Get("maxhp")

	local log = {api = "Resolve", id = card.oid, datas = {}}

	local list = card.parent
	card.isLive = false
	card.isRemove = true -- 禁止复活
	-- LogError("Team:Resolve")

	for i, v in ipairs(list) do
		v.isLive = true
		v.isRemove = nil -- 解除禁止复活
		for _, pos in ipairs(v:GetGrids()) do
			self.map[pos[1]][pos[2]] = v
		end
		v.hp = math.floor(v:Get("maxhp")*percent)
		if v.hp <= 0 then v.hp = 1 end -- 保底不死
		-- v.sp = 0
		table.insert(log.datas, v:GetShowData())

		LogTable(v:GetShowData(), "解体后:"..v.name)

		-- 复活需要重新注册事件
		v.skillMgr:ReviveRegisterEvent()
	end

	if bnotlog then return end -- 战斗结束调用不用记log

	-- 加解体buff
	--LogTable(g_ResolveBuffer, "g_ResolveBuffer=")
	for i, v in ipairs(list) do
		for i2,buffID in ipairs(g_ResolveBuffer) do
			--LogDebugEx("g_ResolveBuffer buffID", buffID)
			v:AddBuff(v, buffID) --解体的buff
		end
	end
	self.log:Add(log)
end

function Team:Print()
	LogDebugEx("Print teamID = ", self.teamID, self.col, self.row)
	local str = "\n"
	for j = 1, self.col do
		str = str .. "["
		for i = 1, self.row + 1 do
			local card = self:GetCard(i, j)
			if card then
				if card:IsLive() then
					str = str .. "1"
				else
					str = str .. "0"
				end
				-- LogTable(card.grids, "card["..card.id.."]=")
			else
				str = str .. "-"
			end
			str = str .. ","
		end
		str = str .. "]\n"
	end
	LogDebug(str)
end
-----------------------------------------
function Team:GetTeamID()
	return self.teamID
end

function Team:GetUID()
	return self.uid
end

function Team:GetTeam()
	return self.map
end

-- 是否可以召唤
function Team:CanSummon(pos)
	local card = self:GetCard(4, 1)
	if pos then
		card = self:GetCard(pos[1], pos[2])
	end

	if card and card:IsLive() then

		-- 机神同调
		return false
	end
	return true
end

-- 是否可以机神同调
function Team:CanSummonUnite(pos)
	local card = self:GetCard(4, 1)
	if pos then
		card = self:GetCard(pos[1], pos[2])
	end

	-- 必须有机神并且不是同调机神
	if card and card:IsLive() and (not card.isSummonUnite) then 
		-- 机神同调
		return true
	end
	return false
end

-- 存活数量
function Team:LiveCount(exclude)
	local count = 0
	for k, v in pairs(self.arrCard) do
		if v:IsLive() and v.type ~= exclude then
			count = count + 1
		end
	end
	return count
end

-- 获取所属小队成员数量
function Team:ClassCount(nClass)
	local count = 0
	for k, v in pairs(self.arrCard) do
		if v:IsLive() and v.nClass == nClass then
			count = count + 1
		end
	end
	return count
end

-- 死亡数量
function Team:DeathCount(exclude)
	local count = 0
	for k, v in pairs(self.arrCard) do
		if not v:IsLive() and v.type ~= exclude then
			count = count + 1
		end
	end
	return count
end

-- 判断是否存在buff（ID）
function Team:HasBuff(buffID, typ)

	typ = typ or 3
	local funkey = arrKeyOfGetBufferCount[typ]

	for k, v in pairs(self.arrCard) do
		if v:IsLive() and v:GetBufferCount(buffID, funkey) > 0 then
			return true
		end
	end
	return false
end

-- 判断是否存在角色
function Team:HasRole(cId)
	for i,v in ipairs(self.arrCard) do
		if v:IsLive() and v:GetID() == cId then
			return true
		end
	end	
	return false
end

-- 共用血条共同扣血
function Team:ShareHp(damage, maxhp)
	self.nShareHp = maxhp - damage
	for i,v in ipairs(self.arrCard) do
		if v.isInvincible == 2 then 
			v.hp = self.nShareHp
			-- if maxhp then
			-- 	v.maxhp = maxhp
			-- end
			LogDebugEx("ShareHp", v.name, v.hp)
		end
	end
end

function Team:GetHp()
	local teamHp = 0
	for i,v in ipairs(self.arrCard) do
		if v:IsLive() then
			teamHp = teamHp + v.hp
		end
	end
	return teamHp
end

function Team:GetMaxHp()
	local teamMaxHp = 0
	for i,v in ipairs(self.arrCard) do
		if v:IsLive() then
			teamMaxHp = teamMaxHp + v.maxhp
		end
	end
	return teamMaxHp
end
------------------------------------------
-- 检测卡牌站位(坐标包含关系)
function Team:CheckGridsEx(coordinate, gridsID, minpos)
	if not minpos then
		minpos = {0, 0}
	end

	local formation = MonsterFormation[gridsID]
	ASSERT(formation)
	-- relative 相对坐标

	local alist = {}
	for k, v in pairs(coordinate) do
		alist[v[1] .. "_" .. v[2]] = true
	end

	for i, pos in ipairs(formation.coordinate) do
		local r = minpos[1] + pos[1]
		local c = minpos[2] + pos[2]
		if not alist[r .. "_" .. c] then
			return
		end
	end
	return true
end

-- 检测卡牌站位
function Team:CheckGrids(row, col, coordinate)
	-- LogInfo("row:%s, col:%s", row, col)
	-- LogTable(coordinate, "coordinate:")
	for i, pos in ipairs(coordinate) do
		local r = row + pos[1]
		local c = col + pos[2]

		if r > self.row + 1 or c > self.col then
			LogDebug("r %s > self.row, %s or c %s > self.col %s", r, self.row, c, self.col)
			return
		end

		local card = self:GetCard(r, c)
		if card and card:IsLive() then
			--LogTable(self.map)
			--LogTable(card,"card = ")
			--LogDebug("self:GetCard return had card[%s][%s] name=%s",r,c, card.name)
			return
		end
	end
	return true
end

-- 设置卡牌站位
function Team:SetGrids(row, col, card, coordinate)
	card:SetPos(row, col)

	if coordinate then
		-- 指定站位
		for i, pos in ipairs(coordinate) do
			local r = pos[1]
			local c = pos[2]
			self.map[r][c] = card
			card:SetGrids({r, c})
		end
	elseif card.gridsID then
		-- 占多个格子
		local formation = MonsterFormation[card.gridsID]
		ASSERT(formation)
		local ret = self:CheckGrids(row, col, formation.coordinate)
		ASSERT(ret, "CheckGrids error:%s, row:%s, col:%s",self.fightMgr.groupID, row, col)
		--ASSERT(nil, "MonsterFormation==================")
		-- relative 相对坐标
		for i, pos in ipairs(formation.coordinate) do
			local r = row + pos[1]
			local c = col + pos[2]
			self.map[r][c] = card
			card:SetGrids({r, c})
		end
	else
		self.map[row][col] = card
		card:SetGrids({row, col})
	end

	for i, v in ipairs(self.arrCard) do
		if v == card then
			return
		end
	end

	table.insert(self.arrCard, card)
	self.fightMgr:AddCard(card)
end

-- 添加卡牌(从指定数据读取)
function Team:SetCard(data, typ)
	if not self.map[data.row] then
		return
	end

	local card = FightCard(self, data.cid, self:GetTeamID(), data.uid, data.data, typ)
	card.fuid = data.fuid or data.data.fuid
	-- card:LoadData(data.data, typ)
	self:SetGrids(data.row, data.col, card)
	return card
end

-- 添加卡牌(从monster配置表中读取)
function Team:AddCard(row, col, id)
	if not self.map[row] then
		return
	end
	local card = FightCard(self, id, self.teamID)
	self:SetGrids(row, col, card)
	-- 加载数值模板
	if self.fightMgr.nPlayerLevel then
		card:LoadMonsterNumerical(self.fightMgr.nPlayerLevel)
	end
	return card
end

-- 添加世界boss()
function Team:AddBoss(row, col, id)
	if not self.map[row] then
		return
	end
	local card = WorldBossCard(self, id, self.teamID)
	self:SetGrids(row, col, card)

	-- 加载数值模板
	if self.fightMgr.nBossLevel then
		card:LoadMonsterNumerical(self.fightMgr.nBossLevel)
	end
	return card
end

function Team:AddSummonCard(row, col, id)
	if not self.map[row] then
		return
	end
	local card = SummonCard(self, id, self.teamID)
	self:SetGrids(row, col, card)
	-- self.fightMgr:OnBorn(card, true)
	return card
end

function Team:AddUniteCard(row, col, id, parent, data, coordinate)
	if not self.map[row] then
		ASSERT()
		return
	end

	local mainCard = parent[1]
	local subCard = parent[2]
	local carddata = {} --计算合体后属性
	-- @同调角色属性 = 主角色属性 + N% * 辅角色属性 【N%配置项】
	-- 	属性计算：生命 maxhp 、攻击 attack 、防御 defense
	carddata.maxhp   = math.floor(mainCard:Get("maxhp") + subCard:Get("maxhp") * g_UnitePercent)
	carddata.attack  = mainCard:Get("attack") + subCard:Get("attack") * g_UnitePercent
	carddata.defense = mainCard:Get("defense") + subCard:Get("defense") * g_UnitePercent

	-- @【继承属性】				
	-- 	主角色通用属性继承：机动 speed 、暴击 crit_rate 、 暴伤 crit 、抵抗 resist 、命中 hit	 		
	carddata.speed     = mainCard:Get("speed")
	carddata.crit_rate = mainCard:Get("crit_rate")
	carddata.crit      = mainCard:Get("crit")
	carddata.resist    = mainCard:Get("resist")
	carddata.hit       = mainCard:Get("hit")
	carddata.level     = mainCard:Get("level")
	carddata.cuid      = mainCard:Get("cuid")
	carddata.damage    = mainCard:Get("damage")

	-- @【芯片套装】				
	-- 	继承主角色芯片触发的套装效果
	-- 技能做法同变身一样处理

	if data then
		for k,v in pairs(data) do
			carddata[k] = v
		end
	end

	local cfgNewCardData = CardData[id] --合体角色的配置
	ASSERT(cfgNewCardData, "没有合体卡牌配置 id = ".. id)
	local skillMgr = mainCard.skillMgr
	-- 123技能,天赋(等级继承)/特殊技能不继承(读卡牌配置)/其他技能完全继承
	local tUniteSkills = {} 
	local tmpSkills = {}
	for i,v in ipairs(skillMgr.skills) do
		LogDebugEx("原来技能", i, v.id, v.upgrade_type, v.main_type)
		if v.type ~= SkillType.Summon and v.type ~= SkillType.Unite
			and v.type ~= SkillType.Transform then -- 排除特殊技能
			
			if (v.upgrade_type and v.upgrade_type >= CardSkillUpType.A and v.upgrade_type <= CardSkillUpType.OverLoad) then
				-- 需要修改等级(123技能)
				if tmpSkills[v.upgrade_type] then
					ASSERT(nil, v.upgrade_type.."技能类型重复"..tmpSkills[v.upgrade_type].id.."&"..v.id)
				end
				tmpSkills[v.upgrade_type] = v
			elseif v.main_type == SkillMainType.CardTalent then 
				-- 需要修改等级(主天赋)
				if tmpSkills[5] then
					ASSERT(nil, "主天赋重复"..tmpSkills[5].id.."&"..v.id)
				end
				tmpSkills[5] = v
			else
				-- 其他技能完全继承
				table.insert(tUniteSkills, v.id)
			end
		end
	end
	-- LogTable(tmpSkills)
	for i,skillID in ipairs(cfgNewCardData.jcSkills) do
		-- LogDebugEx("-------", skillID)
		local cfgSkill = skill[skillID]
		ASSERT(cfgSkill, "找不到变身技能配置 id = "..skillID)
		-- LogTable(cfgSkill)
		local sold = tmpSkills[cfgSkill.upgrade_type]
		local flag = true
		if sold then
			local newSkillID = math.floor(skillID/10)*10 + sold.lv
			if skill[newSkillID] then
				table.insert(tUniteSkills, newSkillID)
				flag = false
			end
		end

		if flag then
			table.insert(tUniteSkills, skillID)
		end
	end

	for i,skillID in ipairs(cfgNewCardData.tfSkills) do
		local cfgSkill = skill[skillID]
		ASSERT(cfgSkill, "找不到变身技能配置 id = "..skillID)
		local sold = tmpSkills[5]
		local flag = true
		if sold then
			local newSkillID = math.floor(skillID/10)*10 + sold.lv
			if skill[newSkillID] then
				table.insert(tUniteSkills, newSkillID)
				flag = false
			end
		end
		if flag then
			table.insert(tUniteSkills, skillID)
		end
	end

	for i,skillID in ipairs(cfgNewCardData.tcSkills or {}) do
		 table.insert(tUniteSkills, skillID)
	end

	LogTable(tUniteSkills, "合体后技能")
	carddata.skills = tUniteSkills
	-- @【光环套装】				
	-- 	继承主角色光环效果(战斗前已经处理, 战斗中无须处理)
	--LogTable(data, "data=")
	LogTable(carddata, "carddata=")
	local card = UniteCard(self, id, self.teamID, mainCard.uid, carddata)
	self:SetGrids(row, col, card, coordinate)
	card.type = CardType.Unite
	card.parent = parent

	-- 同调角色血量 = 同调角色血量上限 *（主角色血量百分比+辅角色血量百分比）/2
	card.hp   = math.floor(card:Get("maxhp")*(mainCard.hp/mainCard:Get("maxhp") + subCard.hp/subCard:Get("maxhp"))/2)
	if card.hp > card:Get("maxhp") then card.hp = card:Get("maxhp") end

	LogDebugEx("card.hp", card:Get("maxhp"), card:Get("hp"))
	--LogDebugEx("card.progress", card.progress)
	-- self.fightMgr:OnBorn(card, true)


	-- 设置同调皮肤
	if mainCard.modelA then 
		card.model = mainCard.modelA
	end


	return card
end

function Team:GetCard(row, col)
	if not self.map[row] or not self.map[row][col] then
		return
	end

	return self.map[row][col]
end

function Team:DelCard(card)
	LogDebugEx("DelCard", card.name)
	LogTable(card.grids, "card.grids = ")
	-- LogTrace()
	self:Print()
	if card.bRemove then return end -- 防止重复删除
	card.bRemove = true
	
	for i, v in ipairs(card.grids) do
		self.map[v[1]][v[2]] = nil
	end
	self:Print()

	self.fightMgr:DelCard(card)

	for i, v in ipairs(self.arrCard) do
		if v == card then
			table.remove(self.arrCard, i)
			return
		end
	end
end

function Team:RandNum(len,num)
	local temp = {}
	for i=1,len do
		table.insert(temp, i)
	end

	local res = {}
	for i=1,num do
		local r = self.fightMgr.rand:Rand(#temp)+1
		table.insert(res, temp[r])
		table.remove(temp, r)
	end	
	return res
end

function Team:GetRandCard(num)
	num = num or 1

	if num >= #self.arrCard then return self.arrCard end
	local res = Team:RandNum(#self.arrCard,num)
	local ret = {}
	for i,v in ipairs(res) do
		table.insert(ret, self.arrCard[v])
	end
	
	return ret
end


----------event------------
function Team:OnTimer(tm)
end


--战斗数据恢复team
TeamTest = oo.class(Team)
function TeamTest:LoadData(data, typ, tCommanderSkill)
	self.nCardCount = #data -- 进战斗时的卡牌数量
	for k, v in ipairs(data) do
		local card = self:SetCard(v, typ)
		if card then card.nIndex = k end
	end

	-- 指挥官技能
	if tCommanderSkill then
		local card = FightCardTest(self, 10000, self:GetTeamID(), self.uid, {skills = tCommanderSkill, bIsCommander = true}, typ)
		card.oid = self.teamID
		self.oCommander = card
	end
end

function TeamTest:LoadConfig(id, stage, hpinfo)
	LogTable(hpinfo, "Team:LoadConfig:hpinfo")
	-- LogTrace()
	-- LogDebugEx("Team:LoadConfig", id, stage)
	self.id = id
	local config = MonsterGroup[self.id]
	if not config then
		ASSERT(false, "Team:LoadConfig not find config in MonsterGroup id:" .. self.id)
	end

	-- DT(config, "Team:LoadConfig")
	local stageconfig = config.stage[stage]
	if not stageconfig then
		ASSERT(false, "Team:LoadConfig not find config in MonsterGroup id:" .. self.id .. " stage:" .. stage)
	end

	self.stage = stage
	self.formationID = stageconfig.formation
	self.monsters = stageconfig.monsters

	local formation = MonsterFormation[self.formationID]
	if not formation then
		ASSERT(false, "Team:LoadConfig not find config in MonsterFormation formationID: " .. self.formationID)
	end

	self:InitMap(formation.size[1], formation.size[2])

	if hpinfo then
		for i, pos in ipairs(formation.coordinate) do
			local monsterID = self.monsters[i]
			if hpinfo[i] and hpinfo[i].hp and hpinfo[i].hp > 0 and monsterID and monsterID ~= 0 then
				local card = self:AddCard(pos[1], pos[2], monsterID)
				-- LogTable(hpinfo[i], "direct_hpinfo[i]==============");
				card.hp = hpinfo[i].hp
				if hpinfo[i].sp then
					card.sp = hpinfo[i].sp
				end
				card.configIndex = i
			end
		end

	else
		for i, pos in ipairs(formation.coordinate) do
			local monsterID = self.monsters[i]
			if monsterID and monsterID ~= 0 then
				local card = self:AddCard(pos[1], pos[2], monsterID)
				card.configIndex = i
			end
		end
	end
end

-- 添加卡牌(从指定数据读取)
function TeamTest:SetCard(data, typ)
	if not self.map[data.row] then
		return
	end

	local card = FightCardTest(self, data.cid, self:GetTeamID(), data.uid, data.data, typ)
	card.fuid = data.fuid or data.data.fuid
	-- card:LoadData(data.data, typ)
	self:SetGrids(data.row, data.col, card)
	return card
end

-- 添加卡牌(从monster配置表中读取)
function TeamTest:AddCard(row, col, id)
	if not self.map[row] then
		return
	end
	local card = FightCardTest(self, id, self.teamID)
	self:SetGrids(row, col, card)
	-- 加载数值模板
	if self.fightMgr.nPlayerLevel then
		card:LoadMonsterNumerical(self.fightMgr.nPlayerLevel)
	end
	return card
end