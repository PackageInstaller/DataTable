-- 行动妨碍
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010206 = oo.class(SkillBase)
function Skill1010206:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010206:DoSkill(caster, target, data)
	-- 1010206
	self.order = self.order + 1
	self:AddProgress(SkillEffect[1010206], caster, target, data, -450)
end
