-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6123 = oo.class(BuffBase)
function Buffer6123:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6123:OnRoundBegin(caster, target)
	self:ImmuneBuffID(BufferEffect[6121], self.caster, self.owner, nil,3003)
end
