-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100040014 = oo.class(BuffBase)
function Buffer1100040014:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100040014:OnCreate(caster, target)
	-- 1100040014
	self:AddAttrPercent(BufferEffect[1100040014], self.caster, target or self.owner, nil,"attack",0.2)
end
