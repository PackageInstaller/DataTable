-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23003 = oo.class(BuffBase)
function Buffer23003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer23003:OnActionOver2(caster, target)
	-- 23003
	self:AddBuff(BufferEffect[23003], self.caster, self.card, nil, 5006,1)
	-- 23013
	self:AddBuff(BufferEffect[23013], self.caster, self.card, nil, 5203,1)
	-- 23021
	self:DelBufferTypeForce(BufferEffect[23021], self.caster, self.card, nil, 23001,5)
end
