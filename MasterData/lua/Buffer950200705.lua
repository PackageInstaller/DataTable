-- 造成傷害減少20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer950200705 = oo.class(BuffBase)
function Buffer950200705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer950200705:OnCreate(caster, target)
	-- 5904
	self:AddAttr(BufferEffect[5904], self.caster, target or self.owner, nil,"bedamage",0.2)
end
