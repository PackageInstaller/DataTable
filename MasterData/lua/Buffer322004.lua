-- 命中提升（臨時）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer322004 = oo.class(BuffBase)
function Buffer322004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer322004:OnCreate(caster, target)
	-- 322004
	self:AddAttr(BufferEffect[322004], self.caster, target or self.owner, nil,"hit",-0.4)
end
-- 回合结束时
function Buffer322004:OnRoundOver(caster, target)
	-- 320506
	self:DelBufferTypeForce(BufferEffect[320506], self.caster, self.card, nil, 320501)
end
