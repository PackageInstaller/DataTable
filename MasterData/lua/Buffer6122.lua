-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6122 = oo.class(BuffBase)
function Buffer6122:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6122:OnRoundBegin(caster, target)
	self:ImmuneBuffID(BufferEffect[6120], self.caster, self.owner, nil,3002)
end
