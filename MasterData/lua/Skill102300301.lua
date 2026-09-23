-- 阵地扩成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102300301 = oo.class(SkillBase)
function Skill102300301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102300301:DoSkill(caster, target, data)
	-- 102300201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300201], caster, target, data, 2901)
end
