-- 防禦弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4111 = oo.class(BuffBase)
function Buffer4111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4111:OnCreate(caster, target)
	-- 4111
	self:AddAttrPercent(BufferEffect[4111], self.caster, target or self.owner, nil,"defense",-0.05*self.nCount)
end
