-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980110001 = oo.class(BuffBase)
function Buffer980110001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980110001:OnCreate(caster, target)
	-- 4018
	self:AddAttr(BufferEffect[4018], self.caster, target or self.owner, nil,"attack",250)
	-- 4119
	self:AddAttr(BufferEffect[4119], self.caster, target or self.owner, nil,"defense",-20)
end
