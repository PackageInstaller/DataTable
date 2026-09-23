-- 乘风急行（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701101303 = oo.class(SkillBase)
function Skill701101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701101303:DoSkill(caster, target, data)
	-- 701100305
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100305], caster, target, data, 350)
	-- 701100315
	self.order = self.order + 1
	self:Cure(SkillEffect[701100315], caster, target, data, 1,0.16)
end
