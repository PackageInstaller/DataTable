-- 控制免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900904 = oo.class(SkillBase)
function Skill4900904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900904:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305804
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[305804], caster, self.card, data, 6106,1)
	end
end
