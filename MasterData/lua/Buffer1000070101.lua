-- 當自身擁有【癲狂】效果時，攻擊時可以提升50%暴擊傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070101 = oo.class(BuffBase)
function Buffer1000070101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000070101:OnAfterHurt(caster, target)
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
	-- 1000070052
	if SkillJudger:HasBuff(self, self.caster, self.card, true,1,1000070051) then
	else
		return
	end
	-- 8248
	if SkillJudger:IsBeatAgain(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070101
	self:AddAttr(BufferEffect[1000070101], self.caster, self.card, nil, "crit",0.08)
end
