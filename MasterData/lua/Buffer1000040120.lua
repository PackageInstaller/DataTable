-- 造成能量傷害時，有概率額外附加真實傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040120 = oo.class(BuffBase)
function Buffer1000040120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000040120:OnBefourHurt(caster, target)
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
	-- 1000040121
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1000040101) then
	else
		return
	end
	-- 1000040120
	self:AddAttrPercent(BufferEffect[1000040120], self.caster, self.card, nil, "damage",0.6)
end
