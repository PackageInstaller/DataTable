-- 挑釁免疫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9001 = oo.class(BuffBase)
function Buffer9001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9001:OnRoundBegin(caster, target)
	-- 6110
	self:ImmuneBuffID(BufferEffect[6110], self.caster, target or self.owner, nil,3001)
end
