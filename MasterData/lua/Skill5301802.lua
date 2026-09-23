-- 刃齿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5301802 = oo.class(SkillBase)
function Skill5301802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5301802:OnBefourHurt(caster, target, data)
	-- 5301814
	self:tFunc_5301814_5301802(caster, target, data)
	self:tFunc_5301814_5301812(caster, target, data)
end
-- 回合结束时
function Skill5301802:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8760
	local count760 = SkillApi:GetCount(self, caster, target,3,5301804)
	-- 8761
	local count761 = SkillApi:GetCount(self, caster, target,3,5301803)
	-- 5301804
	if SkillJudger:Greater(self, caster, target, true,count761,0) then
	else
		return
	end
	-- 5301803
	if SkillJudger:Greater(self, caster, target, true,count760,1) then
		-- 8763
		local count763 = SkillApi:SkillLevel(self, caster, target,3,3018003)
		-- 5301805
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[5301805], caster, target, data, 301800300+count763)
		end
		-- 5301806
		self:AddBuffCount(SkillEffect[5301806], caster, self.card, data, 5301803,-1,3)
		-- 5301807
		self:AddBuffCount(SkillEffect[5301807], caster, self.card, data, 5301804,-2,3)
	else
		-- 8762
		local count762 = SkillApi:SkillLevel(self, caster, target,3,3018001)
		-- 5301808
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[5301808], caster, target, data, 301800100+count762)
		end
		-- 5301809
		self:AddBuffCount(SkillEffect[5301809], caster, self.card, data, 5301803,-1,3)
		-- 5301810
		self:AddBuffCount(SkillEffect[5301810], caster, self.card, data, 5301804,1,3)
	end
end
function Skill5301802:tFunc_5301814_5301812(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8765
	local count765 = SkillApi:GetCount(self, caster, target,3,5301802)
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 8766
	local count766 = SkillApi:SkillLevel(self, caster, target,3,43018)
	-- 5301812
	self:AddTempAttr(SkillEffect[5301812], caster, self.card, data, "damage",0.05*(count766+1)*math.floor(count765/30))
end
function Skill5301802:tFunc_5301814_5301802(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 5301802
	self:AddBuffCount(SkillEffect[5301802], caster, self.card, data, 5301802,1,30)
end
