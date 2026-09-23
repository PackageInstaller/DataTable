-- 托尔天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328503 = oo.class(SkillBase)
function Skill328503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill328503:OnActionBegin(caster, target, data)
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
	-- 328503
	self:AddBuff(SkillEffect[328503], caster, self.card, data, 328503)
end
