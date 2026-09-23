-- 天赋效果302101
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302101 = oo.class(SkillBase)
function Skill302101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill302101:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302101
	if self:Rand(2000) then
		self:AddSp(SkillEffect[302101], caster, self.card, data, 20)
	end
end
