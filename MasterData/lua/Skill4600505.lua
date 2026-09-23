-- 储能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600505 = oo.class(SkillBase)
function Skill4600505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4600505:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600503
	self:OwnerAddBuffCount(SkillEffect[4600503], caster, self.card, data, 4600503,5,5)
end
-- 回合结束时
function Skill4600505:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600515
	self:OwnerAddBuffCount(SkillEffect[4600515], caster, self.card, data, 4600503,-1,5)
	-- 4600506
	self:OwnerAddBuffCount(SkillEffect[4600506], caster, self.card, data, 4600513,1,5)
end
