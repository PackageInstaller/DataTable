-- 降低防禦buff（可疊加）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030061 = oo.class(BuffBase)
function Buffer1000030061:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030061:OnCreate(caster, target)
	-- 1000030061
	self:AddAttrPercent(BufferEffect[1000030061], self.caster, target or self.owner, nil,"defense",-0.16*self.nCount)
end
