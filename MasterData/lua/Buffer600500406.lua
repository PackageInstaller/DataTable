-- 封印
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600500406 = oo.class(BuffBase)
function Buffer600500406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer600500406:OnDeath(caster, target)
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
	-- 1100070085
	self:PassiveRevive(BufferEffect[1100070085], self.caster, self.card, nil, 8,1,{progress=1000})
end
