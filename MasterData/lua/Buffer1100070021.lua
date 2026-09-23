-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070021 = oo.class(BuffBase)
function Buffer1100070021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070021:OnCreate(caster, target)
	-- 1100070022
	self:AddAttr(BufferEffect[1100070022], self.caster, target or self.owner, nil,"damage",0.15*self.nCount)
	-- 1100070023
	self:AddAttrPercent(BufferEffect[1100070023], self.caster, target or self.owner, nil,"defense",0.15*self.nCount)
end
