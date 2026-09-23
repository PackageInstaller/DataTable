-- 山脈機制buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101403 = oo.class(BuffBase)
function Buffer980101403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer980101403:OnRoundBegin(caster, target)
	-- 6112
	self:ImmuneBuffID(BufferEffect[6112], self.caster, target or self.owner, nil,3003)
end
