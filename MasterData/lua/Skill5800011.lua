-- 世界boss词条buff7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800011 = oo.class(SkillBase)
function Skill5800011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5800011:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337103
	self:AddBuff(SkillEffect[337103], caster, self.card, data, 337103)
end
-- 特殊入场时(复活，召唤，合体)
function Skill5800011:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337103
	self:AddBuff(SkillEffect[337103], caster, self.card, data, 337103)
end
-- 攻击结束
function Skill5800011:OnAttackOver(caster, target, data)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 4305007
	self:AddBuff(SkillEffect[4305007], caster, self.card, data, 4305007)
end
