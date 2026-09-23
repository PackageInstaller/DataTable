-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100050040 = oo.class(BuffBase)
function Buffer1100050040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100050040:OnCreate(caster, target)
	-- 1100050040
	self:AddAttr(BufferEffect[1100050040], self.caster, target or self.owner, nil,"bedamage",0.01*self.nCount)
end
