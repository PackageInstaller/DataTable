-- 赤夕技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704001305 = oo.class(SkillBase)
function Skill704001305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704001305:DoSkill(caster, target, data)
	-- 704001305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704001305], caster, target, data, 704001304)
	-- 704001312
	self.order = self.order + 1
	self:Cure(SkillEffect[704001312], caster, target, data, 1,0.25)
end
