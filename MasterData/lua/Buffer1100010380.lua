-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010380 = oo.class(BuffBase)
function Buffer1100010380:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010380:OnCreate(caster, target)
	-- 1100010380
	self:AddAttr(BufferEffect[1100010380], self.caster, target or self.owner, nil,"crit",0.1*self.nCount)
	-- 1100010381
	self:AddAttr(BufferEffect[1100010381], self.caster, target or self.owner, nil,"attack",-500*self.nCount)
end
