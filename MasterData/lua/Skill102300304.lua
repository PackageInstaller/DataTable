-- 阵地扩成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102300304 = oo.class(SkillBase)
function Skill102300304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102300304:DoSkill(caster, target, data)
	-- 102300204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300204], caster, target, data, 2904)
end
