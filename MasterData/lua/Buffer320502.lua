-- 抵抗減少（臨時）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320502 = oo.class(BuffBase)
function Buffer320502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320502:OnCreate(caster, target)
	-- 320502
	self:AddAttr(BufferEffect[320502], self.caster, target or self.owner, nil,"resist",-0.15)
end
-- 回合结束时
function Buffer320502:OnRoundOver(caster, target)
	-- 320506
	self:DelBufferTypeForce(BufferEffect[320506], self.caster, self.card, nil, 320501)
end
