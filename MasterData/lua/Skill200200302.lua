-- 奏响战歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200302 = oo.class(SkillBase)
function Skill200200302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200302:DoSkill(caster, target, data)
	-- 200200302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200302], caster, target, data, 200200302)
	-- 200200312
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200312], caster, target, data, 200200312)
end
