-- 世界boss词条buff11
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800019 = oo.class(SkillBase)
function Skill5800019:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800019:OnBefourHurt(caster, target, data)
	-- 5800119
	self:tFunc_5800119_5800120(caster, target, data)
	self:tFunc_5800119_5800121(caster, target, data)
end
-- 入场时
function Skill5800019:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800118
	self:AddBuff(SkillEffect[5800118], caster, self.card, data, 5800018)
end
function Skill5800019:tFunc_5800119_5800121(caster, target, data)
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
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 5800121
	self:AddBuffCount(SkillEffect[5800121], caster, self.card, data, 5800019,1,50)
end
function Skill5800019:tFunc_5800119_5800120(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 5800120
	self:AddBuffCount(SkillEffect[5800120], caster, self.card, data, 5800019,1,50)
end
