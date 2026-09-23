-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1040209 = oo.class(BuffBase)
function Buffer1040209:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1040209:OnCreate(caster, target)
	-- 1040209
	self:AddAttrPercent(BufferEffect[1040209], self.caster, target or self.owner, nil,"defense",-0.28)
end
