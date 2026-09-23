-- 碎星阵营角色，角色攻击被控制的怪物时，增加10%伤害加成，10%防御，最高10层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070020 = oo.class(SkillBase)
function Skill1100070020:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100070020:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8903
	if SkillJudger:HasBuff(self, caster, target, true,2,1,1) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100070020
	self:OwnerAddBuffCount(SkillEffect[1100070020], caster, self.card, data, 1100070020,1,10)
end
