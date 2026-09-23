-- 輝耀降臨
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4803701 = oo.class(BuffBase)
function Buffer4803701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4803701:OnCreate(caster, target)
	-- 4803701
	self:AddAttr(BufferEffect[4803701], self.caster, target or self.owner, nil,"crit_rate",0.15)
	-- 4803702
	self:AddAttr(BufferEffect[4803702], self.caster, target or self.owner, nil,"bedamage",-0.15)
end
