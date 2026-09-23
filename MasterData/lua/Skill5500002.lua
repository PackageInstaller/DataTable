-- 溯源探查第二期ex新增技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500002 = oo.class(SkillBase)
function Skill5500002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill5500002:OnAttackOver(caster, target, data)
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
	-- 5500002
	self:HitAddBuff(SkillEffect[5500002], caster, target, data, 5000,1003)
end
-- 行动结束
function Skill5500002:OnActionOver(caster, target, data)
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
	-- 5500003
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[5500003], caster, caster, data, 1003)
	end
end
