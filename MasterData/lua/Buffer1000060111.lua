-- 免疫：反攻
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060111 = oo.class(BuffBase)
function Buffer1000060111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060111:OnCreate(caster, target)
	-- 1000060111
	self:AddAttrPercent(BufferEffect[1000060111], self.caster, target or self.owner, nil,"resist",-1)
end
