-- 阵地扩成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102300303 = oo.class(SkillBase)
function Skill102300303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102300303:DoSkill(caster, target, data)
	-- 102300203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300203], caster, target, data, 2903)
end
