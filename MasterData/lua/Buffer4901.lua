-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4901 = oo.class(BuffBase)
function Buffer4901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4901:OnCreate(caster, target)
	-- 4901
	self:AddAttr(BufferEffect[4901], self.caster, target or self.owner, nil,"bedamage",-0.05)
end
