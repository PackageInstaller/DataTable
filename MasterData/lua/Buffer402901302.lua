-- 刪除免疫效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402901302 = oo.class(BuffBase)
function Buffer402901302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer402901302:OnRoundBegin(caster, target)
	-- 402901302
	self:DelBufferTypeForce(BufferEffect[402901302], self.caster, self.card, nil, 402901301,2)
end
