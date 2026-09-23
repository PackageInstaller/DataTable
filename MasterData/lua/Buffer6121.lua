-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6121 = oo.class(BuffBase)
function Buffer6121:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6121:OnRoundBegin(caster, target)
	self:ImmuneBuffID(BufferEffect[6119], self.caster, self.owner, nil,3001)
end
