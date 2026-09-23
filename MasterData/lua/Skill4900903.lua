-- 控制免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900903 = oo.class(SkillBase)
function Skill4900903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900903:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305803
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[305803], caster, self.card, data, 6106,1)
	end
end
