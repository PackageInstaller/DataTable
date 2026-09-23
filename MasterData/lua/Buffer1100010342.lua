-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010342 = oo.class(BuffBase)
function Buffer1100010342:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1100010342:OnBefourHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 8754
	local c150 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"defense")
	-- 8227
	if SkillJudger:IsCasterMech(self, self.caster, target, false,1) then
	else
		return
	end
	-- 1100010342
	self:LimitDamage(BufferEffect[1100010342], self.caster, self.caster, nil, 0.3,(c150*0.004))
end
