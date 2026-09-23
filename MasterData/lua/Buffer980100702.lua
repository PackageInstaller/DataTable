-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100702 = oo.class(BuffBase)
function Buffer980100702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer980100702:OnActionOver2(caster, target)
	-- 980100701
	self:OwnerAddBuffCount(BufferEffect[980100701], self.caster, self.card, nil, 980100703,1,8)
	-- 980100702
	self:DelBufferTypeForce(BufferEffect[980100702], self.caster, self.card, nil, 980100702)
end
-- 回合结束时
function Buffer980100702:OnRoundOver(caster, target)
	-- 980100701
	self:OwnerAddBuffCount(BufferEffect[980100701], self.caster, self.card, nil, 980100703,1,8)
	-- 980100702
	self:DelBufferTypeForce(BufferEffect[980100702], self.caster, self.card, nil, 980100702)
end
