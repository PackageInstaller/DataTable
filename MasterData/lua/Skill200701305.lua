-- 施洗（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200701305 = oo.class(SkillBase)
function Skill200701305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200701305:DoSkill(caster, target, data)
	-- 200700326
	self.order = self.order + 1
	self:Cure(SkillEffect[200700326], caster, target, data, 1,0.4)
	-- 200700314
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200700314], caster, self.card, data, 200700314)
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
	-- 200700308
	self.order = self.order + 1
	self:AddEnergy(SkillEffect[200700308], caster, self.card, data, count49*0.50,1)
end
-- 行动结束
function Skill200701305:OnActionOver(caster, target, data)
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
	self:AddBuff(SkillEffect[200700401], caster, self.card, data, 200700102)
end
