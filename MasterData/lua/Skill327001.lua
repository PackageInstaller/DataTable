-- 造物吸能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327001 = oo.class(SkillBase)
function Skill327001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill327001:OnActionOver(caster, target, data)
	-- 8257
	if SkillJudger:HasSummoner(self, caster, self.card, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 327001
	if self:Rand(2000) then
		self:AddSp(SkillEffect[327001], caster, self.card.oSummoner, data, 20)
	end
end
