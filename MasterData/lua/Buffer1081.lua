-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1081 = oo.class(BuffBase)
function Buffer1081:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1081:OnActionOver(caster, target)
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8760
	local c760 = SkillApi:GetDamage(self, self.caster, target or self.owner,1)
	-- 1081
	self:AddValue(BufferEffect[1081], self.caster, self.card, nil, "dmg7042",c760)
end
-- 行动结束2
function Buffer1081:OnActionOver2(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8215
	if SkillJudger:IsTypeOf(self, self.caster, target, true,3) then
	else
		return
	end
	-- 1083
	self:DelValue(BufferEffect[1083], self.caster, self.creater, nil, "dmg7042")
end
