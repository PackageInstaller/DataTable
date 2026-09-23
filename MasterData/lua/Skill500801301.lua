-- 同步治愈（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500801301 = oo.class(SkillBase)
function Skill500801301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500801301:DoSkill(caster, target, data)
	-- 500801301
	self.order = self.order + 1
	self:Cure(SkillEffect[500801301], caster, target, data, 1,0.2)
	-- 500801306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[500801306], caster, target, data, 6103,2)
	-- 500800311
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[500800311], caster, target, data, 2,1)
end
