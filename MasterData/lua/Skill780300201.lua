-- 绯瞳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780300201 = oo.class(SkillBase)
function Skill780300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780300201:DoSkill(caster, target, data)
	-- 780300201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[780300201], caster, self.card, data, 780300201)
end
