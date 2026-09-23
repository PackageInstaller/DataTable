-- 强势反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4305002 = oo.class(SkillBase)
function Skill4305002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4305002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337102
	self:AddBuff(SkillEffect[337102], caster, self.card, data, 337102)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4305002:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337102
	self:AddBuff(SkillEffect[337102], caster, self.card, data, 337102)
end
-- 攻击结束
function Skill4305002:OnAttackOver(caster, target, data)
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
	-- 4305002
	self:AddBuff(SkillEffect[4305002], caster, self.card, data, 4305002)
end
