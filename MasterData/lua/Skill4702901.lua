-- 英灵庇护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702901 = oo.class(SkillBase)
function Skill4702901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702901:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8837
	if SkillJudger:Greater(self, caster, target, true,count21,count20*0.05) then
	else
		return
	end
	-- 8637
	local count637 = SkillApi:SkillLevel(self, caster, target,3,3279)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702904
	self:OwnerAddBuffCount(SkillEffect[4702904], caster, self.card, data, 4702804,1,3+math.floor((count637+1)/2))
end
-- 入场时
function Skill4702901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702901
	self:AddBuff(SkillEffect[4702901], caster, self.card, data, 4702801)
end
-- 行动结束
function Skill4702901:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4702911
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[4702911], caster, target, data, 4,0.30)
	end
end
