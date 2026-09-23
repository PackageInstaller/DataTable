-- 冕羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300605 = oo.class(SkillBase)
function Skill4300605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4300605:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4300605
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4300605], caster, target, data, 4300605)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4300605:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4300627
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4300627], caster, target, data, 4300605)
	end
end
-- 回合结束时
function Skill4300605:OnRoundOver(caster, target, data)
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 8758
	local count758 = SkillApi:BuffCount(self, caster, target,3,4,4300606)
	-- 4300622
	if SkillJudger:Greater(self, caster, target, flase,count758,0) then
	else
		return
	end
	-- 4300610
	self:OwnerAddBuff(SkillEffect[4300610], caster, self.card, data, 4300610)
end
-- 治疗时
function Skill4300605:OnCure(caster, target, data)
	-- 8140
	if SkillJudger:OwnerPercentHp(self, caster, target, true,1) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8758
	local count758 = SkillApi:BuffCount(self, caster, target,3,4,4300606)
	-- 4300621
	if SkillJudger:Greater(self, caster, target, true,count758,0) then
	else
		return
	end
	-- 8759
	local count759 = SkillApi:BuffCount(self, caster, target,3,4,4300621)
	-- 4300628
	if SkillJudger:Greater(self, caster, target, false,count759,0) then
	else
		return
	end
	-- 4300615
	self:AddBuffCount(SkillEffect[4300615], caster, self.card, data, 4300615,1,5)
	-- 4300620
	self:AddBuff(SkillEffect[4300620], caster, self.card, data, 4300621)
end
