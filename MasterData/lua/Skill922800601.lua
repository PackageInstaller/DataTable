-- 原初的巨人
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922800601 = oo.class(SkillBase)
function Skill922800601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill922800601:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 入场时
function Skill922800601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922800101
	self:AddBuff(SkillEffect[922800101], caster, self.card, data, 922800101)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922800201
	self:AddBuff(SkillEffect[922800201], caster, self.card, data, 922800201)
end
-- 行动结束
function Skill922800601:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8642
	local count642 = SkillApi:BuffCount(self, caster, target,3,4,922800301)
	-- 8843
	if SkillJudger:Greater(self, caster, target, true,count642,0) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 922800601
	self:AddBuff(SkillEffect[922800601], caster, caster, data, 302302)
	-- 922800602
	self:AddHp(SkillEffect[922800602], caster, caster, data, math.floor(-count616*0.5))
	-- 922800603
	self:ShowTips(SkillEffect[922800603], caster, self.card, data, 2,"反伤",true,922800603)
end
