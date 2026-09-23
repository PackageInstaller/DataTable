-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23001 = oo.class(BuffBase)
function Buffer23001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer23001:OnActionOver2(caster, target)
	-- 23001
	self:AddBuff(BufferEffect[23001], self.caster, self.card, nil, 5002,1)
	-- 23011
	self:AddBuff(BufferEffect[23011], self.caster, self.card, nil, 5201,1)
	-- 23021
	self:DelBufferTypeForce(BufferEffect[23021], self.caster, self.card, nil, 23001,5)
end
