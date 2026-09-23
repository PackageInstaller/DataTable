-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1040208 = oo.class(BuffBase)
function Buffer1040208:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1040208:OnCreate(caster, target)
	-- 1040208
	self:AddAttrPercent(BufferEffect[1040208], self.caster, target or self.owner, nil,"defense",-0.27)
end
