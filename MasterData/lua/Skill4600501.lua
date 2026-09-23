-- 储能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600501 = oo.class(SkillBase)
function Skill4600501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4600501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600501
	self:OwnerAddBuffCount(SkillEffect[4600501], caster, self.card, data, 4600501,5,5)
end
-- 回合结束时
function Skill4600501:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4600511
	self:OwnerAddBuffCount(SkillEffect[4600511], caster, self.card, data, 4600501,-1,5)
	-- 4600504
	self:OwnerAddBuffCount(SkillEffect[4600504], caster, self.card, data, 4600511,1,5)
end
