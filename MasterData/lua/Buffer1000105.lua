-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000105 = oo.class(BuffBase)
function Buffer1000105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000105:OnCreate(caster, target)
	-- 1000105
	self:AddAttr(BufferEffect[1000105], self.caster, target or self.owner, nil,"damage",0.24)
end
