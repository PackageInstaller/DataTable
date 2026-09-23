-- 天赋效果302103
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302103 = oo.class(SkillBase)
function Skill302103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill302103:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302103
	if self:Rand(4000) then
		self:AddSp(SkillEffect[302103], caster, self.card, data, 20)
	end
end
