-- 山脈機制buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101103 = oo.class(BuffBase)
function Buffer980101103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101103:OnCreate(caster, target)
	-- 980101103
	self:AddBuff(BufferEffect[980101103], self.caster, target or self.owner, nil,980101102)
end
