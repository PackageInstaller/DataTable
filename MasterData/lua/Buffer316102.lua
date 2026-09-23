-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316102 = oo.class(BuffBase)
function Buffer316102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316102:OnCreate(caster, target)
	-- 316102
	self:AddAttr(BufferEffect[316102], self.caster, target or self.owner, nil,"defense",-12)
end
