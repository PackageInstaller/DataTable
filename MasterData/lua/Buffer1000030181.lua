-- 猛襲：持續進攻
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030181 = oo.class(BuffBase)
function Buffer1000030181:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030181:OnCreate(caster, target)
	-- 1000030181
	self:AddAttr(BufferEffect[1000030181], self.caster, self.card, nil, "crit_rate",0.05*self.nCount)
end
