-- 疾风迅剑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315402 = oo.class(SkillBase)
function Skill315402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 切换周目
function Skill315402:OnChangeStage(caster, target, data)
	-- 315402
	self:AddProgress(SkillEffect[315402], caster, self.card, data, 160)
end
