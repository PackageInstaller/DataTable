-- 装甲护卫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100400205 = oo.class(SkillBase)
function Skill100400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100400205:DoSkill(caster, target, data)
	-- 100400203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100400203], caster, target, data, 100400203)
	-- 100400213
	self.order = self.order + 1
	self:AddSp(SkillEffect[100400213], caster, target, data, 20)
end
