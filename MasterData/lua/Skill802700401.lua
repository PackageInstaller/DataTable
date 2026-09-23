-- 科迪之力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802700401 = oo.class(SkillBase)
function Skill802700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802700401:DoSkill(caster, target, data)
	-- 802700401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[802700401], caster, target, data, 4802701)
end
