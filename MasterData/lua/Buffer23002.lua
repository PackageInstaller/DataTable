-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23002 = oo.class(BuffBase)
function Buffer23002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer23002:OnActionOver2(caster, target)
	-- 23002
	self:AddBuff(BufferEffect[23002], self.caster, self.card, nil, 5004,1)
	-- 23012
	self:AddBuff(BufferEffect[23012], self.caster, self.card, nil, 5202,1)
	-- 23021
	self:DelBufferTypeForce(BufferEffect[23021], self.caster, self.card, nil, 23001,5)
end
