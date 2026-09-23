-- 施洗
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200700301 = oo.class(SkillBase)
function Skill200700301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200700301:DoSkill(caster, target, data)
	-- 200700321
	self.order = self.order + 1
	self:Cure(SkillEffect[200700321], caster, target, data, 1,0.2)
	-- 200700311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200700311], caster, self.card, data, 200700311)
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
	-- 200700401
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200700401], caster, self.card, data, 200700102)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 200700301
	self.order = self.order + 1
	self:AddEnergy(SkillEffect[200700301], caster, self.card, data, count49*0.2,1)
end
