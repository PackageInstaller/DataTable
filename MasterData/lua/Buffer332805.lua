-- 獲取攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332805 = oo.class(BuffBase)
function Buffer332805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332805:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 332816
	local attack01 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"attack01")
	-- 332805
	self:AddTempAttr(BufferEffect[332805], self.caster, self.card, nil, "attack",math.min(attack01,5000))
end
-- 行动结束
function Buffer332805:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 332817
	self:DelValue(BufferEffect[332817], self.caster, self.card, nil, "attack01")
end
-- 攻击开始
function Buffer332805:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8493
	local c93 = SkillApi:GetAttr(self, self.caster, target or self.owner,2,"maxhp")
	-- 332815
	self:AddValue(BufferEffect[332815], self.caster, self.card, nil, "attack01",c93*0.05)
end
