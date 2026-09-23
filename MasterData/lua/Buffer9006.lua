-- 昏睡免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9006 = oo.class(BuffBase)
function Buffer9006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9006:OnRoundBegin(caster, target)
	-- 6115
	self:ImmuneBuffID(BufferEffect[6115], self.caster, target or self.owner, nil,3006)
end
