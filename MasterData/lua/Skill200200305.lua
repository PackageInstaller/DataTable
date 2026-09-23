-- 奏响战歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200305 = oo.class(SkillBase)
function Skill200200305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200305:DoSkill(caster, target, data)
	-- 200200305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200305], caster, target, data, 200200305)
	-- 200200315
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200315], caster, target, data, 200200315)
end
