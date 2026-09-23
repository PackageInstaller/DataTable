-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070095 = oo.class(BuffBase)
function Buffer1100070095:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070095:OnCreate(caster, target)
	-- 6510
	self:AddAttrPercent(BufferEffect[6510], self.caster, target or self.owner, nil,"maxhp",0.5)
end
