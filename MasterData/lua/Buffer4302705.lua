-- 全體退條
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302705 = oo.class(BuffBase)
function Buffer4302705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4302705:OnCreate(caster, target)
	-- 4302705
	self:AddAttr(BufferEffect[4302705], self.caster, target or self.owner, nil,"crit_rate",-0.20)
end
