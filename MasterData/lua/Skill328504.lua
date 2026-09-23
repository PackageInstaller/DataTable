-- 托尔天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328504 = oo.class(SkillBase)
function Skill328504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill328504:OnActionBegin(caster, target, data)
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
	-- 328504
	self:AddBuff(SkillEffect[328504], caster, self.card, data, 328504)
end
