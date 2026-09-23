-- 抵抗減少（臨時）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320402 = oo.class(BuffBase)
function Buffer320402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320402:OnCreate(caster, target)
	-- 320402
	self:AddAttr(BufferEffect[320402], self.caster, target or self.owner, nil,"resist",-0.2)
end
-- 回合结束时
function Buffer320402:OnRoundOver(caster, target)
	-- 320406
	self:DelBufferTypeForce(BufferEffect[320406], self.caster, self.card, nil, 320401)
end
