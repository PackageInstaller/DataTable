-- 赤夕技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942001304 = oo.class(SkillBase)
function Skill942001304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942001304:DoSkill(caster, target, data)
	-- 704001304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704001304], caster, target, data, 704001303)
	-- 704001312
	self.order = self.order + 1
	self:Cure(SkillEffect[704001312], caster, target, data, 1,0.25)
end
