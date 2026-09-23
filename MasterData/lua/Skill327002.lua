-- 造物吸能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327002 = oo.class(SkillBase)
function Skill327002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill327002:OnActionOver(caster, target, data)
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
	-- 327002
	if self:Rand(2500) then
		self:AddSp(SkillEffect[327002], caster, self.card.oSummoner, data, 20)
	end
end
