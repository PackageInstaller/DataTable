-- 麻痹免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9009 = oo.class(BuffBase)
function Buffer9009:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9009:OnRoundBegin(caster, target)
	-- 6118
	self:ImmuneBuffID(BufferEffect[6118], self.caster, target or self.owner, nil,3009)
end
