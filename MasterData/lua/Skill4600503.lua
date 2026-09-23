-- 储能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600503 = oo.class(SkillBase)
function Skill4600503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4600503:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600502
	self:OwnerAddBuffCount(SkillEffect[4600502], caster, self.card, data, 4600502,5,5)
end
-- 回合结束时
function Skill4600503:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600513
	self:OwnerAddBuffCount(SkillEffect[4600513], caster, self.card, data, 4600502,-1,5)
	-- 4600505
	self:OwnerAddBuffCount(SkillEffect[4600505], caster, self.card, data, 4600512,1,5)
end
