-- 不屈意志
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer339402 = oo.class(BuffBase)
function Buffer339402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer339402:OnRoundBegin(caster, target)
	-- 6109
	self:ImmuneDeath(BufferEffect[6109], self.caster, target or self.owner, nil,nil)
end
