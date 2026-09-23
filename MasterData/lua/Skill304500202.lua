-- 利兹2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304500202 = oo.class(SkillBase)
function Skill304500202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304500202:DoSkill(caster, target, data)
	-- 304500202
	self.order = self.order + 1
	self:AddNp(SkillEffect[304500202], caster, target, data, 10)
	-- 304500207
	self.order = self.order + 1
	self:AddBuff(SkillEffect[304500207], caster, target, data, 304500202)
end
