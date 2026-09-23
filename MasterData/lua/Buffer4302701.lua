-- 全體退條
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302701 = oo.class(BuffBase)
function Buffer4302701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4302701:OnCreate(caster, target)
	-- 4302701
	self:AddAttr(BufferEffect[4302701], self.caster, target or self.owner, nil,"crit_rate",-0.04)
end
