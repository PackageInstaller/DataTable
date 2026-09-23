-- 受到傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000215 = oo.class(BuffBase)
function Buffer1000215:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000215:OnCreate(caster, target)
	-- 1000215
	self:AddAttr(BufferEffect[1000215], self.caster, target or self.owner, nil,"bedamage",0.3)
end
