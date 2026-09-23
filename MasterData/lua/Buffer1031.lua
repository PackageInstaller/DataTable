-- 傷害記憶體（沼波攻擊）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1031 = oo.class(BuffBase)
function Buffer1031:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1031:OnActionOver(caster, target)
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
	-- 1041
	self:AddValue(BufferEffect[1041], self.caster, self.card, nil, "dmg4022",c68)
end
-- 回合结束时
function Buffer1031:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1043
	self:DelValue(BufferEffect[1043], self.caster, self.card, nil, "dmg4022")
end
