-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5006 = oo.class(BuffBase)
function Buffer5006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5006:OnCreate(caster, target)
	-- 5006
	self:AddAttrPercent(BufferEffect[5006], self.caster, target or self.owner, nil,"attack",-0.3)
end
