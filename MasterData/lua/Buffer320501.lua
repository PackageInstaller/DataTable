-- 抵抗減少（臨時）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320501 = oo.class(BuffBase)
function Buffer320501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320501:OnCreate(caster, target)
	-- 320501
	self:AddAttr(BufferEffect[320501], self.caster, target or self.owner, nil,"resist",-0.1)
end
-- 回合结束时
function Buffer320501:OnRoundOver(caster, target)
	-- 320506
	self:DelBufferTypeForce(BufferEffect[320506], self.caster, self.card, nil, 320501)
end
