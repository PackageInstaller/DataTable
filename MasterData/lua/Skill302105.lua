-- 天赋效果302105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302105 = oo.class(SkillBase)
function Skill302105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill302105:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302105
	if self:Rand(6000) then
		self:AddSp(SkillEffect[302105], caster, self.card, data, 20)
	end
end
