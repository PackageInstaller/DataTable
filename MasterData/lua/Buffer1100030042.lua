-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100030042 = oo.class(BuffBase)
function Buffer1100030042:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100030042:OnCreate(caster, target)
	-- 1100030042
	self:AddAttrPercent(BufferEffect[1100030042], self.caster, target or self.owner, nil,"attack",0.04*self.nCount)
	-- 1100030045
	self:AddAttrPercent(BufferEffect[1100030045], self.caster, target or self.owner, nil,"defense",0.04*self.nCount)
end
