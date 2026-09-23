-- 免疫提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900703 = oo.class(SkillBase)
function Skill4900703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900703:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305603
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[305603], caster, self.card, data, 4604,1)
	end
end
