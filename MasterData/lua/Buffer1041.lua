-- 傷害記憶體（嵐攻擊）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1041 = oo.class(BuffBase)
function Buffer1041:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer1041:OnActionBegin(caster, target)
	-- 8413
	local c13 = SkillApi:LiveCount(self, self.caster, target or self.owner,2)
	-- 1059
	self:SetValue(BufferEffect[1059], self.caster, self.card, nil, "Live4006",c13)
end
-- 行动结束
function Buffer1041:OnActionOver(caster, target)
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
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 1051
	self:AddValue(BufferEffect[1051], self.caster, self.card, nil, "dmg4006",c68)
end
-- 回合结束时
function Buffer1041:OnRoundOver(caster, target)
	-- 1053
	self:DelValue(BufferEffect[1053], self.caster, self.creater, nil, "dmg4006")
end
