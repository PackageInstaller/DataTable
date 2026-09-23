-- 形态切换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922900602 = oo.class(SkillBase)
function Skill922900602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill922900602:DoSkill(caster, target, data)
	-- 90011
	self.order = self.order + 1
	self:Transform(SkillEffect[90011], caster, target, data, {progress=1010})
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 95001
	self.order = self.order + 1
	self:AlterBufferByGroup(SkillEffect[95001], caster, self.card, data, 1,1)
	-- 30013
	self.order = self.order + 1
	self:Cure(SkillEffect[30013], caster, self.card, data, 1,1)
	-- 4922911
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4922911], caster, self.card, data, 4922911)
end
