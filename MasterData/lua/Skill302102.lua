-- 天赋效果302102
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302102 = oo.class(SkillBase)
function Skill302102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill302102:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 302102
	if self:Rand(3000) then
		self:AddSp(SkillEffect[302102], caster, self.card, data, 20)
	end
end
