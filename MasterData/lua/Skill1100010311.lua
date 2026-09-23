-- 每次暴击后40%概率使自身暴击伤害+10%（可叠加10层，持续到战斗结束）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010311 = oo.class(SkillBase)
function Skill1100010311:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010311:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 1100010311
	self:OwnerAddBuffCount(SkillEffect[1100010311], caster, self.card, data, 1100010311,1,10)
end
