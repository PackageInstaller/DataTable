-- 怒潮潜抑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922800701 = oo.class(SkillBase)
function Skill922800701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill922800701:OnActionOver(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24702
	self:AddBuff(SkillEffect[24702], caster, self.card, data, 24702)
end
