-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer60000021 = oo.class(BuffBase)
function Buffer60000021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer60000021:OnCreate(caster, target)
	-- 4811
	self:AddAttr(BufferEffect[4811], self.caster, target or self.owner, nil,"damage",0.01)
end
