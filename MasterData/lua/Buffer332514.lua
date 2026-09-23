-- 蠢動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332514 = oo.class(BuffBase)
function Buffer332514:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer332514:OnCreate(caster, target)
	-- 332514
	self:AddAttr(BufferEffect[332514], self.caster, target or self.owner, nil,"defense",-24)
end
