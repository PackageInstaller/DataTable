-- 阵地扩成（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102301304 = oo.class(SkillBase)
function Skill102301304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102301304:DoSkill(caster, target, data)
	-- 102300206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300206], caster, target, data, 2906)
end
