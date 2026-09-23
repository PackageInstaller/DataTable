-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316103 = oo.class(BuffBase)
function Buffer316103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316103:OnCreate(caster, target)
	-- 316103
	self:AddAttr(BufferEffect[316103], self.caster, target or self.owner, nil,"defense",-18)
end
