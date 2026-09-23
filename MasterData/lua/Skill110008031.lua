-- 第6章小怪被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008031 = oo.class(SkillBase)
function Skill110008031:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束2
function Skill110008031:OnAttackOver2(caster, target, data)
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
	-- 110008031
	self:AddBuff(SkillEffect[110008031], caster, caster, data, 5006)
end
