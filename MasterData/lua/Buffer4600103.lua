-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600103 = oo.class(BuffBase)
function Buffer4600103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4600103:OnCreate(caster, target)
	-- 4600103
	self:AddAttr(BufferEffect[4600103], self.caster, target or self.owner, nil,"crit",0.04)
end
