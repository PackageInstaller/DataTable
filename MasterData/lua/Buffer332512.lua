-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332512 = oo.class(BuffBase)
function Buffer332512:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer332512:OnCreate(caster, target)
	-- 332512
	self:AddAttr(BufferEffect[332512], self.caster, target or self.owner, nil,"defense",-12)
end
