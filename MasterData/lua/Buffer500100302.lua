-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer500100302 = oo.class(BuffBase)
function Buffer500100302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer500100302:OnCreate(caster, target)
	-- 5104
	self:AddAttrPercent(BufferEffect[5104], self.caster, target or self.owner, nil,"defense",-0.2)
end
