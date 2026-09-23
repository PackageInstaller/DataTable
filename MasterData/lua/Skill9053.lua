-- 能量填充
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9053 = oo.class(SkillBase)
function Skill9053:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill9053:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9053
	self:AddSp(SkillEffect[9053], caster, self.card, data, 100)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9054
	self:AddNp(SkillEffect[9054], caster, self.card, data, 100)
end
