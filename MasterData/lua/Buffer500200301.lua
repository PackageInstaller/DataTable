-- 蜂刺
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer500200301 = oo.class(BuffBase)
function Buffer500200301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer500200301:OnCreate(caster, target)
	-- 5603
	self:AddAttr(BufferEffect[5603], self.caster, target or self.owner, nil,"resist",-0.15)
	-- 5903
	self:AddAttr(BufferEffect[5903], self.caster, target or self.owner, nil,"bedamage",0.15)
end
