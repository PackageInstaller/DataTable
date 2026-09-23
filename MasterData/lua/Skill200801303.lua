-- 灵风交响（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200801303 = oo.class(SkillBase)
function Skill200801303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200801303:DoSkill(caster, target, data)
	-- 200801303
	self.order = self.order + 1
	self:Cure(SkillEffect[200801303], caster, target, data, 1,0.33)
	-- 200801312
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200801312], caster, target, data, 200801312,2)
end
