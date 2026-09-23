-- 拦截爆弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702600201 = oo.class(SkillBase)
function Skill702600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702600201:DoSkill(caster, target, data)
	-- 702600201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702600201], caster, self.card, data, 702600201,3)
	-- 702600211
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[702600211], caster, self.card, data, 702600204,1,10)
end
