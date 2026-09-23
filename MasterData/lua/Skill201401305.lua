-- 梦幻音律（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201401305 = oo.class(SkillBase)
function Skill201401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201401305:DoSkill(caster, target, data)
	-- 201401305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201401305], caster, target, data, 201401305)
end
