-- 灭刃阵营角色使用普攻后，暴击伤害3%，最多100层，
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060012 = oo.class(SkillBase)
function Skill1100060012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100060012:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060014
	self:OwnerAddBuffCount(SkillEffect[1100060014], caster, self.card, data, 1100060014,1,100)
end
