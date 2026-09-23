-- 人马机神血量转换阶段
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913100803 = oo.class(SkillBase)
function Skill913100803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913100803:DoSkill(caster, target, data)
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
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110810
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913110810], caster, self.card, data, 913110810)
	-- 913110808
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913110808], caster, target, data, 913110808)
end
-- 入场时
function Skill913100803:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110809
	self:AddBuff(SkillEffect[913110809], caster, self.card, data, 913110809)
end
