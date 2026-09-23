-- 摩羯座技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600101 = oo.class(SkillBase)
function Skill983600101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983600101:DoSkill(caster, target, data)
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
	-- 983600101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983600101], caster, target, data, 4806)
end
-- 行动结束
function Skill983600101:OnActionOver(caster, target, data)
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
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8904
	if SkillJudger:LessEqual(self, caster, target, true,count76,3) then
	else
		return
	end
	-- 983600211
	self:CallOwnerSkill(SkillEffect[983600211], caster, self.card, data, 983600201)
end
