-- 受到傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000201 = oo.class(BuffBase)
function Buffer1000201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000201:OnCreate(caster, target)
	-- 1000201
	self:AddAttr(BufferEffect[1000201], self.caster, target or self.owner, nil,"bedamage",0.20)
end
