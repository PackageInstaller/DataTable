-- 我方全體免疫無力狀態（不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100406 = oo.class(BuffBase)
function Buffer4100406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4100406:OnRoundBegin(caster, target)
	-- 6127
	self:ImmuneBuffID(BufferEffect[6127], self.caster, target or self.owner, nil,9401)
end
