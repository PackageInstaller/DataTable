-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5304305 = oo.class(BuffBase)
function Buffer5304305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer5304305:OnRoundBegin(caster, target)
	-- 5304310
	self:DelBufferForce(BufferEffect[5304310], self.caster, self.card, nil, 3601)
end
