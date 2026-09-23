-- 防禦減少40%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer55001033 = oo.class(BuffBase)
function Buffer55001033:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer55001033:OnCreate(caster, target)
	-- 5107
	self:AddAttrPercent(BufferEffect[5107], self.caster, target or self.owner, nil,"defense",-0.4)
end
