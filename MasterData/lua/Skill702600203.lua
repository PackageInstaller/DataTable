-- 拦截爆弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702600203 = oo.class(SkillBase)
function Skill702600203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702600203:DoSkill(caster, target, data)
	-- 702600203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702600203], caster, self.card, data, 702600202,3)
	-- 702600212
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[702600212], caster, self.card, data, 702600204,2,10)
end
