-- 药丸自显流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4102603 = oo.class(SkillBase)
function Skill4102603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill4102603:OnAddBuff(caster, target, data, buffer)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4102602
	self:ReflectBuff(SkillEffect[4102602], caster, target, data, 1,3,6000,1)
end
-- 攻击结束
function Skill4102603:OnAttackOver(caster, target, data)
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
	-- 4102622
	self:HitAddBuff(SkillEffect[4102622], caster, target, data, 3500,1002,2)
end
-- 入场时
function Skill4102603:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4102612
	self:AddBuff(SkillEffect[4102612], caster, self.card, data, 6104,2)
end
