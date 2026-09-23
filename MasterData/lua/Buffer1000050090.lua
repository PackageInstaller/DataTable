-- 當角色身上擁有強化效果時，對敵方單位造成傷害後，附加【弱化】效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050090 = oo.class(BuffBase)
function Buffer1000050090:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000050090:OnAttackOver(caster, target)
	-- 1000050022
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000050021) then
	else
		return
	end
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
	-- 1000050090
	self:AddBuff(BufferEffect[1000050090], self.caster, target or self.owner, nil,1000050091)
end
