-- 同步治愈（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500801302 = oo.class(SkillBase)
function Skill500801302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500801302:DoSkill(caster, target, data)
	-- 500801302
	self.order = self.order + 1
	self:Cure(SkillEffect[500801302], caster, target, data, 1,0.21)
	-- 500801306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[500801306], caster, target, data, 6103,2)
	-- 500800312
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[500800312], caster, target, data, 2,1)
end
