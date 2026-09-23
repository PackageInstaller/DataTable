-- 同步治愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500800305 = oo.class(SkillBase)
function Skill500800305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500800305:DoSkill(caster, target, data)
	-- 500800305
	self.order = self.order + 1
	self:Cure(SkillEffect[500800305], caster, target, data, 1,0.14)
	-- 500800315
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[500800315], caster, target, data, 2,3)
end
