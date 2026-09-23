-- 奏响战歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200304 = oo.class(SkillBase)
function Skill200200304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200304:DoSkill(caster, target, data)
	-- 200200304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200304], caster, target, data, 200200304)
	-- 200200314
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200314], caster, target, data, 200200314)
end
