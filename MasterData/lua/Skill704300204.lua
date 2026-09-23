-- 岁稔技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704300204 = oo.class(SkillBase)
function Skill704300204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704300204:DoSkill(caster, target, data)
	-- 704300204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704300204], caster, target, data, 704300204)
end
