-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603210203 = oo.class(SkillBase)
function Skill603210203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603210203:DoSkill(caster, target, data)
	-- 603210203
	self.order = self.order + 1
	self:AddSp(SkillEffect[603210203], caster, self.card, data, 60)
	-- 603210102
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603210102], caster, self.card, data, 4603211,2,60)
	-- 603210212
	self.order = self.order + 1
	self:AlterBufferByGroup(SkillEffect[603210212], caster, self.card, data, 1,2)
end
