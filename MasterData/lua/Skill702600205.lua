-- 拦截爆弹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702600205 = oo.class(SkillBase)
function Skill702600205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702600205:DoSkill(caster, target, data)
	-- 702600205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702600205], caster, self.card, data, 702600203,3)
	-- 702600213
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[702600213], caster, self.card, data, 702600204,3,10)
end
