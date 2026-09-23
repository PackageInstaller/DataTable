-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010381 = oo.class(BuffBase)
function Buffer1100010381:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010381:OnCreate(caster, target)
	-- 1100010382
	self:AddAttr(BufferEffect[1100010382], self.caster, target or self.owner, nil,"crit",0.25*self.nCount)
	-- 1100010383
	self:AddAttr(BufferEffect[1100010383], self.caster, target or self.owner, nil,"attack",-200*self.nCount)
end
