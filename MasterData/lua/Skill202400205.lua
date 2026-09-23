-- 和音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202400205 = oo.class(SkillBase)
function Skill202400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202400205:DoSkill(caster, target, data)
	-- 202400205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400205], caster, target, data, 202400203)
	-- 202400213
	self.order = self.order + 1
	self:AddNp(SkillEffect[202400213], caster, target, data, 4)
end
